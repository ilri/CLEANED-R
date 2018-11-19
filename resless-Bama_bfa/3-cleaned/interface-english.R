####################################################################################################
#
# Shiny App for CLEANED System ILRI  Aug 2018 by Victor N. Mose and Caroline Mburu
####################################################################################################
## app.R ##


rm(list=ls())
options(repos=c(CRAN="https://cran.rstudio.com"))
library(rsconnect)
library(shiny)
library(shinydashboard)
library(shinyjs)
library(graphics)
library(rgeos)
library(sp)
library(raster)
library(maptools)
library(rgdal)
library(gridExtra)
library(grid)
library(RColorBrewer)

path<<-'D:/Dropbox/CLEANED - Burkina_final'
setwd(path)

source('2-load_data.R')

sidebar1<-dashboardSidebar(width=150,
                 sidebarMenu(
                   menuItem(""),
                   menuItem("ABOUT CLEANED:", tabName = "widgets1", icon = icon("th")),
                   menuItem("SIMPLE USERS: ", tabName = "dashboard1", icon = icon("dashboard")),
                   menuItem("EXPERT USERS:", tabName = "widgets1a", icon = icon("th")),
                   menuItem("FRANCAIS", tabName = "widF", icon = icon("th"))
                   # menuItem("Vegetation mapping", tabName = "Veg", icon = icon("th"))
                 ))



