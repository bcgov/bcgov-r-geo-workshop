# Sentinel Download Script (https://github.com/16EAGLE/getSpatialData)


# devtools::install_github("16EAGLE/getSpatialData")
  library(getSpatialData)
  library(raster)
  library(sf)
  library(sp)

# Manually Set an Area of Interest
  set_aoi()

# Login to Copernicus Data Hub (https://scihub.copernicus.eu/dhus/)
  login_CopHub(username = "bevingtona")
  set_archive("data/archive")

# Use getSentinel_query to search for data (using the session AOI)
  records <- getSentinel_query(time_range = c("2019-05-28",
                                              "2019-05-30"),
                               platform = "Sentinel-2")
# Filter Records
  records_filtered <- records[which(records$processinglevel == "Level-1C"),] #filter by Level

# Preview on Map
  # getSentinel_preview(records_filtered[1,])

# Download
  datasets <- getSentinel_data(records = records_filtered[1, ])

# Convert to TIFF
  datasets_prep <- unzip(datasets)


  jp2 <- list.files(path = "C:/Users/bevington/Dropbox/FLNRO_p1/!_Presentations/2019 11 05 R Geospatial/bcgov-r-geo-workshop/data/20191106_Day_2_PM_Raster/IMG_DATA", full.names = T)

  jp2_10 <- stack(jp2[c(2,3,4,8)])
  jp2_20 <- stack(jp2[c(5,6,7,11,12,13)])
  jp2_60 <- stack(jp2[c(1,9,10)])

  aoi <- mapview::viewRGB(x = jp2_10,
                          r = "T10UEE_20190529T191911_B04",
                          g = "T10UEE_20190529T191911_B03",
                          b = "T10UEE_20190529T191911_B02",
                          maxpixels = 1e+05) %>% mapedit::editMap()

  mask <- aoi$finished %>% st_transform(crs(jp2_10))
  jp2_10_crop <- crop(jp2_10, mask)
  jp2_20_crop <- crop(jp2_20, mask)
  jp2_60_crop <- crop(jp2_60, mask)

  jp2_10_crop_20 <- resample(jp2_10_crop, jp2_20_crop)

  writeRaster(x = stack(jp2_10_crop_20, jp2_20_crop), "T10UEE_20190529T191911_20m.tif")
