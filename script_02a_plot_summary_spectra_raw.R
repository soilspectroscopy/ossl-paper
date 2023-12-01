
library("tidyverse")
library("qs") # >=0.25.5

options(timeout = 10000)

# Loading data

mir <- "https://storage.googleapis.com/soilspec4gg-public/ossl_mir_L0_v1.2.qs"
mir <- qread_url(mir)

visnir <- "https://storage.googleapis.com/soilspec4gg-public/ossl_visnir_L0_v1.2.qs"
visnir <- qread_url(visnir)

nir <- "https://storage.googleapis.com/soilspec4gg-public/neospectra_nir_v1.2.qs"
nir <- qread_url(nir)

#########
## MIR ##
#########

spectral.columns.mir <- mir %>%
  select(starts_with("scan_mir")) %>%
  names()

spectral.columns.mir.new <- gsub("scan_mir\\.|_abs", "", spectral.columns.mir)

# Min
mir.stats.min <- mir %>%
  filter(!is.na(scan_mir.1000_abs)) %>%
  select(all_of(c("dataset.code_ascii_txt", spectral.columns.mir))) %>%
  summarise(across(all_of(spectral.columns.mir), min, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "OSSL",
         stats = "min", .before = 1) %>%
  rename_with(~spectral.columns.mir.new, all_of(spectral.columns.mir))

mir.stats.min

# Max
mir.stats.max <- mir %>%
  filter(!is.na(scan_mir.1000_abs)) %>%
  select(all_of(c("dataset.code_ascii_txt", spectral.columns.mir))) %>%
  summarise(across(all_of(spectral.columns.mir), max, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "OSSL",
         stats = "max", .before = 1) %>%
  rename_with(~spectral.columns.mir.new, all_of(spectral.columns.mir))

mir.stats.max

# Grouped mean
mir.stats.mean <- mir %>%
  filter(!is.na(scan_mir.1000_abs)) %>%
  select(all_of(c("dataset.code_ascii_txt", spectral.columns.mir))) %>%
  group_by(dataset.code_ascii_txt) %>%
  summarise(across(all_of(spectral.columns.mir), mean, na.rm = TRUE)) %>%
  mutate(stats = "mean", .after = 1) %>%
  rename_with(~spectral.columns.mir.new, all_of(spectral.columns.mir)) %>%
  mutate(dataset.code_ascii_txt = gsub("\\.SSL", "", dataset.code_ascii_txt))
  
mir.stats.mean <- mir.stats.mean %>%
  pivot_longer(all_of(spectral.columns.mir.new),
               names_to = "wavenumber", values_to = "intensity") %>%
  mutate(wavenumber = as.numeric(wavenumber))
  
# Visualization
mir.stats.min.max <- bind_rows(mir.stats.min, mir.stats.max)

mir.stats.min.max <- mir.stats.min.max %>%
  pivot_longer(all_of(spectral.columns.mir.new),
               names_to = "wavenumber", values_to = "intensity") %>%
  pivot_wider(names_from = stats, values_from = intensity) %>%
  mutate(wavenumber = as.numeric(wavenumber))

p.mir <- ggplot(mir.stats.min.max, aes(x = wavenumber, group = dataset.code_ascii_txt)) +
  geom_ribbon(aes(ymax = max, ymin = min), fill = "grey", alpha=0.5) +
  geom_line(data = mir.stats.mean,
            aes(x = wavenumber, y = intensity,
                group = dataset.code_ascii_txt),
            linewidth = 0.5, show.legend = F) +
  scale_x_continuous(trans = "reverse") +
  labs(x = bquote("Wavenumber ("*cm^-1*")"), y = "Pseudo absorbance (log10 units)",
       color = NULL) +
  theme_light() + theme(legend.position = "bottom"); p.mir

ggsave("outputs/plot_spectra_mir_raw.png", p.mir,
       dpi = 300, width = 5, height = 4, scale = 1)

############
## VISNIR ##
############

spectral.columns.visnir <- visnir %>%
  select(starts_with("scan_visnir")) %>%
  select(-c(1:25)) %>%
  names()
  
spectral.columns.visnir.new <- gsub("scan_visnir\\.|_ref", "", spectral.columns.visnir)

# Min
visnir.stats.min <- visnir %>%
  filter(!is.na(scan_visnir.1000_ref)) %>%
  select(all_of(c("dataset.code_ascii_txt", spectral.columns.visnir))) %>%
  summarise(across(all_of(spectral.columns.visnir), min, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "OSSL",
         stats = "min", .before = 1) %>%
  rename_with(~spectral.columns.visnir.new, all_of(spectral.columns.visnir))

visnir.stats.min

# Max
visnir.stats.max <- visnir %>%
  filter(!is.na(scan_visnir.1000_ref)) %>%
  select(all_of(c("dataset.code_ascii_txt", spectral.columns.visnir))) %>%
  summarise(across(all_of(spectral.columns.visnir), max, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "OSSL",
         stats = "max", .before = 1) %>%
  rename_with(~spectral.columns.visnir.new, all_of(spectral.columns.visnir))

visnir.stats.max

# Grouped mean
visnir.stats.mean <- visnir %>%
  filter(!is.na(scan_visnir.1000_ref)) %>%
  select(all_of(c("dataset.code_ascii_txt", spectral.columns.visnir))) %>%
  group_by(dataset.code_ascii_txt) %>%
  summarise(across(all_of(spectral.columns.visnir), mean, na.rm = TRUE)) %>%
  mutate(stats = "mean", .after = 1) %>%
  rename_with(~spectral.columns.visnir.new, all_of(spectral.columns.visnir)) %>%
  mutate(dataset.code_ascii_txt = gsub("\\.SSL", "", dataset.code_ascii_txt))

visnir.stats.mean <- visnir.stats.mean %>%
  pivot_longer(all_of(spectral.columns.visnir.new),
               names_to = "wavelength", values_to = "intensity") %>%
  mutate(wavelength = as.numeric(wavelength))

# Visualization
visnir.stats.min.max <- bind_rows(visnir.stats.min, visnir.stats.max)

visnir.stats.min.max <- visnir.stats.min.max %>%
  pivot_longer(all_of(spectral.columns.visnir.new),
               names_to = "wavelength", values_to = "intensity") %>%
  pivot_wider(names_from = stats, values_from = intensity) %>%
  mutate(wavelength = as.numeric(wavelength))

p.visnir <- ggplot(visnir.stats.min.max, aes(x = wavelength, group = dataset.code_ascii_txt)) +
  geom_ribbon(aes(ymax = max, ymin = min), fill = "grey", alpha=0.5) +
  geom_line(data = visnir.stats.mean,
            aes(x = wavelength, y = intensity,
                group = dataset.code_ascii_txt),
            linewidth = 0.5, show.legend = F) +
  labs(x = bquote("Wavelength (nm)"), y = "Reflectance factor",
       color = NULL) +
  theme_light() + theme(legend.position = "bottom"); p.visnir

ggsave("outputs/plot_spectra_visnir_raw.png", p.visnir,
       dpi = 300, width = 5, height = 4, scale = 1)

####################
## NIR-NEOSPECTRA ##
####################

spectral.columns.nir <- nir %>%
  select(starts_with("scan_nir")) %>%
  names()

spectral.columns.nir.new <- gsub("scan_nir\\.|_ref", "", spectral.columns.nir)

# Min
nir.stats.min <- nir %>%
  filter(!is.na(scan_nir.1500_ref)) %>%
  select(all_of(spectral.columns.nir)) %>%
  summarise(across(all_of(spectral.columns.nir), min, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "Neospectra",
         stats = "min", .before = 1) %>%
  rename_with(~spectral.columns.nir.new, all_of(spectral.columns.nir))

nir.stats.min

# Max
nir.stats.max <- nir %>%
  filter(!is.na(scan_nir.1500_ref)) %>%
  select(all_of(spectral.columns.nir)) %>%
  summarise(across(all_of(spectral.columns.nir), max, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "Neospectra",
         stats = "max", .before = 1) %>%
  rename_with(~spectral.columns.nir.new, all_of(spectral.columns.nir))

nir.stats.max

# Mean
nir.stats.mean <- nir %>%
  filter(!is.na(scan_nir.1500_ref)) %>%
  select(all_of(spectral.columns.nir)) %>%
  summarise(across(all_of(spectral.columns.nir), mean, na.rm = TRUE)) %>%
  mutate(dataset.code_ascii_txt = "Neospectra",
         stats = "mean", .before = 1) %>%
  rename_with(~spectral.columns.nir.new, all_of(spectral.columns.nir))

nir.stats.mean

nir.stats.mean <- nir.stats.mean %>%
  pivot_longer(all_of(spectral.columns.nir.new),
               names_to = "wavelength", values_to = "intensity") %>%
  mutate(wavelength = as.numeric(wavelength))

# Visualization
nir.stats.min.max <- bind_rows(nir.stats.min, nir.stats.max)

nir.stats.min.max <- nir.stats.min.max %>%
  pivot_longer(all_of(spectral.columns.nir.new),
               names_to = "wavelength", values_to = "intensity") %>%
  pivot_wider(names_from = stats, values_from = intensity) %>%
  mutate(wavelength = as.numeric(wavelength))

p.nir <- ggplot(nir.stats.min.max, aes(x = wavelength, group = dataset.code_ascii_txt)) +
  geom_ribbon(aes(ymax = max, ymin = min), fill = "grey", alpha=0.5) +
  geom_line(data = nir.stats.mean,
            aes(x = wavelength, y = intensity,
                group = dataset.code_ascii_txt),
            linewidth = 0.5, show.legend = F) +
  labs(x = bquote("Wavelength (nm)"), y = "Reflectance factor",
       color = NULL) +
  theme_light() + theme(legend.position = "bottom"); p.nir

ggsave("outputs/plot_spectra_nir_raw.png", p.nir,
       dpi = 300, width = 5, height = 4, scale = 1)
