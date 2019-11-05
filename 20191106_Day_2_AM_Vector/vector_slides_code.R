## ---- include=FALSE------------------------------------------------------
# Copyright 2019 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.


## ----setup, include=FALSE------------------------------------------------
options(htmltools.dir.version = FALSE)
options(width = 90)
options(max_print = 5)

knitr::opts_chunk$set(
  collapse = TRUE,
  #echo = FALSE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  fig.path = "graphics/prod/figs",
  fig.width = 8,
  fig.height = 5
)

options(scipen = 10)


## ---- pck-load, warning=FALSE, message=FALSE, include = FALSE------------
library(knitr)
library(sf)
library(dplyr)
library(ggplot2)
library(bcdata)
library(ggspatial)
library(bcmaps)
library(here)
library(mapview)
library(units)


## ----hacks, warning=FALSE, echo=FALSE------------------------------------
scale_colour_continuous <- scale_colour_viridis_c
scale_fill_continuous <- scale_fill_viridis_c
scale_colour_discrete <- scale_colour_viridis_d
scale_fill_discrete <- scale_fill_viridis_d

here_loc <- ifelse(dir.exists("data"), ".", "../..")
here::set_here(here_loc)

# read wrapper functions so slides render and work locally without
# explicitly using here::here()
st_read <- function(dsn, layer, ...) {
  sf::st_read(dsn = here::here(dsn), layer = layer, ...)
}

read_sf <- function(..., quiet = TRUE, stringsAsFactors = FALSE,
  as_tibble = TRUE) {
  st_read(..., quiet = quiet, stringsAsFactors = stringsAsFactors, 
        as_tibble = as_tibble)
}

read.csv <- function(file, ...) {
  utils::read.csv(file = here(file), ...)
}


## ------------------------------------------------------------------------
library(dplyr)
select(starwars, name, height, hair_color, homeworld)


## ------------------------------------------------------------------------
filter(starwars,  homeworld == "Tatooine")


## ------------------------------------------------------------------------
starwars %>% 
  select(name, height, hair_color, homeworld) %>% 
  filter(homeworld == "Tatooine")


## ------------------------------------------------------------------------
starwars %>% 
  select(name, height, hair_color, homeworld) %>% 
  filter(homeworld == "Tatooine") %>% 
  group_by(hair_color)


## ------------------------------------------------------------------------
starwars %>% 
  select(name, height, hair_color, homeworld) %>% 
  filter(homeworld == "Tatooine") %>% 
  group_by(hair_color) %>% 
  summarise(sd_height = sd(height, na.rm = TRUE))


## ------------------------------------------------------------------------
starwars %>% 
  filter(species == "Human") %>% 
  group_by(homeworld) %>% 
  summarise(mean_mass = mean(mass, na.rm = TRUE)) %>% 
  arrange(desc(mean_mass))


## ---- eval=FALSE---------------------------------------------------------
## library(sf)
## library(mapview)


## ---- cache=TRUE---------------------------------------------------------
airports <- st_read("data/20191106_Day_2_AM_Vector/bc_airports.gpkg", quiet = TRUE)


## ----fig.width=5, cache=TRUE---------------------------------------------
mapview(airports)


## ----fig.width=10, cache=TRUE--------------------------------------------
mapview(airports, zcol = "NUMBER_OF_RUNWAYS")


## ------------------------------------------------------------------------
airports


## ----message=TRUE--------------------------------------------------------

st_geometry(airports)

st_bbox(airports)

st_crs(airports)


## ------------------------------------------------------------------------
class(airports)
is.data.frame(airports)
summary(airports)



## ------------------------------------------------------------------------
airports_df <- st_drop_geometry(airports)
head(airports_df)


## ------------------------------------------------------------------------
st_crs(airports)


## ----echo=FALSE, cache=TRUE----------------------------------------------

albers_centre <- st_sfc(st_point(c(-126, 54)), crs = 4326) %>% 
  st_transform(3005)

ggplot() + 
  geom_sf(data = bc_bound()) + 
  geom_sf(data = albers_centre, colour = "blue", size = 5) + 
  geom_sf(data = bc_cities() %>% filter(NAME == "Burns Lake")) + 
  geom_sf_text(data = bc_cities() %>% filter(NAME == "Burns Lake"), aes(label = NAME), nudge_x = 100000, nudge_y = 30000) + 
  theme_void()
  


## ------------------------------------------------------------------------
st_crs(3005)$proj4string


