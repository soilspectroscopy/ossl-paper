
## Packages
library("tidyverse")
library("qs")
library("xtable")

options(timeout = 1000)

## Data
all.level0 <- "https://storage.googleapis.com/soilspec4gg-public/ossl_all_L0_v1.2.qs"
all.level0 <- qread_url(all.level0)

neospectra <- "https://storage.googleapis.com/soilspec4gg-public/neospectra_nir_v1.2.qs"
neospectra <- qread_url(neospectra)

## Spectral counts
mir.count <- all.level0 %>%
  mutate(available_mir = !is.na(scan_mir.1000_abs)) %>%
  count(dataset.code_ascii_txt, available_mir) %>%
  filter(available_mir) %>%
  select(-available_mir) %>%
  rename(mir = n)

mir.count

visnir.count <- all.level0 %>%
  mutate(available_visnir = !is.na(scan_visnir.1000_ref)) %>%
  count(dataset.code_ascii_txt, available_visnir) %>%
  filter(available_visnir) %>%
  select(-available_visnir) %>%
  rename(visnir = n)

visnir.count

neospectra.count <- neospectra %>%
  group_by(id.sample_local_c) %>%
  summarise(scan_nir.1500_ref = mean(scan_nir.1500_ref)) %>%
  mutate(available_neospectra = !is.na(scan_nir.1500_ref)) %>%
  mutate(dataset.code_ascii_txt = "NEOSPECTRA") %>%
  count(dataset.code_ascii_txt, available_neospectra) %>%
  filter(available_neospectra) %>%
  select(-available_neospectra) %>%
  rename(nir = n)

neospectra.count

## Final table
final.count <- full_join(visnir.count, mir.count, by = "dataset.code_ascii_txt") %>%
  full_join(neospectra.count, by = "dataset.code_ascii_txt")

final.count <- final.count %>%
  mutate(dataset.code_ascii_txt = gsub("\\.SSL", "", dataset.code_ascii_txt)) %>%
  mutate(dataset.code_ascii_txt = gsub("\\.", "-", dataset.code_ascii_txt))

final.count

write_csv(final.count, "outputs/table1_source_and_spectra_count.csv")

print(xtable(final.count))
