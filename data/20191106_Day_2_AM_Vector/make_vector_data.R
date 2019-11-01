library(bcdata)
library(sf)
library(glue)

dir <- "data/20191106_Day_2_AM_Vector"

bcdc_get_data("bc-airports", resource = '4d0377d9-e8a1-429b-824f-0ce8f363512c') %>%
  select(AIRPORT_NAME, IATA_CODE, LOCALITY, ELEVATION) %>%
  st_write(glue("{dir}/temp.gpkg"), layer = "bc_airports", delete_layer = TRUE)

# For some reason st_write doesn't add the epsg code, so let's add it now
system(glue("ogr2ogr -a_srs \"EPSG:3005\" {dir}/bc_airports.gpkg {dir}/temp.gpkg"))
system(glue("rm {dir}/temp.gpkg"))
# check
system(glue("ogrinfo {dir}/bc_airports.gpkg bc_airports -so"))