## ------------------------------------------------------------------------
# one of "have_datum_files", "proj", "ellps", 
# "datum", "units" or "prime_meridians"
st_proj_info("proj") %>% head()



## ----message=TRUE, cache=TRUE--------------------------------------------
elec_bc <- read_sf("data/20191106_Day_2_AM_Vector/bc_electoral_districts.shp")
st_geometry(elec_bc)
st_crs(elec_bc)


## ----cache=TRUE----------------------------------------------------------
plot(elec_bc)


## ------------------------------------------------------------------------
plot(elec_bc["ED_NAME"])


## ----eval=FALSE----------------------------------------------------------
## library(ggplot2)


## ----cache=TRUE----------------------------------------------------------
ggplot() + # leave this empty!
  geom_sf(data = elec_bc)


## ----cache=TRUE----------------------------------------------------------
elec_bc_albers <- st_transform(elec_bc, 3005)

# OR
albers <- "+proj=aea +lat_1=50 +lat_2=58.5 +lat_0=45 +lon_0=-126 +x_0=1000000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
elec_bc_albers <- st_transform(elec_bc, albers)

# OR (very handy)

elec_bc_albers <- st_transform(elec_bc, st_crs(airports))

st_crs(elec_bc_albers)


## ----cache=TRUE----------------------------------------------------------
ggplot() + 
  geom_sf(data = elec_bc)



## ----cache=TRUE----------------------------------------------------------
elec_bc_albers <- st_transform(elec_bc, 3005)
ggplot() + 
  geom_sf(data = elec_bc_albers)


## ----echo=FALSE----------------------------------------------------------
knitr::kable(head(read.csv("data/20191106_Day_2_AM_Vector/ski_resorts.csv")), 
             format = "html")


## ---- eval=FALSE---------------------------------------------------------
## ski_resorts <- read.csv("data/20191106_Day_2_AM_Vector/ski_resorts.csv")
## ski_resorts <- st_as_sf(ski_resorts, ...)


## ----cache=TRUE----------------------------------------------------------
ski_resorts <- read.csv("data/20191106_Day_2_AM_Vector/ski_resorts.csv", 
                        stringsAsFactors = FALSE)

ski_resorts <- st_as_sf(ski_resorts, coords = c("longitude", "latitude"), 
                        crs = 4326)

head(ski_resorts)


## ----cache=TRUE, fig.width=10, fig.height=6------------------------------
ggplot() + 
  geom_sf(data = ski_resorts, aes(colour = elevation), size = 5)


## ----eval=FALSE----------------------------------------------------------
## library(bcdata)


## ----cache=TRUE----------------------------------------------------------
railways <- bcdc_get_data("railway-track-line",
                          resource = "bf30d34e-1f6b-4034-a35c-1cf7c9707ae7")
# OR: railways <- bcdc_get_data("WHSE_BASEMAPPING.GBA_RAILWAY_TRACKS_SP")
railways


## ----fig.width=11, fig.height=7------------------------------------------
ggplot() + 
  geom_sf(data = railways, aes(colour = USE_TYPE))


## ------------------------------------------------------------------------
railways <- select(railways, TRACK_NAME, TRACK_CLASSIFICATION, 
                   USE_TYPE)
railways


## ------------------------------------------------------------------------
st_length(railways)


## ------------------------------------------------------------------------
railways <- mutate(railways, track_length = st_length(geometry))


## ------------------------------------------------------------------------
long_railways <- filter(railways, as.numeric(track_length) > 5000)


## ------------------------------------------------------------------------
library(units)
long_railways <- filter(railways, track_length > as_units(5000, "m"))


## ----cache=TRUE, fig.width=11, fig.height=7------------------------------
ggplot() +
  geom_sf(data = long_railways, aes(colour = as.numeric(track_length)))


## ---- cache=TRUE---------------------------------------------------------
nr_district <- bcdc_get_data('natural-resource-nr-district')


nr_region <- nr_district %>% 
  group_by(REGION_ORG_UNIT_NAME) %>% 
  summarise() # << defaults to union


## ----cache=TRUE, fig.width=11, fig.height=7------------------------------
ggplot() +
  geom_sf(data = nr_region, colour = "white", 
          aes(fill = REGION_ORG_UNIT_NAME)) 


## ----cache=TRUE----------------------------------------------------------
nr_region_multi <- nr_district %>% 
  group_by(REGION_ORG_UNIT_NAME) %>% 
  summarise(do_union = FALSE) # <<--

