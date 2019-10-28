---
title: "Raster Basics"
author: "G Perkins"
output:
  ioslides_presentation:
    keep_md: true
---
<!--
Copyright 2019 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
-->






## Overview 

- Raster Basics
- Manipulating Rasters 
- Remote Sensed data 
- ??




## Packages history and tools : 

- `raster` (first released in 2010 Hijman)
- `sp` including  `SpatialGridDataFrame` & `SpatialPixalsDataFrame` data structure
- `stars` : Spatiotemporal Arrays, Raster and Vector Data Cubes (Pebesma).
- helper packages : `fasterize`, `rgdal`, `mapview` 
- tools and bridges (RSAGA, RQGIS, RPYGeon)



## Using Rasters in R : Work flow 

- Rasters cover all types of data - digital elevation model, remote sensed data, lidar and many others. 
- Often switch between raster and vector data sets. 


