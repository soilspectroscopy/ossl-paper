
library("tidyverse")
library("cowplot")

# visnir map
visnir.output <- "../img/visnir.pnts_sites.png"

visnir.points <- ossl.level0.export %>%
  filter(!is.na(longitude.point_wgs84_dd)) %>%
  filter(!is.na(scan_visnir.1000_ref)) %>%
  select(dataset.code_ascii_txt, id.layer_uuid_txt, latitude.point_wgs84_dd, longitude.point_wgs84_dd) %>%
  st_as_sf(coords = c('longitude.point_wgs84_dd', 'latitude.point_wgs84_dd'), crs = 4326) %>%
  distinct(geometry, .keep_all = TRUE)

plot_gh(visnir.points, output = visnir.output, fill.col = "cyan1")

# mir map
mir.output <- "../img/mir.pnts_sites.png"

mir.points <- ossl.level0.export %>%
  filter(!is.na(longitude.point_wgs84_dd)) %>%
  filter(!is.na(scan_mir.1000_abs)) %>%
  select(dataset.code_ascii_txt, id.layer_uuid_txt, latitude.point_wgs84_dd, longitude.point_wgs84_dd) %>%
  st_as_sf(coords = c('longitude.point_wgs84_dd', 'latitude.point_wgs84_dd'), crs = 4326) %>%
  distinct(geometry, .keep_all = TRUE)

plot_gh(mir.points, output = mir.output, fill.col = "yellow")

# Saving as gpkg
ossl.points <- ossl.level0.export %>%
  filter(!is.na(longitude.point_wgs84_dd)) %>%
  select(dataset.code_ascii_txt, id.layer_uuid_txt, latitude.point_wgs84_dd, longitude.point_wgs84_dd) %>%
  st_as_sf(coords = c('longitude.point_wgs84_dd', 'latitude.point_wgs84_dd'), crs = 4326)

unlink("../out/ossl_locations.gpkg")
st_write(ossl.points, "../out/ossl_locations.gpkg", append = FALSE)

p.export <- plot_grid(map1, map2, ncol = 1, labels = "AUTO") +
  theme(panel.background = element_rect(fill = "white", colour = NA))

ggsave("outputs/ossl_points.png", p.export,
       dpi = 300, width = 5, height = 4, units = "in", scale = 1.5)
