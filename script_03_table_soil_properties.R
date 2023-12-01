
## Packages
library("tidyverse")
library("doFuture")
library("qs")
library("xtable")

options(timeout = 1000)

## Data
all.level1 <- "https://storage.googleapis.com/soilspec4gg-public/ossl_all_L1_v1.2.qs"
all.level1 <- qread_url(all.level1)

neospectra <- "https://storage.googleapis.com/soilspec4gg-public/neospectra_nir_v1.2.qs"
neospectra <- qread_url(neospectra)

###################
##### Summary #####
###################

nir.neospectra <- neospectra %>%
  select(id.sample_local_c, starts_with("scan_nir")) %>%
  group_by(id.sample_local_c) %>%
  summarise_all(mean)

ossl <- all.level1 %>%
  mutate(temp_id = gsub("XS|XN", "", id.scan_local_c)) %>%
  left_join(nir.neospectra, by = c("temp_id" = "id.sample_local_c")) %>%
  select(-temp_id)

## Overview and preparation
ossl %>%
  select(scan_mir.1500_abs, scan_visnir.1500_ref, scan_nir.1500_ref) %>%
  summarise_all(~sum(!is.na(.)))

## Soil lab level 1
soil.selection <- read_csv("https://github.com/soilspectroscopy/ossl-models/raw/main/out/ossl_models_soil_properties.csv")

soil.properties <- soil.selection %>%
  filter(include) %>%
  pull(soil_property)

ossl.count <- ossl %>%
  select(dataset.code_ascii_txt, all_of(soil.properties), scan_mir.1500_abs,
         scan_visnir.1500_ref, scan_nir.1500_ref)

## Datasets
datasets <- c("OSSL", "KSSL.SSL")

## Modeling combinations
modeling.combinations <- tibble(soil_property = soil.properties) %>%
  crossing(dataset = datasets) %>%
  crossing(tibble(spectra = c("scan_mir.1500_abs",
                              "scan_visnir.1500_ref",
                              "scan_nir.1500_ref")))

modeling.combinations

## Count

f_count <- function(i) {
  
  isoil.property <- modeling.combinations[[i,"soil_property"]]
  idataset <- modeling.combinations[[i,"dataset"]]
  ispectra <- modeling.combinations[[i,"spectra"]]
  
  if(idataset == "OSSL") {
    
    ossl.count %>%
      filter(!is.na(!!as.name(isoil.property))) %>%
      filter(!is.na(!!as.name(ispectra))) %>%
      nrow()
    
  } else {
    
    ossl.count %>%
      filter(dataset.code_ascii_txt == idataset) %>%
      filter(!is.na(!!as.name(isoil.property))) %>%
      filter(!is.na(!!as.name(ispectra))) %>%
      nrow()
    
  }
  
  # cat(paste0("Run ", i, "/", nrow(modeling.combinations), "\n"))
  
}

## Applying f_count with parallelization

doFuture::registerDoFuture()
future::plan("multisession")
options(future.globals.maxSize = 1000 * 1024^2)

count.list <- foreach(i = 1:nrow(modeling.combinations),
                      .combine = c) %dopar% {
                        f_count(i)
                      }

## Exporting results
final.counts <- modeling.combinations %>%
  mutate(count = count.list) %>%
  mutate(spectra = recode(spectra,
                          "scan_mir.1500_abs" = "MIR",
                          "scan_visnir.1500_ref" = "VisNIR",
                          "scan_nir.1500_ref" = "NIR")) %>%
  mutate(dataset = gsub("\\.SSL", "", dataset))

export <- final.counts %>%
  mutate(comb = paste(dataset, spectra, sep = "_")) %>%
  select(-dataset, -spectra) %>%
  filter(!(comb == "KSSL_NIR")) %>%
  pivot_wider(names_from = "comb", values_from = "count") %>%
  select(soil_property, KSSL_VisNIR, KSSL_MIR, OSSL_VisNIR, OSSL_NIR, OSSL_MIR)

description <- soil.selection %>%
  select(soil_property, description)

export <- left_join(export, description, by = "soil_property") %>%
  relocate(description, .after = soil_property)

write_csv(export, "outputs/table2_soil_properties_count.csv")

# export <- export %>%
#   select(-description)

print(xtable(export), include.rownames=FALSE)
