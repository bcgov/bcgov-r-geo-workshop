<a id="devex-badge" rel="Exploration" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>


# bcgov-r-geo-workshop

This repository contains lessons & resources supporting a [FLNRO-sponsored bcgov North Area R Geospatial Workshop & Hackathon](https://github.com/bcgov/bcgov-data-science-cop/tree/master/2019/2019-11-05_r-spatial-pg) staff-driven training event in Prince George, British Columbia (November 5-8, 2019).


Here, you will find:

- Friendly workshop reminders
- Teaching materials
- Resources & links to learning resources
- Hackathon project ideas and discussion via the repo [issues](https://github.com/bcgov/bcgov-r-geo-workshop/issues) 

------

### Event Details 
- _Who_: Current intermediate B.C. Government R users who would like to do more geospatial analysis in R
- _What_: Workshop & Hackathon to learn about geospatial tools in R
- _Where_: Aleza Room, Plaza 400, 1011 4th Ave, Prince George, BC V2L 3H9
- _When_: 1 PM Tuesday November 5th to 5 PM Friday November 8th, 2019
- _Cost_: Free for participants


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
- R
  - **Mandatory**: Install R and RStudio [link](https://github.com/bcgov/bcgov-data-science-resources/wiki/Installing-R-&-RStudio)
  - **Mandatory**: Install R packages (more to come): <br>
      `c("tidyverse", "sf", "sp","raster",`<br>
      `"stars", "lwgeom", "mapview", "ggplot2",`<br>
      `"lidR", "gdalcubes")`
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
  
- Git + Github
  - **Mandatory**: Install Git on the laptop you are bringing  [link](https://git-scm.com/)
  - **Mandatory**: Create a GitHub account at least 1 week before the workshop [link](https://github.com/)
  - Recommended Reading: 
    - [Read Getting Started with Git & GitHub](https://github.com/bcgov/bcgov-data-science-resources/wiki/Getting-Started-with-Git-&-GitHub)
    - [Read Happy Git with R](https://happygitwithr.com/)
- GIS Tools (For Day 3 with T. Hengl)
  - **Mandatory**: QGIS [link](https://qgis.org/en/site/forusers/download.html)
  - **Mandatory**: SAGA [link](https://sourceforge.net/projects/saga-gis/)
  - **Mandatory**: Google Earth [link](https://support.google.com/earth/answer/21955?hl=en)
  
------

### Workshop Schedule

#### Day 1 - Tuesday Nov. 5 - _Some_ Best Practices for Code Sharing
- **AM Optional:** Open house for software installation & troubleshooting (RStudio, R, Git) and GitHub account creation
- **PM:** Git + bcgov GitHub & Project Management with RStudio [teaching materials](https://github.com/bcgov/bcgov-r-geo-workshop/tree/master/20191105_Day_1_PM_Intro) [_Instructor: [Steph Hazlitt](https://github.com/stephhazlitt)_]
-	**Evening:** Social ice breaker (_self-pay_)

#### Day 2 - Wednesday Nov. 6 - Introduction to Geospatial in R 
-	**AM:** Vector manipulation and visualization [teaching materials](https://github.com/bcgov/bcgov-r-geo-workshop/tree/master/20191106_Day_2_AM_Vector) [_Instructors: [Sam Albers](https://github.com/boshek) & [Andy Teucher](https://github.com/ateucher)_]
-	**PM:** Raster manipulation and visualization [teaching materials](https://github.com/bcgov/bcgov-r-geo-workshop/tree/master/20191106_Day_2_PM_Raster) [_Instructors: [Alex Bevington](https://github.com/bevingtona) & [Gen Perkins](https://github.com/gcperk)_]
-	**Evening:** Group dinner (_self-pay_)

#### Day 3 - Thursday Nov. 7 - Geocomputation & Machine Learning in R [_Instructor: [Tomislav Hengl](https://github.com/thengl)_] 
-	**AM:** Trends and new opportunities in processing spatial and Earth Observation data in R
- **AM:** Five key steps to processing large rasters in R
- **PM:** Ensemble Machine Learning as a general framework for predictive mapping 
- **PM:** Automated predictive mapping using landmap package
-	**Evening:** Group dinner (_self-pay_)

#### Day 4 - Friday Nov. 8 - Hackathon 
-	**AM:** Pick projects and separate into groups of 4. To submit a hackathon project or idea, or comment on an existing project, please submit an  [issue](https://github.com/bcgov/bcgov-r-geo-workshop/issues?q=is%3Aissue+is%3Aopen+label%3A%22geospatial+hackathon%22).
-	**PM:** End of day -> report back to group
-	**Evening:** No event
 
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
