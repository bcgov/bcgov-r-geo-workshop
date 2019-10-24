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


# Pacakges ----------------------------------------------------------------

library(bcdata)
library(ggplot2)
library(bcmaps)
library(dplyr)
library(ggforce)



# Load Data ---------------------------------------------------------------


ridings <- bcdc_query_geodata('050ec630-47dd-476b-b773-28b2f8d8bc98') %>%
  filter(ED_NAME %in% c("Cariboo North")) %>%
  collect()


big_fire <- bcdc_query_geodata("fire-perimeters-historical") %>%
  filter(FIRE_NUMBER == "C10784") %>%
  collect()


# Viz ---------------------------------------------------------------------

p <- ggplot() +
  geom_sf(data = ridings, fill = "purple", alpha = 0.5) +
  geom_sf(data = big_fire, fill = "orange", alpha = 0.5)

p



# geometry generating logical operators -----------------------------------

unionized <- st_union(ridings, big_fire)

p + geom_sf(data = unionized, size = 2, fill = NA)

intersected <- st_intersection(ridings, big_fire)

p + geom_sf(data = intersected, size = 2, fill = NA)

differenced <- st_difference(ridings, big_fire)

p + geom_sf(data = differenced, size = 2, fill = NA)

sym_differenced <- st_sym_difference(ridings, big_fire)

p + geom_sf(data = sym_differenced, size = 2, fill = NA)

