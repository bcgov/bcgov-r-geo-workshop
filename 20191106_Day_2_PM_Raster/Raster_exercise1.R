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



# Work in progress

Exercise 1:

DEM hillshade and differences

# read in a slope and aspect raster and create a hillshade
# check the crs and cell size



```{r}

slope <- raster(file.path(data.dir, "slope.tif"))

aspect <- raster(file.path(data.dir, "aspect.tif"))

# create a hillshade
dem.hill <- hillShade(slope, aspect,
                      angle=40,
                      direction=270)

plot(dem.hill,
     col=grey.colors(100, start=0, end=1),
     legend=F)


# export geotiff
writeRaster(dem.hill,
            filename="demhill.tif",
            format="GTiff",
            options="COMPRESS=LZW",
            overwrite = TRUE,
            NAflag = -9999)

## bonus

dem.contour <- rasterToContour(dem, maxpixels=100000)

plot(dem.contour, add = T)
plot(dem.contour)