nr_region_multi


## ----cache=TRUE----------------------------------------------------------
ggplot() +
  geom_sf(data = nr_region_multi, colour = "white", 
          aes(fill = REGION_ORG_UNIT_NAME)) 


## ---- cache=TRUE---------------------------------------------------------
nr_region %>% 
  mutate(region_area = st_area(geometry))


## ---- theme, warning=FALSE, echo=FALSE-----------------------------------
suppressWarnings(theme_set(theme_void()))


## ---- cache=TRUE---------------------------------------------------------
library(bcdata)

nr_district <- bcdc_get_data('natural-resource-nr-district')
lines <- bcdc_get_data('bc-transmission-lines')

fires_2017 <- bcdc_query_geodata('fire-perimeters-historical') %>%
  filter(FIRE_YEAR == 2017) %>% 
  collect()

big_fires <- fires_2017 %>%
  filter(FIRE_NUMBER %in% c('C10784', 'C50647'))

bc <- bcdc_query_geodata('7-5m-provinces-and-states-the-atlas-of-canada-base-maps-for-bc') %>% 
  filter(ENGLISH_NAME == 'British Columbia') %>% 
  collect()


## ------------------------------------------------------------------------
library(ggplot2)

m <- ggplot() +
  geom_sf(data = bc, fill = "grey80") +
  geom_sf(data = nr_district, fill = "purple", alpha = 0.5) +
  geom_sf(data = big_fires, fill = "orange", alpha = 0.5) +
  geom_sf(data = lines, colour = "yellow")


## ---- echo=FALSE, dpi = 300----------------------------------------------
m


## ---- eval=TRUE----------------------------------------------------------
fire_districts <- nr_district %>%
  filter(DISTRICT_NAME %in% c("Stuart Nechako Natural Resource District", 
                              "Quesnel Natural Resource District", 
                              "Cariboo-Chilcotin Natural Resource District", 
                              "Prince George Natural Resource District"
                              ))


## ---- eval=FALSE---------------------------------------------------------
## ggplot() +
##   geom_sf(data = fire_districts, fill = "purple", alpha = 0.5) +
##   geom_sf(data = big_fires, fill = "orange", alpha = 0.5)
## 


## ------------------------------------------------------------------------
biggest_fire <- big_fires %>%
  filter(FIRE_NUMBER == "C10784")

quesnel_district <- nr_district %>%
  filter(DISTRICT_NAME == "Quesnel Natural Resource District")


## ------------------------------------------------------------------------
p <- ggplot() +
  geom_sf(data = quesnel_district, fill = "purple", alpha = 0.5) +
  geom_sf(data = biggest_fire, fill = "orange", alpha = 0.5)
p


## ------------------------------------------------------------------------
library(sf)
unionized <- st_union(quesnel_district, biggest_fire)
p + geom_sf(data = unionized, size = 1.5, fill = NA, colour = "lightslateblue")


## ------------------------------------------------------------------------
intersected <- st_intersection(quesnel_district, biggest_fire)
p + geom_sf(data = intersected, size = 1.5, fill = NA, colour = "lightslateblue")


## ------------------------------------------------------------------------
differenced <- st_difference(quesnel_district, biggest_fire)
p + geom_sf(data = differenced, size = 1.5, fill = NA, colour = "lightslateblue")


## ------------------------------------------------------------------------
fire_lines <- lines %>% 
  st_intersection(fire_districts)

ggplot() +
  geom_sf(data = fire_districts, fill = "purple", alpha = 0.5) +
  geom_sf(data = big_fires, fill = "orange", alpha = 0.5) + 
  geom_sf(data = fire_lines, colour = "yellow")


## ------------------------------------------------------------------------
p2 <- ggplot() +
  geom_sf(data = fire_districts, fill = "purple", alpha = 0.5) +
  geom_sf(data = big_fires, fill = "orange", alpha = 0.5) + 
  geom_sf(data = fire_lines, colour = "yellow")
p2


## ------------------------------------------------------------------------
st_intersects(fire_districts, big_fires, sparse = FALSE)
fire_districts[big_fires, , op = st_intersects]


## ------------------------------------------------------------------------
does_intersect <- fire_districts[big_fires, , op = st_intersects]
p2 + geom_sf(data = does_intersect, fill = NA, colour = "lightslateblue", size = 1.5)


