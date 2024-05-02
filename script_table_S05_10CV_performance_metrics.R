
## Packages
library("tidyverse")
library("xtable")

## Data
performance <- read_csv("https://github.com/soilspectroscopy/ossl-models/raw/main/out/fitted_models_performance_v1.2.csv")

performance <- performance %>%
  select(-description, -n, -unit_transform)

write_csv(performance, "outputs/table4_10CV_performance.csv")

print(xtable(performance), include.rownames=FALSE)
