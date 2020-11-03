[![img](https://img.shields.io/badge/Lifecycle-Stable-97ca00)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)

# bcgov-r-geo-workshop

This repository contains lessons & resources supporting a [FLNRO-sponsored bcgov North Area R Geospatial Workshop & Hackathon](https://github.com/bcgov/bcgov-data-science-cop/tree/master/2019/2019-11-05_r-spatial-pg) staff-driven training event in Prince George, British Columbia (November 5-8, 2019).


Here, you will find:

- Friendly workshop reminders
- Teaching materials
- Resources & links to learning resources
- Hackathon project ideas and discussion via the repo [issues](https://github.com/bcgov/bcgov-r-geo-workshop/issues?q=is%3Aissue+is%3Aopen+label%3A%22geospatial+hackathon%22) 

------

### Event Details 
- _Who_: Current intermediate B.C. Government and external R users who would like to do more geospatial analysis in R
- _What_: Workshop & Hackathon to learn about geospatial tools in R
- _Where_: Aleza Room, 4th floor, Plaza 400, 1011 4th Ave, Prince George, BC V2L 3H9 (entrance at Queensway and 4th Ave)
- _When_: 1 PM Tuesday November 5th to 5 PM Friday November 8th, 2019
- _Cost_: Free for participants

------

### Course Materials
**If you are a course attendee, please note that course materials should be downloaded after November 5th**

To download course materials and open an instance of RStudio, please run this code:

```
if (requireNamespace("usethis")) {
  install.packages("usethis")
}
library(usethis)
use_course("bcgov/bcgov-r-geo-workshop")
```

The course materials are by default downloaded to your desktop. If you would like to download to a different location you can set it via the `destdir` argument.

------

### Workshop Difficulty Level
We expect attendees to have at least the following level of experience:

  - Intermediate **R & RStudio** (e.g. package management, write functions, tidyverse syntax, troubleshooting, ...)
  - Intermediate **GIS** 
  - Basic or intermediate **statistics**
  - Basic **Git + GitHub**
  
------

### Pre-Workshop Requirements (_Please Read Carefully_)
- Laptop 
  - **Mandatory**: Wifi 
  - **Mandatory**: Installation privileges
- Coffe and water
  - Snacks or drinks will **not** be supplied 
  - There are coffee shops nearby, please bring a reusable mug
  - There is a water fountain, please bring a reusable bottle
- R
  - **Mandatory**: Install R and RStudio ([_link_](https://github.com/bcgov/bcgov-data-science-resources/wiki/Installing-R-&-RStudio))
  - **Mandatory**: Install R packages (more to come): 
      `install.packages(c("tidyverse","dplyr","sf", "sp","raster","rasterVis","RStoolbox","fasterize","mapedit","purrr","geosphere","measurements","RColorBrewer","smoothr","magick","stars", "lwgeom", "mapview", "ggplot2","lidR", "gdalcubes", "ggspatial", "bcdata","bcmaps"))`
  - **Mandatory for R Beginners**: 
    - [Reproducible Scientific Analysis](https://swcarpentry.github.io/r-novice-gapminder/)
  - Recommended Reading (Beginner): 
    - [RStudio for Beginners](https://education.rstudio.com/learn/beginner/)
    - [Getting Started with Data in R](https://moderndive.com/1-getting-started.html)
    - [RStudio Hotkeys, Tips and Tricks](https://appsilon.com/r-studio-shortcuts-and-tips-part-2/)
  - Recommended Reading (Intermediate): 
    - [Reproducible Data Science](https://r4ds.had.co.nz/)
    - [Geocomputation with R](https://geocompr.robinlovelace.net/)
    - [Introduction to Data Science](https://rafalab.github.io/dsbook/)
    - [Predictive Soil Mapping with R](https://soilmapper.org/)
    - [Interpretable Machine Learning](https://christophm.github.io/interpretable-ml-book/)
    - [OpenGeoHub 2019 Summer School](https://www.youtube.com/playlist?list=PLXUoTpMa_9s1npXD6S9M0_2pUgnTd6cqV) [Videos]
- Git + Github
  - **Mandatory**: Install Git on the laptop you are bringing  ([_link_](https://git-scm.com/))
  - **Mandatory**: Create a GitHub account at least 1 week before the workshop ([_link_](https://github.com/))
  - Recommended Reading: 
    - [Read Getting Started with Git & GitHub](https://github.com/bcgov/bcgov-data-science-resources/wiki/Getting-Started-with-Git-&-GitHub)
    - [Read Happy Git with R](https://happygitwithr.com/)
- GIS Tools (For Day 3 with T. Hengl)
  - **Mandatory**: QGIS ([_link_](https://qgis.org/en/site/forusers/download.html))
  - **Mandatory**: Google Earth ([_link_](https://support.google.com/earth/answer/21955?hl=en))
  - **Recommended**: SAGA ([_link_](https://sourceforge.net/projects/saga-gis/))
  
------

### Workshop Schedule

- **_Some_ Best Practices for Code Sharing** - Tuesday Nov. 5 (1pm - 5pm)
  - **AM Optional (9am - 1pm):** Open house for software installation & troubleshooting (RStudio, R, Git) and GitHub account creation
  - **PM:** Git + bcgov GitHub & Project Management with RStudio &mdash; [_course materials_](https://github.com/bcgov/bcgov-r-geo-workshop/tree/master/20191105_Day_1_PM_Intro) [_Instructor: [Steph Hazlitt](https://github.com/stephhazlitt)_]
  -	**Evening:** Social ice breaker (_self-pay_)

- **Introduction to Geospatial in R** - Wednesday Nov. 6 (8:30am - 4:30pm)
  -	**AM:** Vector manipulation and visualization &mdash; [_course materials_](https://github.com/bcgov/bcgov-r-geo-workshop/tree/master/20191106_Day_2_AM_Vector) [_Instructors: [Sam Albers](https://github.com/boshek) & [Andy Teucher](https://github.com/ateucher)_]
  -	**PM:** Raster manipulation and visualization &mdash; [_course materials_](https://github.com/bcgov/bcgov-r-geo-workshop/tree/master/20191106_Day_2_PM_Raster) [_Instructors: [Alex Bevington](https://github.com/bevingtona) & [Gen Perkins](https://github.com/gcperk)_]
  -	**Evening:** Group dinner (_self-pay_)

- **Geocomputation & Machine Learning in R** - Thursday Nov. 7 (8:30am - 4:30pm):  [_Instructor: [Tomislav Hengl](https://github.com/thengl)_]
  -	**AM:** Trends and new opportunities in processing spatial and Earth Observation data in R
  - **AM:** Five key steps to processing large rasters in R
  - **PM:** Ensemble Machine Learning as a general framework for predictive mapping 
  - **PM:** Automated predictive mapping using landmap package
  -	**Evening:** Group dinner (_self-pay_)

- **Hackathon** - Friday Nov. 8 (8:30am - 4:30pm)
  -	**AM:** Pick projects and separate into groups of 4. Hands on collaboration for all levels of users. To submit a hackathon project or idea, or comment on an existing project, please submit an  [issue](https://github.com/bcgov/bcgov-r-geo-workshop/issues?q=is%3Aissue+is%3Aopen+label%3A%22geospatial+hackathon%22).
  -	**PM:** End of day -> report back to group
  -	**Evening:** No event
  - Note: Hackathon projects will be hosted in the [bcgov-datasci-labs](https://github.com/bcgov-datasci-labs) GitHub organization. See Andy Teucher to get added.
 
------

### Registration

Registration is closed. Please contact alexandre.bevington [at] gov.bc.ca  for questions or concerns. 


### Code of Conduct

In the interest of ensuring a safe environment for all,  all attendees, speakers and organisers of the r-geospatial-workshop-hackathon (Prince George, November 2019) must agree to follow the [bcgov standards of conduct](https://www2.gov.bc.ca/gov/content/careers-myhr/about-the-bc-public-service/ethics-standards-of-conduct/standards-of-conduct) and the day's [code of conduct](https://www.contributor-covenant.org/version/1/4/code-of-conduct).


### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/bcgov-r-geo-workshop/issues/).


### How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.


### License

[![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)

```
Unless otherwise stated, Copyright 2019 Province of British Columbia

This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
```
---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
