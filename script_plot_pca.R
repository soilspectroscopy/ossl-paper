
## Packages
library("tidyverse")
library("tidymodels")
library("qs")

options(timeout = 10000)

## Loading data
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

mir <- mir %>%
  filter(!is.na(scan_mir.1000_abs))

mir <- mir %>%
  select(all_of(spectral.columns.mir)) %>%
  as.matrix() %>%
  prospectr::standardNormalVariate() %>%
  as_tibble() %>%
  bind_cols({mir %>% select(dataset.code_ascii_txt)}, .)

mir <- mir %>%
  rename_with(~spectral.columns.mir.new, all_of(spectral.columns.mir))

mir %>%
  distinct(dataset.code_ascii_txt) %>%
  pull(dataset.code_ascii_txt)

mir <- mir %>%
  mutate(dataset.code_ascii_txt = recode(dataset.code_ascii_txt,
                                         "AFSIS1.SSL" = "AFSIS1",
                                         "AFSIS2.SSL" = "AFSIS2",
                                         "CAF.SSL" = "CAF",
                                         "ICRAF.ISRIC" = "ICRAF-ISRIC",
                                         "KSSL.SSL" = "KSSL",
                                         "LUCAS.WOODWELL.SSL" = "LUCAS",
                                         "GARRETT.SSL" = "Garrett",
                                         "SCHIEDUNG.SSL" = "Schiedung",
                                         "SERBIA.SSL" = "Serbia",
                                         )) %>%
  mutate(dataset.code_ascii_txt = factor(dataset.code_ascii_txt,
                                         levels = c("KSSL", "ICRAF-ISRIC",
                                                    "AFSIS1", "AFSIS2",
                                                    "CAF", "LUCAS",
                                                    "Schiedung", "Garrett",
                                                    "Serbia")))

mir.pca.model <- mir %>%
  recipe() %>%
  update_role(everything()) %>%
  update_role("dataset.code_ascii_txt", new_role = "id") %>%
  step_normalize(all_predictors(), id = "normalization") %>%
  step_pca(all_predictors(), num_comp = 4, id = "pca") %>%
  prep()

mir.pca.scores <- juice(mir.pca.model) %>%
  rename_at(vars(starts_with("PC")), ~paste0("PC", as.numeric(gsub("PC", "", .))))

mir.pca.scores <- mir.pca.scores %>%
  mutate(dataset.code_ascii_txt = factor(dataset.code_ascii_txt,
                                         levels = c("KSSL", "ICRAF-ISRIC",
                                                    "AFSIS1", "AFSIS2",
                                                    "CAF", "LUCAS",
                                                    "Schiedung", "Garrett",
                                                    "Serbia")))

mir.pca.variance <- tidy(mir.pca.model, id = "pca", type = "variance") %>%
  select(-id)

mir.pca.xve <- mir.pca.variance %>%
  filter(terms == "percent variance") %>%
  filter(component <= 4) %>%
  mutate(value = round(value, 2)) %>%
  pull(value)

p.mir.scores.pc1.pc2 <- mir.pca.scores %>%
  ggplot(aes(x = PC1, y = PC2, color = dataset.code_ascii_txt)) +
  geom_point(size = 0.5, alpha = 0.25) +
  scale_color_manual(values = c("black", "blue",
                                "salmon", "orange",
                                "red", "yellow",
                                "green", "purple", "lightblue")) +
  # xlim(-100,100) + ylim(-100,100) +
  labs(x = paste0("PC1 (", mir.pca.xve[1], "%)"),
       y = paste0("PC2 (", mir.pca.xve[2], "%)"),
       color = NULL) +
  theme_light() +
  theme(legend.position = "bottom"); p.mir.scores.pc1.pc2

ggsave("outputs/plot_pca_scores_mir_ossl.png",
       p.mir.scores.pc1.pc2, dpi = 300, width = 8, height = 6,
       units = "in", scale = 0.75)

############
## VisNIR ##
############

spectral.columns.visnir <- visnir %>%
  select(starts_with("scan_visnir")) %>%
  names()

spectral.columns.visnir.new <- gsub("scan_visnir\\.|_ref", "", spectral.columns.visnir)
spectral.columns.visnir.new.range <- as.character(seq(400, 2500, by = 2))

visnir <- visnir %>%
  filter(!is.na(scan_visnir.1000_ref))

visnir <- visnir %>%
  rename_with(~spectral.columns.visnir.new, all_of(spectral.columns.visnir)) %>%
  select(dataset.code_ascii_txt, all_of(spectral.columns.visnir.new.range))

visnir <- visnir %>%
  select(all_of(spectral.columns.visnir.new)) %>%
  as.matrix() %>%
  prospectr::standardNormalVariate() %>%
  as_tibble() %>%
  bind_cols({visnir %>% select(dataset.code_ascii_txt)}, .)

visnir %>%
  distinct(dataset.code_ascii_txt) %>%
  pull(dataset.code_ascii_txt)

