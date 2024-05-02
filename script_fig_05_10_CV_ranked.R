
## Packages
library("tidyverse")
library("ggpattern")

## Data
performance <- read_csv("https://github.com/soilspectroscopy/ossl-models/raw/main/out/fitted_models_performance_v1.2.csv")

performance <- performance %>%
  select(-n, -unit_transform)

performance <- performance %>%
  mutate(info = model_name, .after = model_name) %>%
  mutate(info = gsub("cubist_|_na_v1.2", "", info)) %>%
  separate(info, into = c("spectra_type", "library"), sep = "_")

performance <- performance %>%
  filter(library == "ossl") %>%
  mutate(trust = ifelse(rpiq >= 2, "yes", "no"))

rank <- performance %>%
  filter(spectra_type == "mir") %>%
  arrange(ccc) %>%
  pull(soil_property)

labels <- performance %>%
  filter(spectra_type == "mir") %>%
  arrange(ccc) %>%
  pull(description)

# italic.labels <- ifelse(rank %in% c("aggstb_usda.a1_w.pct",
#                                     "awc.33.1500kPa_usda.c80_w.frac",
#                                     "bd_usda.a4_g.cm3",
#                                     "cf_usda.c236_w.pct",
#                                     "clay.tot_usda.a334_w.pct",
#                                     "sand.tot_usda.c60_w.pct",
#                                     "silt.tot_usda.c62_w.pct",
#                                     "wr.1500kPa_usda.a417_w.pct",
#                                     "wr.33kPa_usda.a415_w.pct"),
#                  paste0("bold(", rank, ")"),
#                  rank)

# reference.grid <- tibble(soil_property = rank) %>%
#   crossing(tibble(spectra_type = c("mir", "visnir", "nir.neospectra")))
# 
# performance <- left_join(reference.grid, performance,
#                          by = c("soil_property", "spectra_type")) %>%
#   mutate(ccc = replace_na(ccc, 0))

p.rank <- performance %>%
  mutate(soil_property = factor(soil_property, levels = rank)) %>%
  mutate(spectra_type = factor(spectra_type,
                               levels = rev(c("mir", "visnir", "nir.neospectra")))) %>%
  ggplot(aes(x = soil_property, y = ccc,
             fill = spectra_type, pattern = trust)) +
  geom_col_pattern(position = position_dodge(preserve = "single"),
                   pattern_color = 'gray70',
                   size = 0.1,
                   pattern_angle = 45,
                   pattern_density = 0.075,
                   pattern_spacing = 0.015,
                   pattern_key_scale_factor = 1,
                   show.legend = T) +
  scale_fill_manual(values = rev(c("darkblue", "salmon", "gold"))) +
  scale_pattern_manual(values = c(yes = "none", no = "stripe")) +
  scale_x_discrete(labels = labels) +
  labs(x = NULL, y = "Lin's CCC", fill = NULL) +
  coord_flip() +
  theme_light() +
  theme(legend.position = "bottom") +
  guides(pattern = "none"); p.rank

ggsave("outputs/plot_rank_10CV.png", p.rank,
       width = 5, height = 5, units = "in", dpi = 300, scale = 1.5)

ggsave("outputs/plot_rank_10CV.tiff", p.rank, compression = "lzw",
       width = 5, height = 5, units = "in", dpi = 300, scale = 1.5)

# Interpretation
performance %>%
  filter(spectra_type == "mir" & trust == "no") %>%
  View()

performance %>%
  filter(spectra_type == "visnir" & trust == "no") %>%
  View()

performance %>%
  filter(spectra_type == "nir.neospectra" & trust == "no") %>%
  View()

performance %>%
  filter(trust == "no") %>%
  count(description) %>%
  arrange(n)