## ------------------------------------------------------------------------
crosses_lines <- big_fires[fire_lines, , op = st_crosses]
p2 + geom_sf(data = crosses_lines, fill = NA, colour = "lightslateblue", size = 1.5)


## ------------------------------------------------------------------------
all_crosses <- fires_2017[lines, , op = st_crosses]
ggplot() +
  geom_sf(data = bc, fill = "grey80") +
  geom_sf(data = nr_district, fill = "purple", alpha = 0.5) +
  geom_sf(data = fires_2017, fill = "orange", alpha = 0.5) +
  geom_sf(data = lines, colour = "yellow") + 
  geom_sf(data = all_crosses, fill = "yellow", alpha = 0.5)


## ------------------------------------------------------------------------
courts <- bcdc_get_data('court-locations', resource = '23aa0b75-2715-4ccb-9a36-9a608450dc2d')
bc_cities <- bcdc_get_data('bc-major-cities-points-1-2-000-000-digital-baseline-mapping')

courts %>% 
  left_join(bc_cities, by = c("City" = "NAME")) %>% 
  group_by(LONG_TYPE) %>% 
  summarise(mean_pop = mean(POP_2000))


## ---- fig.width = 11, fig.height=4---------------------------------------
cities_by_nr <- bc_cities %>% 
  st_join(nr_district, join = st_intersects) %>% 
  group_by(REGION_ORG_UNIT_NAME) %>% 
  summarise(nr_pop_2000 = sum(POP_2000))

ggplot(cities_by_nr) +
  geom_col(aes(x = REGION_ORG_UNIT_NAME, y = nr_pop_2000)) +
  coord_flip() +
  theme_minimal()


## ------------------------------------------------------------------------
lines %>% 
  st_join(nr_district) %>% 
  mutate(length_lines = st_length(geometry)) %>% 
  group_by(DISTRICT_NAME) %>% 
  summarise(district_length_lines = sum(length_lines)) %>% 
  arrange(desc(district_length_lines))


## ------------------------------------------------------------------------
bc_cities_buffer <- st_buffer(bc_cities, dist = 20000) ## 20km
ggplot() +
  geom_sf(data = bc) +
  geom_sf(data = bc_cities) +
  geom_sf(data = bc_cities_buffer, fill = "green", alpha = 0.5)


## ---- echo = FALSE, fig.height=7, fig.width=11, cache=TRUE---------------
ggplot() +
  geom_sf(data = bc, fill = "grey80") +
  geom_sf(data = nr_district, alpha = 0.5, aes(fill = REGION_ORG_UNIT_NAME)) +
  geom_sf(data = fires_2017, fill = "orange", alpha = 0.5) +
  geom_sf(data = lines, colour = "yellow") +
  coord_sf(datum = NA, expand = FALSE) +
  annotation_scale(pad_x = unit(2, "cm"), pad_y = unit(1, "cm"),
                   location = "bl",  style = "ticks", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "grid", pad_x = unit(2, "cm"), pad_y = unit(6, "cm")) +
  labs(title = "Fire Activity Near Transmission Lines - 2017") +
  theme_void() +
  theme(panel.background = element_rect(fill = "aliceblue"),
        #legend.position = c(.15, .15),
        legend.box.background = element_rect(),
        legend.box.margin = margin(6, 6, 6, 6))


## ------------------------------------------------------------------------
wna <- bcdc_query_geodata('7-5m-provinces-and-states-the-atlas-of-canada-base-maps-for-bc') %>% 
  filter(!is.na(NAME)) %>% 
  collect()

nr_region <- nr_district %>% 
  group_by(REGION_ORG_UNIT_NAME) %>% 
  summarise() 


## ------------------------------------------------------------------------
fancy_plot <- ggplot() +
  geom_sf(data = wna)
fancy_plot


## ------------------------------------------------------------------------
fancy_plot + 
  geom_sf(data = nr_region, alpha = 0.5, aes(fill = REGION_ORG_UNIT_NAME))


## ------------------------------------------------------------------------
nr_region_int <- nr_region %>% 
  st_intersection(wna)

fancy_plot <- fancy_plot + geom_sf(data = nr_region_int, alpha = 0.5, aes(fill = REGION_ORG_UNIT_NAME))
fancy_plot


## ------------------------------------------------------------------------
fancy_plot <- fancy_plot +
  geom_sf(data = lines, colour = "yellow")


## ------------------------------------------------------------------------
fancy_plot + geom_sf(data = bc_cities)


## ------------------------------------------------------------------------
nrow(bc_cities)

