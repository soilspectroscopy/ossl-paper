
## Packages
library("tidyverse")

## Data
performance <- read_csv("https://github.com/soilspectroscopy/ossl-models/raw/main/out/fitted_models_performance_v1.2.csv")

# Transforming some original soil properties to log1p space
performance <- performance %>%
  mutate(rmse = ifelse(unit_transform == "original", log1p(rmse), rmse),
         bias = ifelse(unit_transform == "original", log1p(bias), bias))

## Tests
performance.metrics <- performance %>%
  select(rmse, bias, rsq, ccc, rpiq)

performance.pca <- prcomp(performance.metrics, center = TRUE, scale. = TRUE)
performance.pca
summary(performance.pca)
biplot(performance.pca)

ggplot(performance) +
  geom_point(aes(x = rsq, y = rpiq))

ggplot(performance) +
  geom_point(aes(x = rsq, y = rmse))

ggplot(performance) +
  geom_point(aes(x = rmse, y = ccc))

ggplot(performance) +
  geom_point(aes(x = rpiq, y = ccc))

library(plotly)
plot_ly(x=performance$ccc,
        y=performance$rpiq,
        z=performance$rmse,
        type="scatter3d", mode="markers", color=performance$ccc)

## Scatter plots of RPIQ x CCC

unique(performance$soil_property)

performance.analysis <- performance %>%
  separate(model_name,
           into = c("spectra", "model",
                    "subset", "geo",
                    "version"), sep = "_") %>%
  mutate(soil_group = case_when(soil_property %in% c("acidity_usda.a795_cmolc.kg",
                                                     "al.dith_usda.a65_w.pct",
                                                     "al.ext_usda.a1056_mg.kg",
                                                     "al.ext_usda.a69_cmolc.kg",
                                                     "al.ox_usda.a59_w.pct",
                                                     "b.ext_mel3_mg.kg",
                                                     "c.tot_usda.a622_w.pct",
                                                     "ca.ext_usda.a1059_mg.kg",
                                                     "ca.ext_usda.a722_cmolc.kg",
                                                     "caco3_usda.a54_w.pct",
                                                     "cec_usda.a723_cmolc.kg",
                                                     "cu.ext_usda.a1063_mg.kg",
                                                     "ec_usda.a364_ds.m",
                                                     "fe.dith_usda.a66_w.pct",
                                                     "fe.ox_usda.a60_w.pct",
                                                     "fe.ext_usda.a1064_mg.kg",
                                                     "k.ext_usda.a725_cmolc.kg",
                                                     "k.ext_usda.a1065_mg.kg",
                                                     "mg.ext_usda.a1066_mg.kg",
                                                     "mg.ext_usda.a724_cmolc.kg",
                                                     "mn.ext_usda.a1067_mg.kg",
                                                     "mn.ext_usda.a70_mg.kg",
                                                     "n.tot_usda.a623_w.pct",
                                                     "na.ext_usda.a1068_mg.kg",
                                                     "na.ext_usda.a726_cmolc.kg",
                                                     "oc_usda.c729_w.pct",
                                                     "p.ext_usda.a1070_mg.kg",
                                                     "p.ext_usda.a270_mg.kg",
                                                     "p.ext_usda.a274_mg.kg",
                                                     "ph.cacl2_usda.a481_index",
                                                     "ph.h2o_usda.a268_index",
                                                     "s.tot_usda.a624_w.pct",
                                                     "zn.ext_usda.a1073_mg.kg") ~ "Chemical",
                                soil_property %in% c("aggstb_usda.a1_w.pct",
                                                     "awc.33.1500kPa_usda.c80_w.frac",
                                                     "bd_usda.a4_g.cm3",
                                                     "cf_usda.c236_w.pct",
                                                     "clay.tot_usda.a334_w.pct",
                                                     "sand.tot_usda.c60_w.pct",
                                                     "silt.tot_usda.c62_w.pct",
                                                     "wr.1500kPa_usda.a417_w.pct",
                                                     "wr.33kPa_usda.a415_w.pct") ~ "Physical",
                                soil_property %in% c("nematodes",
                                                     "microbial biomass",
                                                     "soil respiration",
                                                     "enzyme activity",
                                                     "soil mesofauna",
                                                     "nematodes") ~ "Biological",
                                TRUE ~ NA_character_),
         .after = soil_property)

ggplot(performance.analysis) +
  geom_point(aes(x = rpiq, y = ccc, color = subset)) +
  geom_vline(xintercept = 2, linetype = 'dotted') +
  geom_hline(yintercept = 0.6, linetype = 'dotted') +
  labs(x = "RPIQ", y = "Lin's CCC", color = NULL) +
  theme_light() +
  theme(legend.position = "bottom")

ggplot(performance.analysis) +
  geom_point(aes(x = rpiq, y = ccc, color = spectra)) +
  geom_vline(xintercept = 2, linetype = 'dotted') +
  geom_hline(yintercept = 0.6, linetype = 'dotted') +
  theme_light() + labs(color = NULL) +
  theme(legend.position = "bottom")

ggplot(performance.analysis) +
  geom_point(aes(x = rpiq, y = ccc, color = soil_group)) +
  geom_vline(xintercept = 2, linetype = 'dotted') +
  geom_hline(yintercept = 0.6, linetype = 'dotted') +
  theme_light() + labs(color = NULL) +
  theme(legend.position = "bottom")
