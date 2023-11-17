
library("tidyverse")
library("xtable")

plsr <- read_csv("performance/neospectra_final_performance_plsr.csv")
cubist <- read_csv("performance/neospectra_final_performance_cubist.csv")

plsr <- plsr %>%
  mutate(model_type = "plsr", .before = 1)

cubist <- cubist %>%
  mutate(model_type = "cubist", .before = 1)

results <- bind_rows(cubist, plsr)

results <- results %>%
  select(-spectra_type, -subset_type, -geo_type)

print(xtable(results), include.rownames=FALSE)

results %>%
  group_by(model_type) %>%
  summarise_if(is.numeric, mean)
