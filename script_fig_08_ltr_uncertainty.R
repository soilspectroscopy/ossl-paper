
library("tidyverse")
library("yardstick")

## Loading data

list.files("predictions/")

plsr.kssl <- read_csv("predictions/LTR-MIR_ossl_pred_oc_usda.c729_w.pct..mir_plsr_ossl_na_v1.2_kssl-subset.csv")

plsr.kssl <- plsr.kssl %>%
  select(Woodwell.ID, oc_usda.c729_w.pct, lower_PI95, upper_PI95) %>%
  mutate(PI95_width = upper_PI95-lower_PI95,
         .after = upper_PI95) %>%
  mutate(model = "plsr", test = "kssl", .before = 1)

plsr.woodwell <- read_csv("predictions/LTR-MIR_ossl_pred_oc_usda.c729_w.pct..mir_plsr_ossl_na_v1.2_woodwell-subset.csv")

plsr.woodwell <- plsr.woodwell %>%
  select(Woodwell.ID, oc_usda.c729_w.pct, lower_PI95, upper_PI95) %>%
  mutate(PI95_width = upper_PI95-lower_PI95,
         .after = upper_PI95) %>%
  mutate(model = "plsr", test = "woodwell", .before = 1)

cubist.kssl <- read_csv("predictions/LTR-MIR_ossl_pred_oc_usda.c729_w.pct..mir_cubist_ossl_na_v1.2_kssl-subset.csv")

cubist.kssl <- cubist.kssl %>%
  select(Woodwell.ID, oc_usda.c729_w.pct, lower_PI95, upper_PI95) %>%
  mutate(PI95_width = upper_PI95-lower_PI95,
         .after = upper_PI95) %>%
  mutate(model = "cubist", test = "kssl", .before = 1)

cubist.woodwell <- read_csv("predictions/LTR-MIR_ossl_pred_oc_usda.c729_w.pct..mir_cubist_ossl_na_v1.2_woodwell-subset.csv")

cubist.woodwell <- cubist.woodwell %>%
  select(Woodwell.ID, oc_usda.c729_w.pct, lower_PI95, upper_PI95) %>%
  mutate(PI95_width = upper_PI95-lower_PI95,
         .after = upper_PI95) %>%
  mutate(model = "cubist", test = "woodwell", .before = 1)

plot.data <- bind_rows(plsr.kssl,
                      plsr.woodwell,
                      cubist.kssl,
                      cubist.woodwell) %>%
  rename(predicted = oc_usda.c729_w.pct)

# Reference data
soillab <- read_csv("predictions/LTR-MIR_ossl_LTR_soillab.csv", show_col_types = FALSE)

soillab <- soillab %>%
  select(Woodwell.ID, soc.observed) %>%
  rename(observed = soc.observed)

plot.data <- left_join(plot.data, soillab, by = "Woodwell.ID") %>%
  relocate(observed, .before = predicted) %>%
  mutate(observed = as.numeric(observed))

plot.data <- plot.data %>%
  mutate(test = recode(test,
                       "kssl" = "KSSL spectra",
                       "woodwell" = "Woodwell spectra"))

# Visualizations

plot.data.summary <- plot.data %>%
  group_by(model, test) %>%
  summarise(n = n(),
            rmse = rmse_vec(truth = observed, estimate = predicted),
            ccc = ccc_vec(truth = observed, estimate = predicted, bias = T),
            median_PI95_width = median(PI95_width),
            coverage = sum(ifelse(observed >= lower_PI95 & observed <= upper_PI95,
                                        1, NA), na.rm = T)/n()*100,
            .groups = "drop")

perfomance.annotation <- plot.data.summary %>%
  mutate(label = paste0(" Lin's CCC = ", round(ccc, 2),
                        "\n RMSE = ", round(rmse, 2),
                        "\n Median width = ", round(median_PI95_width, 2),
                        "\n Coverage (%) = ", round(coverage, 2), "%",
                        "\n N = ", n)) %>%
  select(model, test, label)

p.ltr <- plot.data %>%
  ggplot() +
  geom_point(aes(x = observed, y = predicted),
             color = "red", size = 0.5, alpha = 0.5) +
  geom_linerange(aes(x = observed, y = predicted, ymin = lower_PI95, ymax = upper_PI95),
                 linewidth = 0.25, alpha = 0.5) +
  geom_abline(intercept = 0, slope = 1) +
  geom_text(data = perfomance.annotation,
            aes(x = -Inf, y = Inf, hjust = 0, vjust = 1.2, label = label),
            size = 3) +
  labs(x = "Observed SOC (%)", y = "Predicted SOC (%)") +
  facet_grid(test~model) +
  theme_light(); p.ltr

ggsave("outputs/plot_ltr_conformal_prediction_ossl.png", p.ltr,
       width = 4.5, height = 3, units = "in", dpi = 300, scale = 1.5)

ggsave("outputs/plot_ltr_conformal_prediction_ossl.tiff", p.ltr, compression = "lzw",
       width = 4.5, height = 3, units = "in", dpi = 300, scale = 1.5)
