# CLEANED-R

The CLEANED R tool, is a quick, ex-ante and spatially explict environmental impact assement tool assessing changes from transforming livestock value chains. 

It makes use of a whole range of open spatial data, and therefore there is a specific tool for each location.The sub-folder contain the stand alone tool for each specific location, and where available the Rshiny user interface. 
The name of each tool first refers to the project, then to the specific location and the country code. 

CLEANED-R needs to be adjusted for the specific context in which it is used. Each folder with a study area names contains the specific code for that particular area.

The following study areas are now available

1. CLEANED-R-ReSLess-Bama_BFA https://github.com/ilri/CLEANED-R/tree/master/resless-Bama_bfa
1. CLEANED-R-ReSLess-Lushoto_TZA : https://github.com/ilri/CLEANED-R/tree/master/resless-lushoto_tza
1. CLEANED-R-ReSLess-Atsbi_ETH https://github.com/ilri/CLEANED-R/tree/master/resless-atsbi_eth
1. CLEANED-R-IMPACT-TZA https://github.com/ilri/CLEANED-R/tree/master/IMPACT-TZA
1. CLEANED-R-IMPACT-BFA https://github.com/ilri/CLEANED-R/tree/master/IMPACT-BFA 

The ReSLess project funded by the SAIRLA program of DFID and the Livestock CRP, has parameterized the CLEANED tool at landscape scale for 3 study area, namely Bama in Bukina Faso, Lushoto in Tanzania and Atsbi in Ethiopia. These tools have been use in a learning space along with a game aiming at stakeholders to explore possible livestock future and negociate the best alternatives for their area. This project is led by Stockholm Environment Institute in collaboration with ILRI.  

The IMPACT-CLEANED linkage was funded by PIM CRP, it links directly IMPACT results to CLEANED at national scale and allows to add environmenatal impacts to demand in animal source food changes.


Each of the CLEANED tool comes with 4 folders.

* input data (a link is shared to that data)
* the CLEANED code in itself, this folder also contains the code for the Shiny interface (for some version, the code come directly in the initial folder and not in a subfolder) 
* ouput, this is where ouputs are stored when the model is run 
* www is a folder containing images that are required by shiny (only for those tools that have a shiny interface)

To run the code you will need the following packages : raster, shiny, shinydashboard, maptools, Rcolorbrewer, gridExtra and you will need to adjust the path to the cleaned folder in your computer, or in the shiny app code (named interface) or the user definition.

Relevant documents explaining equations in the tool can be found in the documentation folder (https://github.com/ilri/CLEANED-R/tree/master/documenation). 
All officially released documents related to cleaned can be found on the cgspace : https://cgspace.cgiar.org/handle/10568/33745 
The CLEANED tool was originated through a Gates foundation funded project. 

