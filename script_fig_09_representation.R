
# The figure is produced by the OSSL Engine as a png. I downloaded the output
# and loaded here to reexport as TIFF.

library("ggplot2")

representation <- ggdraw() + draw_image("outputs/plot_representation_ossl_engine.png")

ggsave("outputs/plot_representation_ossl_engine.tiff", representation, compression = "lzw",
       dpi = 300, width = 6, height = 7.2, scale = 1.5)