visnir <- visnir %>%
  mutate(dataset.code_ascii_txt = recode(dataset.code_ascii_txt,
                                         "ICRAF.ISRIC" = "ICRAF-ISRIC",
                                         "KSSL.SSL" = "KSSL",
                                         "LUCAS.SSL" = "LUCAS",
                                         "LUCAS.WOODWELL.SSL" = "LUCAS")) %>%
  mutate(dataset.code_ascii_txt = factor(dataset.code_ascii_txt,
                                         levels = c("LUCAS",
                                                    "KSSL",
                                                    "ICRAF-ISRIC")))

visnir.pca.model <- visnir %>%
  recipe() %>%
  update_role(everything()) %>%
  update_role("dataset.code_ascii_txt", new_role = "id") %>%
  step_normalize(all_predictors(), id = "normalization") %>%
  step_pca(all_predictors(), num_comp = 4, id = "pca") %>%
  prep()

visnir.pca.scores <- juice(visnir.pca.model) %>%
  rename_at(vars(starts_with("PC")), ~paste0("PC", as.numeric(gsub("PC", "", .))))

visnir.pca.scores <- visnir.pca.scores %>%
  mutate(dataset.code_ascii_txt = factor(dataset.code_ascii_txt,
                                         levels = c("LUCAS",
                                                    "KSSL",
                                                    "ICRAF-ISRIC")))

visnir.pca.variance <- tidy(visnir.pca.model, id = "pca", type = "variance") %>%
  select(-id)

visnir.pca.xve <- visnir.pca.variance %>%
  filter(terms == "percent variance") %>%
  filter(component <= 4) %>%
  mutate(value = round(value, 2)) %>%
  pull(value)

p.visnir.scores.pc1.pc2 <- visnir.pca.scores %>%
  ggplot(aes(x = PC1, y = PC2, color = dataset.code_ascii_txt)) +
  geom_point(size = 0.5, alpha = 0.15) +
  scale_color_manual(values = c("blue", "gold", "red")) +
  # xlim(-100,100) + ylim(-100,100) +
  labs(x = paste0("PC1 (", visnir.pca.xve[1], "%)"),
       y = paste0("PC2 (", visnir.pca.xve[2], "%)"),
       color = NULL) +
  theme_light() +
  theme(legend.position = "bottom"); p.visnir.scores.pc1.pc2

ggsave("outputs/plot_pca_scores_visnir_ossl.png",
       p.visnir.scores.pc1.pc2, dpi = 300, width = 8, height = 6,
       units = "in", scale = 0.75)


#####################
## NIR Nesospectra ##
#####################

spectral.columns.nir <- nir %>%
  select(starts_with("scan_nir")) %>%
  names()

spectral.columns.nir.new <- gsub("scan_nir\\.|_ref", "", spectral.columns.nir)

nir <- nir %>%
  filter(!is.na(scan_nir.1500_ref))

nir <- nir %>%
  rename_with(~spectral.columns.nir.new, all_of(spectral.columns.nir)) %>%
  mutate(dataset.code_ascii_txt = "Neospectra", .before = 1)

nir <- nir %>%
  select(all_of(spectral.columns.nir.new)) %>%
  as.matrix() %>%
  prospectr::standardNormalVariate() %>%
  as_tibble() %>%
  bind_cols({nir %>% select(dataset.code_ascii_txt)}, .)

nir %>%
  distinct(dataset.code_ascii_txt) %>%
  pull(dataset.code_ascii_txt)

nir.pca.model <- nir %>%
  recipe() %>%
  update_role(everything()) %>%
  update_role("dataset.code_ascii_txt", new_role = "id") %>%
  step_normalize(all_predictors(), id = "normalization") %>%
  step_pca(all_predictors(), num_comp = 4, id = "pca") %>%
  prep()

nir.pca.scores <- juice(nir.pca.model) %>%
  rename_at(vars(starts_with("PC")), ~paste0("PC", as.numeric(gsub("PC", "", .))))

nir.pca.variance <- tidy(nir.pca.model, id = "pca", type = "variance") %>%
  select(-id)

nir.pca.xve <- nir.pca.variance %>%
  filter(terms == "percent variance") %>%
  filter(component <= 4) %>%
  mutate(value = round(value, 2)) %>%
  pull(value)

p.nir.scores.pc1.pc2 <- nir.pca.scores %>%
  ggplot(aes(x = PC1, y = PC2, color = dataset.code_ascii_txt)) +
  geom_point(size = 0.5, alpha = 0.25) +
  scale_color_manual(values = c("blue")) +
  labs(x = paste0("PC1 (", nir.pca.xve[1], "%)"),
       y = paste0("PC2 (", nir.pca.xve[2], "%)"),
       color = NULL) +
  theme_light() +
  theme(legend.position = "bottom"); p.nir.scores.pc1.pc2

ggsave("outputs/plot_pca_scores_nir_ossl.png",
       p.nir.scores.pc1.pc2, dpi = 300, width = 8, height = 6,
       units = "in", scale = 0.75)
