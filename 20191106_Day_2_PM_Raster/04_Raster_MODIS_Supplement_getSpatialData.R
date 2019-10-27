# Sentinel Download Script (https://github.com/16EAGLE/getSpatialData)

## Load packages for working on multi-core
library(parallel)
library(doParallel)
library(foreach)

## getSpatialData
library(getSpatialData)


#### specify which files to download ####
# specify outdir (where files will be downloaded to)
set_archive("data/archive")

# load example aoi
set_aoi()

# check, if service is available
services_avail()

## USGS login
login_USGS(username = "bevingtona")

# get available products
product_names <- getMODIS_names()

# query for records for your AOI, time range and product
time_range <-  c("2018-01-01", "2020-01-01")
records <- getMODIS_query(time_range = time_range, name = grep("MOD13A2", product_names, value = T))


#### initiate cluster for paralell download ####
no_cores <- detectCores() - 1
cl <- makeCluster(no_cores, type = "PSOCK")
registerDoParallel(cl)

files <- foreach(i = 1:nrow(records[]),
                 .combine=c,
                 .packages='getSpatialData') %dopar% {
                   getMODIS_data(records[i, ], dir_out = getwd())
                 }


#### stop cluster ####
stopCluster(cl)
