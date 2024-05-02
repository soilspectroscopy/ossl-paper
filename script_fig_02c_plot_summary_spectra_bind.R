
library("tidyverse")
library("cowplot")

mir.raw <- ggdraw() + draw_image("outputs/plot_spectra_mir_raw.png")
mir.snv <- ggdraw() + draw_image("outputs/plot_spectra_mir_snv.png")

visnir.raw <- ggdraw() + draw_image("outputs/plot_spectra_visnir_raw.png")
visnir.snv <- ggdraw() + draw_image("outputs/plot_spectra_visnir_snv.png")

nir.raw <- ggdraw() + draw_image("outputs/plot_spectra_nir_raw.png")
nir.snv <- ggdraw() + draw_image("outputs/plot_spectra_nir_snv.png")

p.all <- plot_grid(mir.raw, mir.snv,
                   visnir.raw, visnir.snv,
                   nir.raw, nir.snv,
                   ncol = 2, labels = "AUTO")

ggsave("outputs/plot_spectra_all.tiff", p.all,
       dpi = 300, width = 6, height = 7.2, scale = 1.5,
       compression = "lzw")
