
library("tidyverse")
library("cowplot")
library("sf")
library("qs")

options(timeout = 10000)

## Data
all.level1 <- "https://storage.googleapis.com/soilspec4gg-public/ossl_all_L1_v1.2.qs"
all.level1 <- qread_url(all.level1)

## Plot function
plot_gh <- function(pnts, output, world, lats, longs, crs_goode = "+proj=igh", fill.col = "yellow"){
  
  # https://wilkelab.org/practicalgg/articles/goode.html
  require(cowplot)
  require(sf)
  require(rworldmap)
  require(ggplot2)
  
  if(missing(world)){ world <- sf::st_as_sf(rworldmap::getMap(resolution = "low")) }
  
  if(missing(lats)){
    lats <- c(
      90:-90, # right side down
      -90:0, 0:-90, # third cut bottom
      -90:0, 0:-90, # second cut bottom
      -90:0, 0:-90, # first cut bottom
      -90:90, # left side up
      90:0, 0:90, # cut top
      90 # close
    )
  }
  
  if(missing(longs)){
    longs <- c(
      rep(180, 181), # right side down
      rep(c(80.01, 79.99), each = 91), # third cut bottom
      rep(c(-19.99, -20.01), each = 91), # second cut bottom
      rep(c(-99.99, -100.01), each = 91), # first cut bottom
      rep(-180, 181), # left side up
      rep(c(-40.01, -39.99), each = 91), # cut top
      180 # close
    )
  }
  
  goode_outline <-
    list(cbind(longs, lats)) %>%
    st_polygon() %>%
    st_sfc(
      crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
    )
  
  # now we need to work in transformed coordinates, not in long-lat coordinates
  goode_outline <- st_transform(goode_outline, crs = crs_goode)
  
  # get the bounding box in transformed coordinates and expand by 10%
  xlim <- st_bbox(goode_outline)[c("xmin", "xmax")]*1.1
  ylim <- st_bbox(goode_outline)[c("ymin", "ymax")]*1.1
  
  # turn into enclosing rectangle
  goode_encl_rect <-
    list(
      cbind(
        c(xlim[1], xlim[2], xlim[2], xlim[1], xlim[1]),
        c(ylim[1], ylim[1], ylim[2], ylim[2], ylim[1])
      )
    ) %>%
    st_polygon() %>%
    st_sfc(crs = crs_goode)
  
  # calculate the area outside the earth outline as the difference
  # between the enclosing rectangle and the earth outline
  goode_without <- st_difference(goode_encl_rect, goode_outline)
  
  m <- ggplot(world) +
    geom_sf(fill = "gray80", color = "black", size = 0.5/.pt) +
    geom_sf(data = goode_without, fill = "white", size = "NA") +
    geom_sf(data = goode_outline, fill = NA, color = "gray30", size = 0.5/.pt) +
    geom_sf(data = pnts, fill = fill.col, color = "black", size = 0.8, shape = 21, stroke = 0.12) +
    # geom_sf(data = pnts, size = 0.8, shape = 21, fill = fill.col, color = "black") +
    # geom_sf(data = pnts, size = 1, pch="+", color="black") +
    coord_sf(crs = crs_goode, xlim = 0.95*xlim, ylim = 0.95*ylim, expand = FALSE) +
    cowplot::theme_minimal_grid() +
    theme(panel.background = element_rect(fill = "#56B4E950", color = "white", linewidth = 1),
          panel.grid.major = element_line(color = "gray30", linewidth = 0.25))
  
  ggsave(output, m, dpi = 200, units = "in", height = 4.5, width = 10)
  
}

## visnir

visnir.points <- all.level1 %>%
  filter(!is.na(scan_visnir.1000_ref)) %>%
  select(dataset.code_ascii_txt, id.layer_uuid_txt, scan_visnir.1000_ref,
         latitude.point_wgs84_dd, longitude.point_wgs84_dd,
         latitude.county_wgs84_dd, longitude.county_wgs84_dd)

# Checking available coordinates
visnir.points %>%
  filter(!is.na(latitude.point_wgs84_dd)) %>%
  count(dataset.code_ascii_txt)

visnir.points %>%
  filter(!is.na(latitude.county_wgs84_dd)) %>%
  count(dataset.code_ascii_txt)

# Temporary coordinates mixing precise and county
visnir.points <- visnir.points %>%
  mutate(longitude = ifelse(is.na(longitude.point_wgs84_dd),
                            longitude.county_wgs84_dd, longitude.point_wgs84_dd),
         latitude = ifelse(is.na(latitude.point_wgs84_dd),
                           latitude.county_wgs84_dd, latitude.point_wgs84_dd)) %>%
  select(-longitude.point_wgs84_dd, -longitude.county_wgs84_dd,
         -latitude.point_wgs84_dd, -latitude.county_wgs84_dd) %>%
  filter(!is.na(longitude))

visnir.points <- visnir.points %>%
  st_as_sf(coords = c('longitude', 'latitude'), crs = 4326) %>%
  distinct(geometry, .keep_all = TRUE)

# visnir map
visnir.output <- "outputs/ossl_points_visnir.png"
plot_gh(visnir.points, output = visnir.output, fill.col = "yellow")

## mir

mir.points <- all.level1 %>%
  filter(!is.na(scan_mir.1000_abs)) %>%
  select(dataset.code_ascii_txt, id.layer_uuid_txt, scan_mir.1000_abs,
         latitude.point_wgs84_dd, longitude.point_wgs84_dd,
         latitude.county_wgs84_dd, longitude.county_wgs84_dd)

# Checking available coordinates
mir.points %>%
  filter(!is.na(latitude.point_wgs84_dd)) %>%
  count(dataset.code_ascii_txt)

mir.points %>%
  filter(!is.na(latitude.county_wgs84_dd)) %>%
  count(dataset.code_ascii_txt)

# Temporary coordinates mixing precise and county
mir.points <- mir.points %>%
  mutate(longitude = ifelse(is.na(longitude.point_wgs84_dd),
                            longitude.county_wgs84_dd, longitude.point_wgs84_dd),
         latitude = ifelse(is.na(latitude.point_wgs84_dd),
                           latitude.county_wgs84_dd, latitude.point_wgs84_dd)) %>%
  select(-longitude.point_wgs84_dd, -longitude.county_wgs84_dd,
         -latitude.point_wgs84_dd, -latitude.county_wgs84_dd) %>%
  filter(!is.na(longitude))

mir.points <- mir.points %>%
  st_as_sf(coords = c('longitude', 'latitude'), crs = 4326) %>%
  distinct(geometry, .keep_all = TRUE)

# mir map
mir.output <- "outputs/ossl_points_mir.png"
plot_gh(mir.points, output = mir.output, fill.col = "cyan")

## Binding them

map1 <- cowplot::ggdraw() + cowplot::draw_image("outputs/ossl_points_visnir.png")
map2 <- cowplot::ggdraw() + cowplot::draw_image("outputs/ossl_points_mir.png")

p.export <- plot_grid(map1, map2, ncol = 1, labels = "AUTO") +
  theme(panel.background = element_rect(fill = "white", colour = NA))

ggsave("outputs/ossl_points.png", p.export,
       dpi = 300, width = 5, height = 4, units = "in", scale = 1.5)
