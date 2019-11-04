library(bcdata)
library(sf)
library(glue)
library(rmapshaper)
library(elevatr)

dir <- "data/20191106_Day_2_AM_Vector"

fix_epsg <- function(dir, filename, new_filename, layer, epsg) {
  if (file.exists(new_filename)) unlink(new_filename)
  # For some reason st_write doesn't add the epsg code, so let's add it now
  system(glue("ogr2ogr -a_srs \"EPSG:{epsg}\" {dir}/{new_filename} {dir}/{filename}"))
  system(glue("rm {dir}/{filename}"))
  # check
  system(glue("ogrinfo {dir}/{new_filename} {layer} -so"))
}

bcdc_get_data("bc-airports",
              resource = '4d0377d9-e8a1-429b-824f-0ce8f363512c') %>%
  select(AIRPORT_NAME, IATA_CODE, LOCALITY, ELEVATION,
         NUMBER_OF_RUNWAYS) %>%
  st_write(glue("{dir}/temp.gpkg"), layer = "bc_airports",
           delete_layer = TRUE)

fix_epsg(dir, "temp.gpkg", "bc_airports.gpkg", "bc_airports", "3005")

# TODO make this a gdb
bcdc_get_data("current-provincial-electoral-districts-of-british-columbia",
              resource = "89de1e77-9e33-41dd-bf6f-34e6d664b89a") %>%
  st_transform(4326) %>%
  ms_simplify() %>%
  st_write(glue("{dir}/temp.shp"),
           layer = "bc_electoral_districts", delete_layer = TRUE)

fix_epsg(dir, "temp.shp", "bc_electoral_districts.shp",
         "bc_electoral_districts", "4326")

# ski resorts csv
bcdc_get_data("db1489d4-4304-4203-99bf-11b2b23179eb") %>%
  get_elev_point(src = "aws") %>%
  select(FACILITY_NAME, LOCALITY, LATITUDE, LONGITUDE, elevation) %>%
  rename_all(tolower) %>%
  st_drop_geometry() %>%
  readr::write_csv("data/20191106_Day_2_AM_Vector/ski_resorts.csv")
