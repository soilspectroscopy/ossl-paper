
library("tidyverse")
library("xtable")

# Long term research (LTR) sites dataset

performance <- read_csv("performance/ltr_performance_ossl_paper.csv", show_col_types = F)

# Visualization

selected.test <- c("Woodwell full (n=965)",
                   "Woodwell subset (n=162)",
                   "KSSL subset (n=162)")

p.ltr.rmse <- performance %>%
  filter(test %in% selected.test) %>%
  mutate(test = factor(test,
                       levels = selected.test)) %>%
  ggplot(aes(x = test, y = rmse, fill = model_type)) +
  facet_wrap(~subset_type, ncol = 2) +
  geom_col(position = "dodge2") +
  scale_fill_manual(values = c("orange", "darkblue")) +
  labs(x = NULL, y = "Organic carbon RMSE (w%)", fill = NULL) +
  theme_light() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)); p.ltr.rmse

ggsave("outputs/plot_ltr_mir_organic_carbon.png", p.ltr.rmse,
       dpi = 300, width = 6, height = 5, units = "in", scale = 1)

## Table
performance %>%
  select(-soil_property) %>%
  select(test, everything()) %>%
  arrange(test) %>%
  xtable(., include.rownames=FALSE)