body <- dashboardBody( 
  
  useShinyjs(),
               
  actionButton("hideSidebar", "Hide sidebar menu:",
               icon("angle-double-left"), 
               style="color: #fff; background-color: #8B2323; border-color: #2e6da4"),
  
  actionButton("showSidebar", "Show sidebar menu:",
               icon("angle-double-right"), 
               style="color: #fff; background-color: #8B2323; border-color: #2e6da4"),
  

  tags$head(tags$style(HTML(".grViz { width:100%!important; font-size:10px}"))),
  
  #tags$head(tags$style(HTML("div.col-sm-6 {padding:0.1px}"))),
  
  tabItems(
    
    #first tab item
    
    tabItem(tabName ="widgets1",fluidRow (

      
box(width=12,

column(width=5,offset=1,align="center", 
img(src="Buks1.jpg",width=650)),                                         
                                              
 background ="blue"),



box(width=12,background ="green", 
   column(width=1,offset=1,align="center",
  img(src="Buks.jpg", width=650))
           
)
    ),
fluidRow(box(width=12, background ="blue",title="Study area: Peri-urban area of Bobo Dioulasso Burkina Faso",
             column(width=1,offset=1,align="center",
          img(src="studyarea_ENa.jpg", width=650))),
box(width=12,background ="green", 
column(width=1,offset=1,align="center" ,
             img(src="Buks2.jpg", width=650)
         )
         )),


fluidRow (box(width=12,background ="light-blue", 
               column(width=1,offset=1,align="center" ,
               img(src="disc.jpg", width=650))
               
               
),
box(width=12,background ="green", 
    column(width=1,offset=1,align="center" ,
    img(src="otherp.jpg", width=650))

    
)
),

fluidRow (box(width=12,background ="light-blue", 
              column(width=1,offset=1, align="center",
               img(src="Refs.jpg", width=650))
             
               
),

tags$head(tags$style("#text1{color: red;
                                 font-size: 20px;
                     font-style: italic;
                     }"
                         )),


box(width=12,background ="black", title="Links",
    fluidRow(column(width=1,offset=1, h4("", style="padding:10px;")),
             url <- a("Click here for ILRI website", href="https://www.ilri.org/")),
    fluidRow(column(width=1,offset=1, h4("", style="padding:10px;")),
             url <- a("Click here for SEI website", href="https://www.sei.org")),
    fluidRow(column(width=1,offset=1, h4("", style="padding:10px;")),
             url <- a("Click here for LocateIT website", href="http://www.locateit.co.ke")),
    fluidRow(column(width=1,offset=1, h4("", style="padding:10px;")),
             url <- a("Click here for GITHUB link", href="https://github.com/pfeiferc/CLEANED-R/tree/master/Bama-BurkinaFaso")),
    fluidRow(column(width=1,offset=1, h4("", style="padding:10px;")),
             url <- a("Click here for CLEANED tool documentation", href="https://cgspace.cgiar.org/bitstream/handle/10568/93076/sairla_CLEANED.pdf?sequence=1&isAllowed=y")),
    fluidRow(column(width=1,offset=1, h4("", style="padding:10px;")),
             url <- a("Click here for related publications", href="https://cgspace.cgiar.org/handle/10568/33745"))
    #onclick=sprintf("window.open('%s')", url)
    #tagList("URL link:", url)
)

)









    ),
#Second tab item
tabItem(tabName="widgets1a",
        
        url <- a("Click here for the Advanced/Expert version of the CLEANED tool", href="https://ilri.shinyapps.io/Advancedcleanedtool/")
      
        ),
tabItem(tabName="widF",
        
        url <- a("Clickez ici pour la version francaise", href="https://ilri.shinyapps.io/Advancedcleanedtool/")
        
),

  #Fourth tab item
    tabItem(tabName = "dashboard1",
    
    
  mainPanel(
   
    
    
    
    tabsetPanel(id = "inTabset",
                        tabPanel(title = "Production", value = "panel1", ""),
                        tabPanel(title = "Water impact", value = "panel2",
                                 fluidRow(box(width=12, background ="blue",img(src="waterimpact.jpg", width=500))),
                                 fluidRow(box(width=12, title = "", height=700,
                                              actionButton("gowt", "Run the water impact"),
                                            
                                              plotOutput("plot12"))),
                                 
                                 fluidRow(box(width=12, title = "Summary table water impact",
                                              
                                            
                                              plotOutput("plotable"))
                                 )
                        ),
                        tabPanel(title = "Greenhouse gas impact", value = "panel3", 
                                 fluidRow(box(width=12, background ="green",img(src="greenhouseimpact.jpg", width=500))),
                                 fluidRow(box(width=12, title = " ",height=700,
                                              actionButton("gogh", "Run Greenhouse impact "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plot123"))),
                                 fluidRow(box(width=12, title = "Summary table green house impact",
                                              #actionButton("gowt", " "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotableghg"))
                                 )),
                        tabPanel(title = "Biodiversity impact", value = "panel4", 
                                 fluidRow(box(width=12, background ="light-blue",img(src="biodiversityimpact.JPG", width=500))),
                                 fluidRow(box(width=12, title = " ",height=700,
                                              actionButton("gobdiv", "Run biodivesity impact"),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plot12bid"))
                                          
                                 ),
                                 
                                 fluidRow(box(width=12, title = "Summary table biodiversity impact",
                                              #actionButton("gowt", " "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotablediv"))
                                 )),
                        tabPanel(title = "Soil impact", value = "panel5", 
                                 fluidRow(box(width=12, background ="red",img(src="soilimpact.JPG", width=500))),
                                 fluidRow(box(actionButton("gosol", "Run soil impact",icon = NULL), title = " ",height=1000, width=12,
                                              
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotsoil"),align = "centre")
                                          
                                          # box(width=4, title = "Summary table soil pathway",
                                          #       #actionButton("gowt", " "),
                                          #      # numericInput("n", "n", 50),
                                          #       plotOutput("plotablesoil"))   
                                          
                                          
                                 ),
                                 
                                  fluidRow(box(width=12, title = "Summary table soil impact",
                                              #actionButton("gowt", " "),
                                               # numericInput("n", "n", 50),
                                               plotOutput("plotablesoil")))
                                 )
  )),
  
  
  

            
  tags$head(tags$style(HTML("div.col-sm-6 {padding:1px}"))),

  
  
#   fluidRow(
#   box(status = "primary",width = 12, "PRODUCTION CATEGORIES :-----------:-----------:------------:-------------:------:-----:-----------: DATA ALREADY LOADED",background = "navy")
# ),
fluidRow(
  box(#status = "warning", title=" ", width = 12, "", background ="red",
    HTML('<script type="text/javascript">
        $(document).ready(function() {
         $("#DownloadButton").click(function() {
         $("#Download").text("Loading...");
         });
         });
         </script>
         '),
      div(style="height: 35px;", actionButton("go", "Click here to update production computation")) ,width = 12, background ="red" )
  
 
  ),

fluidRow(box(width=12,
             #actionButton("go", " "),
             # numericInput("n", "n", 50),
             verbatimTextOutput("plot",  placeholder = TRUE)
             
             

)),



fluidRow(
  box(status = "primary",width = 12, "PRODUCTION CATEGORIES :-----------:-----------:------------:-------------:------:-----:-----------: DATA ALREADY LOADED",background = "navy")
),
fluidRow(
  box(status = "warning",width = 2, "",background ="red", textInput("name","Enter your name here:","My own")),
  box(status = "warning", width = 2, "PASTORAL TRANSHUMANT HERD",background ="maroon"),
  box(status = "warning", width = 2,"PASTORAL DAIRY HERD",background ="maroon"),
  box(status = "warning", width = 2, "DAIRY ANIMALS",background ="maroon"),
  box(status = "warning", width = 2, "FATTENING ANIMAL",background ="maroon"),
  box(status = "warning", width = 2, "DRAFT ANIMALS",background ="maroon")),
  


fluidRow(
  box(status = "warning", width = 2, "", background ="green",
      div(style="height: 35px;",textInput("1a", "", value="No. of troupeaux(herd)")),
      div(style="height: 35px;",textInput("2a", "",value="No. of animals per troup")),
      textInput("3a", "",value="No. of Animals")
   
      
  ), 

  box(status = "warning", width = 1, "",background ="green",
      div(style="height: 35px;;font-size:12px;",tags$style("#tt {font-size:12px;}"),numericInput("tt", " LongT", 100, min = 60, max =1000000)),
          #tags$style(type="text/css", "#string { height: 50px; width: 100%; text-align:center; font-size: 10px; display: block;}")    
      div(style="height: 35px;",numericInput("att", "", 120, min = 60, max = 1000000)),
      textInput("**", "", value="**")),

  
  box(status = "warning", width = 1, "",background ="green",
      div(style="height: 35px;",numericInput("tpt", " ShortT", 238, min = 60, max =1000000)),
      div(style="height: 35px;",numericInput("atpt", "", 120, min = 60, max = 1000000)),
      textInput("**", "", value="**")),
  
  
  box(status = "warning", width = 2,"",background ="green",
      
      div(style="height: 35px;",numericInput("tl", "", 200, min = 60, max = 1000000)),
      div(style="height: 35px;",numericInput("atl", "", 20, min = 60, max = 1000000)),
      textInput("mp211", "", value="**")),
      
  box(status = "warning", width = 2, "",background ="green",
      
      div(style="height: 35px;",textInput("mp11", "", value="N/A")),
      div(style="height: 35px;",textInput("mp12", "", value="N/A")),
      numericInput("numcow_d", "", 1400, min = 10, max = 1000000)),
   
  box(status = "warning", width = 2, " ",background ="green",
      div(style="height: 35px;",textInput("mpkk", "", value="N/A")),
      div(style="height: 35px;",textInput("mpkk1q", "", value="N/A")),
      numericInput("numcow_f", "", 55000, min = 0, max = 1000000)),

  
  box(status = "warning", width = 2, " ",background ="green",
      div(style="height: 35px;",textInput("mpkk2", "", value="N/A")),
      div(style="height: 35px;",textInput("mpkk3", "", value="N/A")),
      numericInput("numcow_da", "", 22500, min = 0, max = 1000000))
   
  
),
fluidRow(box(status = "warning", width = 2, " ",background ="green",
numericInput("numcow_c", "No. of animals crossing area:", 200000, min = 10, max =1000000 ))),

fluidRow(
  box(status = "primary",width = 12, " SELECT PRESET SCENARIOS :-----------:-----------:------------:-------------:------:-----:-----------: ",background = "navy"),
 sidebarPanel(
    tabsetPanel(id = "tabset",
                tabPanel("Agropastoral",
                         radioButtons("Ap", "", choices =c("ABR", "A1","A2"), selected = "ABR")
                        
                ),
                tabPanel("Pastoral dairy",
                         radioButtons("L", "", choices=c('LBR','L1','L2'),selected='LBR')
                ),
                tabPanel("Dairy",
                         radioButtons("M", "", choices=c('MBR','M1','M2'),selected='MBR')
                        
                ),
                tabPanel("Fattening",
                         radioButtons("Fa", "", choices=c('FBR','F1','F2') ,selected='FBR')
                        
                ),
                
                
                tabPanel("Draft",
                         radioButtons("Tr", "", choices=c('TBR','T1'),selected='TBR')
                        
                ),
                # tabPanel("Ca",
                #          radioButtons("Ca", "", choices=c('CBR','C1'),selected='CBR')
                #          
                # ),
                
                tabPanel("LUC",
                         radioButtons("LUC", "", choices=c('No change','LUC1','LUC2','LUC3','LUC4'),selected='No change')
                         
                )
                
    )
    )
 
  ),
  
fluidRow(
  box(width=6, " Baseline Productivity",plotOutput("baseplot")))

)



)

)



# We'll save it in a variable `ui` so that we can preview it in the console
ui <- dashboardPage(
  dashboardHeader(title = "SAIRLA PROJECT : CLEANED INTERFACE SYSTEM FOR BURKINA FASO",titleWidth=750,
                  
                   # tags$li(class = "dropdown",
                   #         tags$a(href="https://www.ilri.org", target="_blank", 
                   #                tags$img(height = "30px", alt="SNAP Logo", src="https://www.ilri.org/sites/default/files/styles/card_image_thumb/public/default_images/defautl_img.jpg")
                   #        ))),     
  
  
   tags$li(class = "dropdown",
           tags$a(href="www", target="_blank", 
                  tags$img(height = "60px", alt="SNAP Logo", src="crpaaseia.jpg")
           ))
   ), 
  
  sidebar1,
  
 
  
  
  body
  
  
  
)







server = function(input, output, session) {
  

  observeEvent(input$showSidebar, {
    shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
  })
  observeEvent(input$hideSidebar, {
    shinyjs::addClass(selector = "body", class = "sidebar-collapse")
  })
  
  
  
  
  
  
   pok<- eventReactive(input$go, {

     if(input$go==0)
       return()
    
     
     ####################################CLEANED version 2 for Burkina Faso ################################################
     # cleaned version 2
     # code by Catherine Pfeifer, ILRI, c.pfeifer@cgiar.org
     #code created on 20.6.2016
     #clearing all memory 
     rm(list=ls(all=TRUE))
     #set path to cleaned tool
     
     

     tt<<-input$tt#100
     #nombre de troupeau laitier (150 in Bama)
     tl<<-input$tl#200
     #nombre de troupeau qui ne font que la petite transhumance (180 in Bama)
     tpt<<-input$tpt#238
     #nombre moyen ou modal de tete dans un troupeau pour la petite ou la grande transhumance
     att<<-input$att#100
     atpt<<-input$atpt#100
     # nombre moyen ou modal de tete d'un troupeau laitier
     atl<<-input$atl#25
     
     
     # in the dairy only system (1400)
     numcow_d <<-input$numcow_d#1400
     
     
     # in the fattening system (55000)
     numcow_f<<-input$numcow_f #55000 
     
     # in draft system (22500) 
     numcow_da <<-input$numcow_da #22500
     
     #number of crossing animals 
     
     numcow_c<<- input$numcow_c #200000
     
     # presets 
    preset <<-1 #if 1 the interface uses the presets otherwise go to Advanced user interface. 
    scenario<<-read.csv('1-input/parameter/preset.csv',  skip=2)
    
  
     # select from the preset scenario
     
     Ap<<-input$Ap #'ABR'  #options are (ABR, A1,A2)
     L<<-input$L #'LBR'  #options are (LBR, L1, L2)
     M<<-input$M #'MBR'  #options are (MBR, M1, M2)
     Fa<<-input$Fa #'FBR'  #options are (FBR, F1, F2)
     Tr<<-input$Tr  # 'TBR'  #options are (TBR, T1)
     
     
     #Ca<<-input$Ca # 'CBR' #options are (CBR, C1)
     LUC<<-input$LUC # 'LUC0'  #options are (LUC0, LUC1,LUC2,LUC3,LUC4)
     
     #give your scanario a name 
     # name<<-"My Own"
     # if(name==""){ name<<-"My Own"} else {}
     name<<-input$name
     
     #############################manual defintion of the parameters#####################
     
     
     #seasonality 
     #transhumance seasonality 
     st1<<- 6 # season when transhumant animals are paturage in Bama and small transhumance in the study area (juillet-novembre)
     st2<<- 12-st1 # season when transhumant animals are gone (decembre - june) 
     #crop seasonality 
     ds<<- 7 #dry season (October- April)
     ws<<- 12-ds  # wet season (May-September )
     
     ws_st1<<-3 # number of month the transhumant troupeau is in area during the wet season
     ds_st1<<-3 # number of month the transhumant troupeau is in area during the dry season
     
     
     #DEFINE THE DIFFERENT SYSTEM 
     #################################
     
     # the extensive agro pastoral system
     
     
     # definition de l'animal extensif transhumant
     #define liveweigtht in kg for the the breed in the transhumant system (200)
    lwes<<-200
     # definition de l'animal extensif laitier
     #define liveweigtht in kg for the the breed in the transhumant system (200)
     lwles<<-220 
     #define milk yield (kg/cow/year) for the breed in the extensive system (400) 
     myles<<-600 # http://www.abcburkina.net/fr/nos-dossiers/la-filiere-lait/586-18-performances-laitieres-des-vaches-de-races-locales
     #dressing percentage http://www.dpi.nsw.gov.au/__data/assets/pdf_file/0006/103992/dressing-percentages-for-cattle.pdf
     des <<- 0.38
     
     #feed basket for transhumant troupeau in the extensive systems
     # season wet season 
     #natural grass in percent (95)
     efng1<<- 0  
     #crop residues cerals (0)
     efrc1<<- 0
     #crop residue from rice
     efrr1<<-0
     #crop residue legumes (10) 
     efrl1<<-0
     #planted fodder (0)
     efpf1<<-0  
     # concentrates cereal (maize bran) (0)
     efconc1<<- 0
     # concentrates oilseed cake (0)
     efconos1<<- 0
     #check if a 100%
     
     #season dry season  
     #natural grass in percent (100)
     efng2<<- 0 
     #crop residues cerals (0)
     efrc2<<- 0
     #crop residue from rice
     efrr2<<-0 
     #crop residue legumes (0) 
     efrl2<<-0
     #planted fodder (0)
     efpf2<<-0  #
     # concentrates cereal (maize bran) (0)
     efconc2<<- 0
     # concentrates oilseed cake (0)
     efconos2<<- 0
     #check if a 100%
     
     #feed basket for milking troupeau in the extensive systems
     # season wet
     #natural grass in percent (95)
     lefng1<<- 0
     #crop residues cerals (0)
     lefrc1<<- 0
     #crop residue from rice
     lefrr1<<-0
     #crop residue legumes (10) 
     lefrl1<<-0
     #planted fodder (0)
     lefpf1<<-0  #Feed scenario 20 
     # concentrates cereal (maize bran) (0)
     lefconc1<<- 0
     # concentrates oilseed cake (0)
     lefconos1<<- 0
     #check if a 100%
     
     #season dry 
     #natural grass in percent (100)
     lefng2<<-0  
     #crop residues cerals (0)
     lefrc2<<- 0  
     #crop residue from rice
     lefrr2<<-0
     #crop residue legumes (0) 
     lefrl2<<-0
     #planted fodder (0)
     lefpf2<<-0  #Feed scenario 20 
     # concentrates cereal (maize bran) (0)
     lefconc2<<- 0
     # concentrates oilseed cake (0)
     lefconos2<<- 0
     #check if a 100%
     
     
     # manure management in the extensive system  system in percent (100%)
     #(if ipcc=1, then no need to adjust this )
     es_lagoon_perc<<- 00
     es_liquidslurry_perc<<-00
     es_solidstorage_perc<<-00
     es_drylot_perc<<-00
     es_pasture_perc<<-100
     es_dailyspread_perc<<-00
     es_digester_perc<<-00
     es_fuel_perc<<-00
     es_other_perc<<-00
     #do by season 
     
     
     #manure management for the troupeau laitier
     les_lagoon_perc<<- 00
     les_liquidslurry_perc<<-00
     les_solidstorage_perc<<-20
     les_drylot_perc<<-00
     les_pasture_perc<<-80
     les_dailyspread_perc<<-00
     les_digester_perc<<-00
     les_fuel_perc<<-00
     les_other_perc<<-00
     #do by season 
     
     
     
     ####################################### the fattening system###################
     
     
     
     #define liveweigtht in kg for the the breed in the semi intensive system (250)
     lwsis<<-250 
     #define milk yield (kg/cow/year) for the breed in the semi intensive system (0)
     mysis<<-0
     
     #dressing percentage http://www.dpi.nsw.gov.au/__data/assets/pdf_file/0006/103992/dressing-percentages-for-cattle.pdf
     dsis <<- 0.48
     
     #feed basket  for fattening  system season wet
     
     #natural grass in percent (15)
     sfng1<<-0
     #crop residues cereals (40)
     sfrc1<<-0
     #crop residue from rice
     sfrr1<<- 0
     #crop residue legumes (30)
     sfrl1<<-0
     #planted fodder ()
     sfpf1<<-0 
     # concentrates cereal (maize bran) (5)
     sfconc1<<- 0
     # concentrates oilseed cake (10)
     sfconos1<<- 0  
     
     # dry season 
     #natural grass in percent (50)
     sfng2<<-25
     #crop residues cereals (0)
     sfrc2<<-40
     #crop residue from rice
     sfrr2<<-10 
     #crop residue legumes (5) 
     sfrl2<<-0
     #planted fodder (12)
     sfpf2<<-5 
     # concentrates cereal (maize bran) (20)
     sfconc2<<- 10
     # concentrates oilseed cake (10)
     sfconos2<<- 10  
     
     # manure management in the fattening system in percent (100%)
     #(if ipcc=1, then no need to adjust this )
     sis_lagoon_perc<<- 00
     sis_liquidslurry_perc<<-00
     sis_solidstorage_perc<<-100
     sis_drylot_perc<<-00
     sis_pasture_perc<<-00
     sis_dailyspread_perc<<-00
     sis_digester_perc<<-00
     sis_fuel_perc<<-00
     sis_other_perc<<-00
     
     
     ################################# dairy system non pastoral ############
     
     
     #define liveweigtht in kg for the the breed in dairy system (250)
     lwis<<-250
     
     #define milk yield (kg/cow/year) for the breed in the dairy system (1000)
     myis<<-1000 #http://www.abcburkina.net/fr/nos-dossiers/la-filiere-lait/586-18-performances-laitieres-des-vaches-de-races-locales
     
     #feed basket for dairy wet season
     #natural grass in percent (15)
     ifng1<<-0
     #crop residues cerals (40)
     ifrc1<<-0
     #crop residue from rice
     ifrr1<<-0
     #crop residue legumes (30)
     ifrl1<<-0
     #planted fodder ()
     ifpf1<<-0
     # concentrates cereal (maize bran) (5)
     ifconc1<<- 0
     # concentrates oilseed cake (10)
     ifconos1<<- 0
     
     #feed basket for dairy dry season
     #natural grass in percent (60)
     ifng2<<-0
     #crop residues cerals (0)
     ifrc2<<-0
     #crop residue from rice
     ifrr2<<- 0 
     #crop residue legumes (10)
     ifrl2<<-0
     #planted fodder (10)
     ifpf2<<-0
     # concentrates cereal (maize bran) (20)
     ifconc2<<- 0
     # concentrates oilseed cake (10)
     ifconos2<<- 0
     
     
     # manure management in the semi-intensive system in percent (100%)
     #(if ipcc=1, then no need to adjust this )
     is_lagoon_perc<<- 00
     is_liquidslurry_perc<<-00
     is_solidstorage_perc<<-100
     is_drylot_perc<<-00
     is_pasture_perc<<-00
     is_dailyspread_perc<<-00
     is_digester_perc<<-00
     is_fuel_perc<<-00
     is_other_perc<<-00
     
     ################################# draft animals ############
     
     
     #define liveweigtht in kg for the the breed in dairy system (250)
     lwda<<-220
     
     #define milk yield (kg/cow/year) for the breed in the dairy system (1000)
     myda<<-0 
     
     #feed basket for dairy wet season
     #natural grass in percent (15)
     dafng1<<-0
     #crop residues cerals (40)
     dafrc1<<-0
     #crop residue from rice
     dafrr1<<-0
     #crop residue legumes (30)
     dafrl1<<-0
     #planted fodder ()
     dafpf1<<-0
     # concentrates cereal (maize bran) (5)
     dafconc1<<- 0
     # concentrates oilseed cake (10)
     dafconos1<<- 0
     
     #feed basket for dairy dry season
     #natural grass in percent (60)
     dafng2<<-0
     #crop residues cerals (0)
     dafrc2<<-0
     #crop residue from rice
     dafrr2<<- 0 
     #crop residue legumes (10)
     dafrl2<<-0
     #planted fodder (10)
     dafpf2<<-0
     # concentrates cereal (maize bran) (20)
     dafconc2<<- 0
     # concentrates oilseed cake (10)
     dafconos2<<- 0
     
     
     # manure management in the semi-intensive system in percent (100%)
     #(if ipcc=1, then no need to adjust this )
     da_lagoon_perc<<- 00
     da_liquidslurry_perc<<-00
     da_solidstorage_perc<<-100
     da_drylot_perc<<-00
     da_pasture_perc<<-00
     da_dailyspread_perc<<-00
     da_digester_perc<<-00
     da_fuel_perc<<-00
     da_other_perc<<-00
     
     
     #######################################################################################
     #global variable definition
     #ipcc= 1 the code will use ipcc tier 2 standards for manure storage in stead of the user defined one
     ipcc<<-0 
     
     #########################parmeters specific to the soil pathway##################
     
     
     #linking the manure availability to the production system 
     mprod_e<<- 2 #manure production from a cow in the traditional system per day
     mprod_tl<<- 3 #manure production from a cow from in the troupeau laitier per day
     mprod_f<<- 3 #manure production from a cow in the fattening system per day
     mprod_d<<- 3 #manure production from a cow in the dairy system per day
     mprod_da<<- 3 #manure production from a cow in the dairy system per day
     
     
     #percent of stored manure applied to the different crop
     #cereal (mprod_c *% to this crop for linking with production )
     manc<<-0.4
     # legumes  (mprod_c *% to this crop for linking with production )
     manl<<-0
     #planted fodder  (mprod_c *% to this crop for linking with production )
     manpf<<- 0
     #rice  (mprod_r *% to this crop for linking with production )
     manr<<- 0.4 
     #grazing land  (mprod_r *% to this crop for linking with production )
     mangraz<<-0 
     
     # application of slurry kg/ha
     #cereal ()
     sluc<<-0
     # legumes (0)
     slul<<-0
     #planted fodder ()
     slupf<<-0
     #grazing land
     slugraz<<-0
     #rice land
     slur<<-0
     
     
     slurryconv<<- 0.001 #conversion rate between slurry (NPK) and Nitrogen
     #we need a source here What about compost and other manure. 
     
     #inorganic fertilizer application in kg per hectare
     
     #cereal (50 is recommended)
     fertc<<- 0
     #rice (50 is recommended)
     fertr<<- 0
     # legumes (0)
     fertl<<- 0
     #planted fodder 
     fertpf<<- 0
     #grazing land
     fertgraz<<- 0
     
     Fertconv<<- 0.2 #conversion rate between fertilizer (NPK) and Nitrogen, depends on the locally available ferilizer, +/- 20%
     # from impact lit we know that DAP is most commonly used - Joanne is looking for conversion rates
     
     
     #exogenous yield productivity gain in percentage of yield
     #crop
     pgc<<- 0.0
     #legumes
     pgl<<-0.0
     #planted fodder
     pgpf<<-0.0
     #grassland
     pgg<<- 0.0
     
     # rice 
     pgr<<- 0.0
     
     #############soil management option on cropland (ghg)
     perc_til<<- 0 #percentage of cropland that is tilled 
     perc_redtil <<- 100 #percentage of cropland that is on reduced till
     perc_notil <<- 0 #percentage of cropland that is on no till
     
     perc_inlow <<- 100  #percentage of land with low input 
     perc_inmedium <<- 0  #percentage of land with medium input 
     perc_inhighnoman <<-0  #percentage of land with high input no manure 
     perc_inhighman <<-0   #percentage of land with high input with manure
     
     
     #####reading some r info
     #setwd(path)
     pixel<<-read.csv('1-input/parameter/pixel.csv')
     pixel<<-as.numeric(pixel[2])
     
     ##############################land use driven scenarios
     library(raster)
     
     #do we run a land use change driven scenario? then we need to run the land use change module first 
     # and read here the file indicating the pixels that have changed
     
     #add the path to the changes in land use rasters
     #path to changing cropland i.e. cropland change layer
    
     #library(raster)
     
     #do we run a land use change driven scenario? then we need to run the land use change module first 
     # and read here the file indicating the pixels that have changed
     
     #add the path to the changes in land use rasters
     #path to changing cropland i.e. cropland change layer
     cpath<<-'1-input/spatial/landuse_scenario'
     lucs<<-1
     if (LUC=='LUC1'){
       addcrop<<- raster(paste(cpath,as.character(scenario[37,'LUC1']),sep="/"))
       
     } else {if(LUC=='LUC2'){
       addcrop<<- raster(paste(cpath,as.character(scenario[37,'LUC2']),sep="/"))
     } else {if(LUC=='LUC3'){
       addcrop<<- raster(paste(cpath,as.character(scenario[37,'LUC3']),sep="/"))
     } else{if(LUC=='LUC4') {
       addcrop<<- raster(paste(cpath,as.character(scenario[37,'LUC4']),sep="/"))
     } else {lucs<<-0}
     }}}
     
     
     
     

     
     
 

 
     
     
     source('2-feedbasket_nonlinear2.R')
   
     
     paste("Production parameters updated for this session.")
     
     
     
   })

  
   
output$plot <- renderText(
  
 
    { 
      withProgress(pok(), message="Please wait: Updating production.")
      
      pok()


      })

  pok1<- eventReactive(input$gowt, {

    if(input$gowt==0)
       return()
 setwd(path)

   source('1-water.R')
})

  
 
  output$plot12 <- renderPlot(
    { 
      withProgress(pok1(), message="Please wait: Running Water Impact." )
      
      pok1()
      
    })
  
  

  pok1t<- eventReactive(input$gowt, {

    if(input$gowt==0)
      return()
    grid.table(water_ind2)

    })

  
  output$plotable <- renderPlot(
   { pok1t()


  })
  
  
  
  

  pok1gh<- eventReactive(input$gogh, {

    if(input$gogh==0)
      return()
   setwd(path)
    source('1-ghg3.R')
    })

  output$plot123 <- renderPlot(
    { 
      
      withProgress(pok1gh(), message="Please wait: Running Green House Gas Impact." )
      pok1gh()


    })

  pok1tgh<- eventReactive(input$gogh, {

    if(input$gogh==0)
      return()
    grid.table(Coe_ind2)
  
  })


  
  
  
  
  output$plotableghg <- renderPlot(
    { pok1tgh()


    })

  pok1bdiv<- eventReactive(input$gobdiv, {

    if(input$gobdiv==0)
      return()
   setwd(path)
    source('1-biodiv.r')
    })

  output$plot12bid <- renderPlot(
    { 
      
      withProgress(pok1bdiv(), message="Please wait: Running Biodiversity Impact." )
      
      pok1bdiv()


    },height = 450, width = 800)

  pok1tbiv<- eventReactive(input$gobdiv, {

    if(input$gobdiv==0)
      return()
    grid.table(bio_ind2)
  })

  output$plotablediv <- renderPlot(
    { pok1tbiv()


    })


  
  
  
  psoil<- eventReactive(input$gosol, {

    if(input$gosol==0)
      return()
 setwd(path)
   source('1-soil.R')
    })

  output$plotsoil <- renderPlot(
    { 
      
      withProgress(psoil(), message="Please wait: Running Soil Impact." )
      
      psoil()
      
    },height = 800, width = 800)

  ptsoil<- eventReactive(input$gosol, {

    if(input$gosol==0)
      return()
      
    grid.table(soil_ind2)
   
  })

  output$plotablesoil <- renderPlot(
    { 
      ptsoil()


    })


  ptbaseprod<- eventReactive(input$go, {
    
    if(input$go==0)
      return()
    
    grid.table(prod_ind2)

  })
  
  output$baseplot <- renderPlot(
    { ptbaseprod()
      
      
    })
   
  #session$allowReconnect(TRUE)


}

shinyApp(ui = ui,server)

