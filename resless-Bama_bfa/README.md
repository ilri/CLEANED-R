# CLEANED R code for Bama Burkina Faso (ReSLess project) 

This folder contains all codes and data necessary to run CLEANED as a stand alone on a computer. The code corresponds to the three shiny tools : 
* The simplified version used in the workshop (https://ilri.shinyapps.io/cleaned-r-resless-bama_bfa/)
* the same version in French (https://ilri.shinyapps.io/cleaned-r-resless-bama_bfa_f/) 
* the expert interface (https://ilri.shinyapps.io/cleaned-r-resless-bama_bfa_ex/). 

## Structure of the tool 
The tool consistens of 5 folders that need to be created on the computer 
* 1-input : this folder contains all the data to be downloaded from https://drive.google.com/open?id=1Lw7S9S0msH_bEYLVuY4ws2l6vSEEOxqv  
* 3-cleaned : this folder contains the core code of CLEANED
* 4-output : this folder is used to save the output of the CLEANED tool 
* 5-installation and documentation : contains supporting documents. 
* www : contains the images that are loaded into the R-shiny tool 

## Core codes (in 3-cleaned)

* interface in shiny: click on run app in R to start the interface comes in 3 versions 
  + based on presets for the transformation game (preset/vignettes) in English
  + based on presets for the transformation game (preset/vignettes) in French
  + expert version
* 0-user definition (manual interface)
* 2-feedbasket_nonlinear2 : productivity computations
* 2-load data : loading data from 1-input
* 2-luccomp : the land use module
* 1-water : water impact
* 1-ghg3 : greenhouse gas emmissions
* 1-biodi : biodiversity impact
* 1-soil impact
codes containing an F in their names, are used by the French version of the tool

To run the r-shiny stand alone version on your computer make sure that you have the following packages downloaded : 
shiny, shinydashoared, shinyjs, graphics, rgeos, sp,raster, maptools rgdal, gridExtrea, grid, RColorBrewer.

This code was developped by Catherine Pfeifer (c.pfeifer@cgiar.org) at the International Livestock Research Institute  (www.ilri.org) and Joanne Morris Stockholm Environmental Institute (www.sei.org) based in York. 
The shiny interface was developed by Victor Moses from LocateIT Kenya (http://www.locateit.co.ke/) 

CLEANED parametrization for Bama Burkina Faso has been funded by the SAIRLA program of DFID as well as the livestock CRP (and formely by the livestock and fish CRP).The program thanks all donors and organizations which globally supported its work through their contributions to the CGIAR system.


Related publications 
http://hdl.handle.net/10568/93076  and 
http://hdl.handle.net/10568/93069 
