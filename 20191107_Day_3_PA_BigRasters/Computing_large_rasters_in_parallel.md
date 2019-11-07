Processing Large Rasters using Tiling and Parallelization
================
Hengl, T.

  - [Introduction](#introduction)
  - [Deriving differences in land cover using large
    GeoTIFFs](#deriving-differences-in-land-cover-using-large-geotiffs)
  - [References](#references)

| <a href="https://github.com/thengl"><img src="https://avatars0.githubusercontent.com/u/640722?s=460&v=4" height="100" alt="Tomislav Hengl"></a> |
| ----------------------------------------------------------------------------------------------------------------------------------------------- |

-----

<a href="https://creativecommons.org/licenses/by-sa/4.0/" target="_blank"><img src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" alt=""></a>

## Introduction

Processing large spatial data in a programming environment such as R is
not trivial. Even if you use powerful computing infrastructure, it might
take careful programming to be able to process large spatial data. The
reasons why R has not been recommended as a programming environment for
large data were: (a) R does not handle well large objects in the working
memory, and (b) for many existing functions parallelization is not
implemented automatically but has to be added through additional
programming. This tutorial demonstrates how to use R to read, process
and create large spatial (raster) data sets. In principle, both examples
follow the same systematic approach:

1.  prepare a function to run in parallel,
2.  tile object and estimate processing time,
3.  run function using all cores,
4.  build a virtual mosaic and final image using GDAL,
5.  avoid loading any large data in RAM,

In addition to R, we also provide some code examples of how to use SAGA
GIS, GRASS GIS and GDAL in parallel. Packages used in this tutorial
include:

``` r
list.of.packages <- c("plyr", "parallel", "GSIF", "raster", 
                      "rgdal", "snowfall", "knitr", "tmap")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)
```

Note: the processing below is demonstrated using relatively large
objects and a computer with 8 cores running on Ubuntu 16.04 operating
system. To install software used in this tutorial and teach your-self
some initial steps, consider reading [this
document](https://envirometrix.github.io/PredictiveSoilMapping/soil-covs-chapter.html).

## Deriving differences in land cover using large GeoTIFFs

Land cover maps are often distributed as raster images showing
distribution of 5–20 classes (Kirches et al., 2014). Here we use two
images of ESA’s land cover maps for Indonesia (Kalimantan island)
obtained from the [ESA’s land cover project
website](https://www.esa-landcover-cci.org/?q=node/158) :

``` r
library(rgdal)
```

    ## Loading required package: sp

    ## rgdal: version: 1.4-7, (SVN revision 845)
    ##  Geospatial Data Abstraction Library extensions to R successfully loaded
    ##  Loaded GDAL runtime: GDAL 2.2.3, released 2017/11/20
    ##  Path to GDAL shared files: C:/ROpen/R-3.5.3/library/rgdal/gdal
    ##  GDAL binary built with GEOS: TRUE 
    ##  Loaded PROJ.4 runtime: Rel. 4.9.3, 15 August 2016, [PJ_VERSION: 493]
    ##  Path to PROJ.4 shared files: C:/ROpen/R-3.5.3/library/rgdal/proj
    ##  Linking to sp version: 1.3-1

``` r
library(raster)
GDALinfo("./data/Indonesia_ESA_lcc_300m_2000.tif")
```

    ## rows        5789 
    ## columns     5280 
    ## bands       1 
    ## lower left origin.x        108.7 
    ## lower left origin.y        -4.58 
    ## res.x       0.002083333 
    ## res.y       0.002083261 
    ## ysign       -1 
    ## oblique.x   0 
    ## oblique.y   0 
    ## driver      GTiff 
    ## projection  +proj=longlat +datum=WGS84 +no_defs 
    ## file        ./data/Indonesia_ESA_lcc_300m_2000.tif 
    ## apparent band summary:
    ##   GDType hasNoDataValue NoDataValue blockSize1 blockSize2
    ## 1   Byte           TRUE           0          1       5280
    ## apparent band statistics:
    ##   Bmin Bmax    Bmean      Bsd
    ## 1   10  210 138.5152 81.03023
    ## Metadata:
    ## AREA_OR_POINT=Area

this image is about 6000 by 6000 pixels in size hence not huge (for
illustration, a land cover map of the whole world at 300 m resolution
contains over billion pixels) but it could still be more efficiently
processed if we use tiling and parallelization.

We are interested in deriving the difference in land cover between two
periods 2000 and 2015. First, we make a function that can be used to
detect differences:

``` r
make_LC_tiles <- function(i, tile.tbl, 
                          out.path="./tiled",
                          lc1="./data/Indonesia_ESA_lcc_300m_2000.tif",
                          lc2="./data/Indonesia_ESA_lcc_300m_2015.tif", 
                          leg.lcc){
  out.tif = paste0(out.path, "/T_", tile.tbl[i,"ID"], ".tif")
  if(!file.exists(out.tif)){
    m <- readGDAL(lc1, offset=unlist(tile.tbl[i,c("offset.y","offset.x")]),
                 region.dim=unlist(tile.tbl[i,c("region.dim.y","region.dim.x")]),
                 output.dim=unlist(tile.tbl[i,c("region.dim.y","region.dim.x")]),
                 silent = TRUE)
    m@data[,2] <- readGDAL(lc2, offset=unlist(tile.tbl[i,c("offset.y","offset.x")]),
                  region.dim=unlist(tile.tbl[i,c("region.dim.y","region.dim.x")]),
                  output.dim=unlist(tile.tbl[i,c("region.dim.y","region.dim.x")]), 
                  silent = TRUE)$band1
    names(m) <- c("LC2000","LC2015")
    m <- as(m, "SpatialPixelsDataFrame")
    ## Focus only on pixels that show land cover change
    sel <- !m$LC2000==m$LC2015
    if(sum(sel)>0){
      m <- m[sel,]
      m$v <- paste(m$LC2000, m$LC2015, sep="_")
      m$i <- plyr::join(data.frame(NAME=m$v), leg.lcc, type="left")$Value
      writeGDAL(m["i"], out.tif, type="Int16", 
                options="COMPRESS=DEFLATE", mvFlag=-32768)
    }
  }
}
```

this function we can run for each element `i` i.e. for smaller blocks
and hence can be run in parallel. The function looks for where there has
been a change in land cover, and then assign an unique number that
identifies change from land cover class `A` to land cover class `B`
(hence class `A-B`). We need to prepare a combined legend for
combinations of land cover classes. This output legend we can prepare by
using:

``` r
leg <- read.csv("./data/ESA_landcover_legend.csv")
str(leg)
```

    ## 'data.frame':    38 obs. of  8 variables:
    ##  $ Value      : int  0 10 11 12 20 30 40 50 60 61 ...
    ##  $ AGG_NAME   : Factor w/ 8 levels "Artificial areas",..: 5 3 3 3 3 3 6 4 4 4 ...
    ##  $ Value_AGG_w: int  0 3 3 3 3 3 2 1 1 1 ...
    ##  $ Value_AGG  : int  5 3 3 3 3 3 6 4 4 4 ...
    ##  $ NAME       : Factor w/ 38 levels "Bare areas","Consolidated bare areas",..: 14 4 8 35 3 10 12 25 23 22 ...
    ##  $ R          : int  0 255 255 255 170 220 200 0 0 0 ...
    ##  $ G          : int  0 255 255 255 240 240 200 100 160 160 ...
    ##  $ B          : int  0 100 100 0 240 100 100 0 0 0 ...

``` r
comb.leg <- expand.grid(leg$Value, leg$Value)
comb.leg$lcc <- paste(comb.leg$Var1, comb.leg$Var2, sep="_")
```

this gives almost 1400 combinations:

``` r
leg.lcc <- data.frame(Value=1:nrow(comb.leg), NAME=comb.leg$lcc)
head(leg.lcc)
```

    ##   Value NAME
    ## 1     1  0_0
    ## 2     2 10_0
    ## 3     3 11_0
    ## 4     4 12_0
    ## 5     5 20_0
    ## 6     6 30_0

Next, we prepare a tiling system to run processing in parallel:

``` r
library(raster)
library(GSIF)
```

    ## GSIF version 0.5-5 (2019-01-04)

    ## URL: http://gsif.r-forge.r-project.org/

``` r
## check whether the maps match perfectly to the same grid:
x <- raster::stack(paste0("./data/Indonesia_ESA_lcc_300m_", c(2000, 2015), ".tif"))
## OK!
obj <- GDALinfo("./data/Indonesia_ESA_lcc_300m_2000.tif")
## tile to 50km blocks:
tile.lst <- getSpatialTiles(obj, block.x=.5, return.SpatialPolygons=TRUE)
```

    ## Generating 550 tiles...

    ## Returning a list of tiles for an object of class GDALobj with 0 percent overlap

``` r
tile.tbl <- getSpatialTiles(obj, block.x=.5, return.SpatialPolygons=FALSE)
```

    ## Generating 550 tiles...
    ## Returning a list of tiles for an object of class GDALobj with 0 percent overlap

``` r
tile.tbl$ID <- as.character(1:nrow(tile.tbl))
head(tile.tbl)
```

    ##      xl    yl    xu    yu offset.y offset.x region.dim.y region.dim.x ID
    ## 1 108.7 -4.58 109.2 -4.08     5549        0          240          240  1
    ## 2 109.2 -4.58 109.7 -4.08     5549      240          240          240  2
    ## 3 109.7 -4.58 110.2 -4.08     5549      480          240          240  3
    ## 4 110.2 -4.58 110.7 -4.08     5549      720          240          240  4
    ## 5 110.7 -4.58 111.2 -4.08     5549      960          240          240  5
    ## 6 111.2 -4.58 111.7 -4.08     5549     1200          240          240  6

``` r
tile.pol <- SpatialPolygonsDataFrame(tile.lst, tile.tbl, match.ID = FALSE)
if(!file.exists("./data/tiling_50km_Indonesia.shp")){
  writeOGR(tile.pol, "./data/tiling_50km_Indonesia.shp", "tiling_50km_Indonesia", driver="ESRI Shapefile")
}
```

this gives a total of 550 tiles:

``` r
te <- as.vector(extent(x))
library(tmap)
data("World")
tm_shape(World, xlim=te[c(1,2)], ylim=te[c(3,4)], projection="longlat") +
  tm_polygons() +
  tm_shape(as(tile.lst, "SpatialLines")) + tm_lines()
```

    ## Linking to GEOS 3.6.1, GDAL 2.2.3, PROJ 4.9.3

![Tiling system based on the 50 km by 50 km
tiles.](Computing_large_rasters_in_parallel_files/figure-gfm/plot-tiles-1.png)

Note that size of tiles needs to be carefully planned so that each tile
can still be loaded in memory. If a HPC system has more cores, then in
average size of tiles in memory needs to be smaller otherwise RAM might
still be a problem for achieving fully parallelized computing.

We can visualize a single tile just to see that the images has been
subset correctly:

``` r
## plot tile number 124:
i = 124
m <- readGDAL("./data/Indonesia_ESA_lcc_300m_2000.tif", 
              offset=unlist(tile.tbl[i,c("offset.y","offset.x")]),
              region.dim=unlist(tile.tbl[i,c("region.dim.y","region.dim.x")]),
              output.dim=unlist(tile.tbl[i,c("region.dim.y","region.dim.x")]))
```

    ## ./data/Indonesia_ESA_lcc_300m_2000.tif has GDAL driver GTiff 
    ## and has 5789 rows and 5280 columns

``` r
plot(raster(m), legend=FALSE, col=rgb(leg$R/255, leg$G/255, leg$B/255))
```

![Single tile loaded into memory and
plotted.](Computing_large_rasters_in_parallel_files/figure-gfm/plot-tile-lcc-1.png)

We can further use the snowfall package to compute all land cover
changes and save them to disk:

``` r
library(snowfall)
```

    ## Loading required package: snow

``` r
sfInit(parallel=TRUE, cpus=parallel::detectCores())
```

    ## Warning in searchCommandline(parallel, cpus = cpus, type
    ## = type, socketHosts = socketHosts, : Unknown option on
    ## commandline: rmarkdown::render('D:/git/bcgov-r-geo-workshop/
    ## 20191107_Day_3_PA_BigRasters/Computing_large_rasters_in_parallel.Rmd',
    ## encoding

    ## R Version:  R version 3.5.3 (2019-03-11)

    ## snowfall 1.84-6.1 initialized (using snow 0.4-3): parallel execution on 12 CPUs.

``` r
sfExport("make_LC_tiles", "tile.tbl", "leg.lcc")
sfLibrary(rgdal)
```

    ## Library rgdal loaded.

    ## Library rgdal loaded in cluster.

``` r
sfLibrary(plyr)
```

    ## Library plyr loaded.

    ## Library plyr loaded in cluster.

``` r
out.lst <- sfClusterApplyLB(1:nrow(tile.tbl), 
                function(x){ make_LC_tiles(x, tile.tbl, leg.lcc=leg.lcc) })
sfStop()
```

    ## 
    ## Stopping cluster

``` r
## takes few seconds depending on the number of cores
```

<img src="./tex/htop_8_cores.png" title="Fully parallelized computing using 8 cores. Displayed using htop software." alt="Fully parallelized computing using 8 cores. Displayed using htop software." width="100%" />

This shows that the script has generated some 295 tiles in total. Note
that if all land cover classes are unchanged, then there is no need to
generate a Geotiff so that the total number of tiles is much smaller
than what we get with `getSpatialTiles` function:

``` r
t.lst <- list.files("./tiled", pattern=".tif", full.names=TRUE)
str(t.lst)
```

    ##  chr [1:295] "./tiled/T_100.tif" "./tiled/T_101.tif" ...

From the list of files we can build a mosaic using GDAL and save it to
disk (Mitchell & GDAL Developers, 2014):

``` r
out.tmp <- "./data/t_list.txt"
vrt.tmp <- "./data/indonesia.vrt"
cat(t.lst, sep="\n", file=out.tmp)
system(paste0('gdalbuildvrt -input_file_list ', out.tmp, ' ', vrt.tmp))
system(paste0('gdalwarp ', vrt.tmp, 
             ' \"./data/Indonesia_ESA_lcc_300m_change.tif\" ', 
             '-ot \"Int16\" -dstnodata \"-32767\" -co \"BIGTIFF=YES\" ',  
             '-multi -wm 2000 -co \"COMPRESS=DEFLATE\" -overwrite ',
             '-r \"near\" -wo \"NUM_THREADS=ALL_CPUS\"'))
```

``` r
raster("./data/Indonesia_ESA_lcc_300m_change.tif")
```

    ## class      : RasterLayer 
    ## dimensions : 5760, 5280, 30412800  (nrow, ncol, ncell)
    ## resolution : 0.002083294, 0.002083294  (x, y)
    ## extent     : 108.7, 119.6998, -4.580189, 7.419585  (xmin, xmax, ymin, ymax)
    ## crs        : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
    ## source     : D:/git/bcgov-r-geo-workshop/20191107_Day_3_PA_BigRasters/data/Indonesia_ESA_lcc_300m_change.tif 
    ## names      : Indonesia_ESA_lcc_300m_change 
    ## values     : -32768, 32767  (min, max)

<img src="./tex/Indonesia_ESA_lcc_300m_change_preview.jpg" title="Land cover class changes (2000 to 2015) for Kalimantan." alt="Land cover class changes (2000 to 2015) for Kalimantan." width="100%" />

Note that, to properly optimize computing, one might have to go through
several iterations of improving the function and the tiling system.
Also, when updating some results, it is a good idea to update only the
tiles that need to be updated, which can again be specified in the
function. Note also that from the code above, at any stage, we do not
read the large images to R but only use R to program functions, run
computing and build mosaics / large objects.

## References

<div id="refs" class="references">

<div id="ref-kirches2014land">

Kirches, G., Brockmann, C., Boettcher, M., Peters, M., Bontemps, S.,
Lamarche, C., … Defourny, P. (2014). *Land Cover CCI Product User Guide:
Version 2* (p. 4). ESA.

</div>

<div id="ref-mitchell2014geospatial">

Mitchell, T., & GDAL Developers. (2014). *Geospatial Power Tools: GDAL
Raster & Vector Commands*. Locate Press.

</div>

</div>