cities_by_region <- bc_cities %>% 
  st_join(nr_region, join = st_intersects) %>% 
  group_by(REGION_ORG_UNIT_NAME) %>% 
  filter(POP_2000 == max(POP_2000))

fancy_plot + geom_sf(data = cities_by_region)


## ------------------------------------------------------------------------
fancy_plot <- fancy_plot +
  geom_sf(data = cities_by_region) +
  geom_sf_label(data = cities_by_region, aes(label = NAME), nudge_y = 3E4, nudge_x = 4E4) 
fancy_plot


## ------------------------------------------------------------------------
region_names <- st_centroid(nr_region) %>% 
  mutate(REGION_ORG_UNIT_NAME = gsub(" Natural Resource Region", "", REGION_ORG_UNIT_NAME))

fancy_plot +
  geom_sf_text(data = region_names, aes(label = REGION_ORG_UNIT_NAME), size = 6)



## ------------------------------------------------------------------------
library(ggspatial)
fancy_plot +
  geom_sf_text(data = region_names, aes(label = REGION_ORG_UNIT_NAME), size = 6) +
  coord_sf(datum = NA, expand = FALSE) +
  annotation_scale(pad_x = unit(2, "cm"), pad_y = unit(1, "cm"),
                   location = "bl",  style = "ticks", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "grid")
  


## ------------------------------------------------------------------------
text_box <- paste(strwrap("Some text that explains why I am plotting so things here and then find another thing to talk about again.", width = 40), collapse = "\n")

fancy_plot +
  geom_sf_text(data = region_names, aes(label = REGION_ORG_UNIT_NAME), size = 6) +
  coord_sf(datum = NA, expand = FALSE) +
  annotation_scale(pad_x = unit(2, "cm"), pad_y = unit(1, "cm"),
                   location = "bl",  style = "ticks", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "grid") +
  labs(title = "British Columbia Natural Resource Regions",
       subtitle = "Major transmission lines displayed using yellow",
       caption = "Data retrieved from the BC Data Catalogue using the bcdata package") +
  guides(fill = FALSE) +
  annotate("label", x = 4E5, y = 4E5, label = text_box)


## ------------------------------------------------------------------------
out <- fancy_plot +
  geom_sf_text(data = region_names, aes(label = REGION_ORG_UNIT_NAME), size = 6) +
  coord_sf(datum = NA, expand = FALSE) +
  annotation_scale(pad_x = unit(2, "cm"), pad_y = unit(1, "cm"),
                   location = "bl",  style = "ticks", width_hint = 0.2) +
  annotation_north_arrow(location = "bl", which_north = "grid") +
  labs(title = "British Columbia Natural Resource Regions",
       subtitle = "Major transmission lines displayed in yellow",
       caption = "Data retrieved from the BC Data Catalogue using the bcdata package") +
  guides(fill = FALSE) +
  annotate("label", x = 4E5, y = 4E5, label = text_box) +
  theme_void() +
  theme(panel.background = element_rect(fill = "aliceblue"),
        panel.border = element_rect(size = 2, fill = NA))
out


## ---- eval=FALSE---------------------------------------------------------
## ggsave(out, file = "fancy_plot.pdf", height = 15, width = 15)


## ---- eval=FALSE---------------------------------------------------------
## out <- fancy_plot +
##   geom_sf_text(data = region_names, aes(label = REGION_ORG_UNIT_NAME), size = 6) +
##   coord_sf(datum = NA, expand = FALSE) +
##   annotation_scale(pad_x = unit(2, "cm"), pad_y = unit(1, "cm"),
##                    location = "bl",  style = "ticks", width_hint = 0.2) +
##   annotation_north_arrow(location = "bl", which_north = "grid") +
##   labs(title = "British Columbia Natural Resource Regions",
##        subtitle = "Major transmission lines displayed in yellow",
##        caption = "Data retrieved from the BC Data Catalogue using the bcdata package") +
##   guides(fill = FALSE) +
##   annotate("label", x = 4E5, y = 4E5, label = text_box) +
##   theme_void() +
##   theme(panel.background = element_rect(fill = "aliceblue"),
##         panel.border = element_rect(size = 2, fill = NA),
##         plot.title = element_text(size = 20),
##         plot.subtitle = element_text(size = 18),
##         plot.caption = element_text(size = 15))
## 
## ggsave(out, file = "fancy_plot.pdf", height = 15, width = 15)

