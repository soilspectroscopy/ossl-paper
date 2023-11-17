
## Packages
library("tidyverse")

## Data
performance <- read_csv("https://github.com/soilspectroscopy/ossl-models/raw/main/out/fitted_models_performance_v1.2.csv")

performance <- performance %>%
  select(-description, -n, -unit_transform)

performance <- performance %>%
  mutate(info = model_name, .after = model_name) %>%
  mutate(info = gsub("cubist_|_na_v1.2", "", info)) %>%
  separate(info, into = c("spectra_type", "library"), sep = "_")

performance <- performance %>%
  filter(library == "ossl")

rank <- performance %>%
  filter(spectra_type == "mir") %>%
  arrange(ccc) %>%
  pull(soil_property)

italic.labels <- ifelse(rank %in% c("aggstb_usda.a1_w.pct",
                                    "awc.33.1500kPa_usda.c80_w.frac",
                                    "bd_usda.a4_g.cm3",
                                    "cf_usda.c236_w.pct",
                                    "clay.tot_usda.a334_w.pct",
                                    "sand.tot_usda.c60_w.pct",
                                    "silt.tot_usda.c62_w.pct",
                                    "wr.1500kPa_usda.a417_w.pct",
                                    "wr.33kPa_usda.a415_w.pct"),
                 paste0("bold(", rank, ")"),
                 rank)

reference.grid <- tibble(soil_property = rank) %>%
  crossing(tibble(spectra_type = c("mir", "visnir", "nir.neospectra")))

performance <- left_join(reference.grid, performance,
                         by = c("soil_property", "spectra_type")) %>%
  mutate(ccc = replace_na(ccc, 0))

p.rank <- performance %>%
  mutate(soil_property = factor(soil_property, levels = rank)) %>%
  mutate(spectra_type = factor(spectra_type,
                               levels = rev(c("mir", "visnir", "nir.neospectra")))) %>%
  ggplot(aes(x = soil_property, y = ccc)) +
  geom_col(aes(fill = spectra_type), position = "dodge2") +
  scale_fill_manual(values = rev(c("darkblue", "salmon", "gold"))) +
  scale_x_discrete(labels = parse(text = italic.labels)) +
  labs(x = NULL, y = "Lin's CCC", fill = NULL) +
  coord_flip() +
  theme_light() + theme(legend.position = "bottom"); p.rank

ggsave("outputs/plot_rank_10CV.png", p.rank,
       width = 4, height = 5, units = "in", dpi = 300, scale = 1.5)
