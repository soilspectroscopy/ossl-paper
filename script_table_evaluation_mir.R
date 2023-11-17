
library("tidyverse")
library("xtable")

plsr <- read_csv("performance/mir_final_performance_original_plsr.csv")
cubist <- read_csv("performance/mir_final_performance_original_cubist.csv")

plsr <- plsr %>%
  mutate(model_type = "plsr", .before = 1)

cubist <- cubist %>%
  mutate(model_type = "cubist", .before = 1)

results <- bind_rows(cubist, plsr)

results <- results %>%
  filter(soil_property != "c.tot_usda.a622_w.pct")

results <- results %>%
  pivot_longer(all_of(c("rmse", "bias", "rsq", "ccc", "rpiq")),
               names_to = "metric", values_to = "value") %>%
  group_by(model_type, soil_property, subset_type, metric) %>%
  summarise(min = min(value),
            mean  = mean(value),
            max = max(value),
            .groups = "drop") %>%
  pivot_longer(all_of(c("min", "mean", "max")),
               names_to = "stats", values_to = "value") %>%
  pivot_wider(names_from = metric, values_from = value) %>%
  select(model_type, soil_property, subset_type, stats,
         rmse, bias, rsq, ccc, rpiq)

print(xtable(results), include.rownames=FALSE)

## Averages

results %>%
  group_by(model_type) %>%
  summarise_if(is.numeric, mean)

results %>%
  group_by(subset_type) %>%
  summarise_if(is.numeric, mean)

results %>%
  filter(subset_type == "ossl") %>%
  filter(model_type == "cubist") %>%
  group_by(model_type, soil_property) %>%
  summarise_if(is.numeric, mean)
