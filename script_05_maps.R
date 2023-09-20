
library("tidyverse")
library("cowplot")

map1 <- cowplot::ggdraw() + cowplot::draw_image("outputs/visnir.pnts_sites.png")
map2 <- cowplot::ggdraw() + cowplot::draw_image("outputs/mir.pnts_sites.png")

p.export <- plot_grid(map1, map2, ncol = 1, labels = "AUTO") +
  theme(panel.background = element_rect(fill = "white", colour = NA))

ggsave("outputs/ossl_points.png", p.export,
       dpi = 300, width = 5, height = 4, units = "in", scale = 1.5)
