
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

# Remving categorical effervescence. row 19
soil.properties <- soil.properties[-19]
soil.properties

ossl.summary <- ossl %>%
  select(dataset.code_ascii_txt, all_of(soil.properties),
         scan_mir.1500_abs, scan_visnir.1500_ref, scan_nir.1500_ref)

## Datasets
datasets <- c("OSSL")

## Modeling combinations
modeling.combinations <- tibble(soil_property = soil.properties) %>%
  crossing(dataset = datasets) %>%
  crossing(tibble(spectra = c("scan_mir.1500_abs",
                              "scan_visnir.1500_ref",
                              "scan_nir.1500_ref")))

modeling.combinations

## Stats

i=1
f_stats <- function(i) {
  
  isoil.property <- modeling.combinations[[i,"soil_property"]]
  idataset <- modeling.combinations[[i,"dataset"]]
  ispectra <- modeling.combinations[[i,"spectra"]]
  
  # Summary statistics
  ossl.summary %>%
    filter(!is.na(!!as.name(isoil.property))) %>%
    filter(!is.na(!!as.name(ispectra))) %>%
    reframe(result = quantile(!!as.name(isoil.property),
                              probs = c(0.00, 0.25, 0.50, 0.75, 1.00)),
            count = n(),
            q = c(0.00, 0.25, 0.50, 0.75, 1.00)) %>%
    mutate(q = paste0("quantile_", q)) %>%
    pivot_wider(names_from = q, values_from = result)
  
}

## Applying f_count with parallelization
doFuture::registerDoFuture()
future::plan("multisession")
options(future.globals.maxSize = 1000 * 1024^2)

stats.list <- foreach(i = 1:nrow(modeling.combinations),
                      .combine = rbind) %dopar% {
                        f_stats(i)
                      }

## Exporting results
final.stats <- modeling.combinations %>%
  bind_cols(stats.list) %>%
  mutate(spectra = recode(spectra,
                          "scan_mir.1500_abs" = "MIR",
                          "scan_visnir.1500_ref" = "VisNIR",
                          "scan_nir.1500_ref" = "NIR")) %>%
  mutate(dataset = gsub("\\.SSL", "", dataset))

export <- final.stats %>%
  rename(n = count,
         min = quantile_0,
         Q1 = quantile_0.25,
         median = quantile_0.5,
         Q3 = quantile_0.75,
         max = quantile_1)

export <- export %>%
  mutate(across(c(min, Q1, median, Q3, max), \(x) round(x, 2))) %>% # Rounding
  replace(is.na(.), 0) # Replacing NA

# description <- soil.selection %>%
#   select(soil_property, description)
# 
# export <- left_join(export, description, by = "soil_property") %>%
#   relocate(description, .after = soil_property)

write_csv(export, "outputs/table3_soil_properties_stats.csv")

# export <- export %>%
#   select(-description)

# print(xtable(export), include.rownames=FALSE)
