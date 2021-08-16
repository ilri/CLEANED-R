####################################################################################################
#
# Shiny App for CLEANED System ILRI  May 2017 by Victor N. Mose and Caroline Mburu
#
# this is version 0.??, which has been used for the workshop
# the code got slight modifications at the level of the production and the ghg emission
# this version still needs the working bar and the right logo, when this is done, this will be 
# version 1 stand alone based on which we will define a version 1.0 online
# Catherine Pfeifer on 22.02.2018 
####################################################################################################
## app.R ##

rm(list=ls())
library(shinydashboard)
library(shiny)
library(raster)
library(maptools)
library(rgdal)
library(gridExtra)
library(grid)

path<<-'D:/Dropbox/CLEANED - IMPACT'
setwd(path)

source('3-cleaned/2-load_data.r')


body <- dashboardBody( 

  
  
  mainPanel(
    
    tabsetPanel(id = "inTabset",
                        tabPanel(title = "Production", value = "panel1", ""),
                        tabPanel(title = "Water impact", value = "panel2",
                                 fluidRow(box(width=12, title = "", 
                                              actionButton("gowt", "Run the water impact"),
                                              
                                              plotOutput("plot12"))),
                                 
                                 fluidRow(box(width=12, title = "Summary table water impact",
                                              
                                            
                                              plotOutput("plotable"))
                                 )
                        ),
                        
                        tabPanel(title = "Greenhouse gas emission", value = "panel3", 
                                 
                                 fluidRow(box(width=12, title = " ",
                                              actionButton("gogh", "Run Greenhouse gas "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plot123"))),
                                 fluidRow(box(width=12, title = "Summary table greenhouse gas",
                                              #actionButton("gowt", " "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotableghg"))
                                 )),
                        tabPanel(title = "Biodiversity impact", value = "panel3", 
                                 
                                 fluidRow(box(width=12, title = " ",
                                              actionButton("gobdiv", "Run biodivesity impact"),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plot12bid"))
                                          
                                 ),
                                 
                                 fluidRow(box(width=12, title = "Summary table biodiversity impact",
                                              #actionButton("gowt", " "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotablediv"))
                                 )),
                        tabPanel(title = "Soil impact", value = "panel3", 
                                 
                                 fluidRow(box(width=12, title = " ",
                                              actionButton("gosol", "Run soil impact",icon = NULL),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotsoil"))
                                          
                                          
                                 ),
                                 
                                 fluidRow(box(width=12, title = "Summary table soil pathway",
                                              #actionButton("gowt", " "),
                                              # numericInput("n", "n", 50),
                                              plotOutput("plotablesoil"))))
  )),
  
  
  
  tabItems(
    tabItem(tabName = "dashboard1",
            #h2("ADVANCED USER INTERFACE"),
            
  tags$head(tags$style(HTML("div.col-sm-6 {padding:1px}"))),

#   fluidRow(
#   box(status = "primary",width = 12, "PRODUCTION CATEGORIES :-----------:-----------:------------:-------------:------:-----:-----------: DATA ALREADY LOADED",background = "navy")
# ),
fluidRow(
  box(#status = "warning", title=" ", width = 12, "", background ="red",
      div(style="height: 35px;", actionButton("go", "Click here to update production")) ,width = 12, background ="red" )),

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
  box(status = "warning", width = 2, "DIARY",background ="maroon"),
  box(status = "warning", width = 2, "MEAT",background ="maroon"),
  box(status = "warning", width = 2, "FOLLOWER",background ="maroon")),
  

fluidRow(
    box(status = "warning", width = 2, "", background ="green",
        # div(style="height: 35px;",textInput("1a", "", value="Number of troupeaux(herd)")),
        # div(style="height: 35px;",textInput("2a", "",value="Number of animals per troup")),
        textInput("3a", "",value="Number of Animals")
            ), 
  box(status = "warning", width = 2, "",background ="green",
      # div(style="height: 35px;",textInput("mp11", "", value="N/A")),
      # div(style="height: 35px;",textInput("mp12", "", value="N/A")),
      numericInput("DAIRY", "", 8104714, min = 0, max = 10000000)),
   
  box(status = "warning", width = 2, " ",background ="green",
      # div(style="height: 35px;",textInput("mpkk", "", value="N/A")),
      # div(style="height: 35px;",textInput("mpkk1q", "", value="N/A")),
      numericInput("MEAT", "", 10806285, min = 0, max = 10000000)),

  box(status = "warning", width = 2, " ",background ="green",
      # div(style="height: 35px;",textInput("mpkk2", "", value="N/A")),
      # div(style="height: 35px;",textInput("mpkk3", "", value="N/A")),
      numericInput("FOLLOWER", "", 10806285, min = 0, max = 10000000))
   
),


fluidRow(
  box(status = "primary",width = 12, " SELECT PRESET SCENARIOS :-----------:-----------:------------:-------------:------:-----:-----------: ",background = "navy"),
 sidebarPanel(
    tabsetPanel(id = "tabset",
                tabPanel("DAIRY",
                         radioButtons("M", "", choices=c('MBR','M1','M2'),selected='MBR')
                        
                ),
                tabPanel("MEAT",
                         radioButtons("Fa", "", choices=c('FBR','F1','F2') ,selected='FBR')
                        
                ),
                
                
                tabPanel("FOLLOWER",
                         radioButtons("Tr", "", choices=c('TBR','T1'),selected='TBR')
                        
                ),
                tabPanel("Crop",
                         radioButtons("Ca", "", choices=c('CBR','C1'),selected='CBR')

                ),
                
                tabPanel("land use change",
                         box(status = "warning", width = 10, "add crop land in percent of baseline of biomass ",background ="aqua",
                             # div(style="height: 35px;",textInput("mpkk", "", value="N/A")),
                             # div(style="height: 35px;",textInput("mpkk1q", "", value="N/A")),
                             numericInput("add", "", 0, min = 0, max = 100))
                         
                )
                
    )
    )
 
  ),
  
fluidRow(
  box(width=12, "Production and area needs",plotOutput("baseplot"))),
fluidRow(
    box(width=12, "New cropped area",plotOutput("baseplot2")))

)



)

)



# We'll save it in a variable `ui` so that we can preview it in the console
ui <- dashboardPage(
  dashboardHeader(title = "SAIRLA PROJECT : CLEANED INTERFACE ",titleWidth=750,
                  
                  tags$li(class = "dropdown",
                          tags$a(href="https://www.ilri.org", target="_blank", 
                                 tags$img(height = "30px", alt="SNAP Logo", src="https://www.ilri.org/sites/default/files/styles/card_image_thumb/public/default_images/defautl_img.jpg")
                          ))),     
  
  
  
  
  
  
  dashboardSidebar(width=250,
                   sidebarMenu(
                     menuItem("SIMPLE USERS", tabName = "dashboard1", icon = icon("dashboard"))
                     #menuItem("ADVANCED USERS!", tabName = "widgets1", icon = icon("th"))
                     # menuItem("Vegetation mapping", tabName = "Veg", icon = icon("th"))
                   )),
  
  
  body
  
  
  
)






# Preview the UI in the console
#source("D:/MOSEVICTOR_PC/MOSE_E/ILRI_SHINY_APP2017/CLEANED_BURKINAFASO2017/CLEANED-Burkina/3-cleaned/Update_user_interface.R", local=TRUE)

server = function(input, output, session) {
 


   pok<- eventReactive(input$go, {

     if(input$go==0)
       return()


     ####################################CLEANED version IMPACT TANZANIA ################################################
     
     # code by Catherine Pfeifer, ILRI, c.pfeifer@cgiar.org
     #code modified1.5.2018
     #clearing all memory 
     rm(list=ls(all=TRUE))
     #set path to cleaned tool
     
     
     #path<<-'D:/MOSEVICTOR_PC/MOSE_E/ILRI_SHINY_APP2017/BURKINA_FASO_CLEANED_7.11.2017/Cleaned - Burkina'
     #path<<-'D:/MOSEVICTOR_PC/MOSE_E/ILRI_SHINY_APP2017/UPDATED2017NOV/CLEANED-Burkina6.11.2017/Cleaned - Burkina'
     setwd(path)
     
     ###################################This sheet defines all user defined variables#################
     #defining the number of animal in each system 
     
     # in the dairy animals (27015712 total 2016 FAOSTAT)
     numcow_d <<-  27015712*0.3
     
     #  meat (37193)
     numcow_f<<- 27015712 *0.4
     
     # followers (40885)
     numcow_da <<- 27015712*0.4
     
     # presets 
     preset <<-1 #if 1 the interface uses the presets if 0 or other it uses the manual input below. 
     scenario<<-read.csv('1-input/parameter/preset.csv',  skip=2)
     
     # select from the preset scenario
     
     M<<- 'MBR'  #options are (MBR, M1, M2)
     Fa<<- 'FBR'  #options are (FBR, F1, F2)
     Tr<<- 'TBR'  #options are (TBR, T1)
     
     
     Ca<<- 'CBR' #options are (CBR, C1)
     LUC<<- 'LUC1'  #options are (LUC0, LUC1,LUC2,LUC3,LUC4)
     
     #give your scanario a name 
     name<<-"my own"
     
     #DEFINE THE DIFFERENT SYSTEM 
     #################################
     
     ####################################### meat category ###################
     
     
     
     #define liveweigtht in kg for the the breed in the semi intensive system (250)
     lwsis<<-125 
     #define milk yield (kg/cow/year) for the breed in the semi intensive system (0)
     mysis<<-0
     
     #dressing percentage http://www.dpi.nsw.gov.au/__data/assets/pdf_file/0006/103992/dressing-percentages-for-cattle.pdf
     dsis<<-0.64
     
     #feed basket  for fattening  system season wet
     
     #natural grass in percent (15)
     sfng1<<-42.367298
     #crop residues cereals (40)
     sfrc1<<-17.193793
     #crop residue from rice
     sfrr1<<-0
     #crop residue legumes (30)
     sfrl1<<-0
     #planted fodder ()
     sfpf1<<-0 
     # concentrates cereal (maize bran) (5)
     sfconc1<<-0
     # concentrates oilseed cake (10)
     sfconos1<<-40.438905  
     
     # manure management in the fattening system in percent (100%)
     #(if ipcc=1, then no need to adjust this )
     sis_lagoon_perc<<-00
     sis_liquidslurry_perc<<-00
     sis_solidstorage_perc<<-100
     sis_drylot_perc<<-00
     sis_pasture_perc<<-00
     sis_dailyspread_perc<<-00
     sis_digester_perc<<-00
     sis_fuel_perc<<-00
     sis_other_perc<<-00
     
     
     ################################# dairy category ############
     
     
     #define liveweigtht in kg for the the breed in dairy system (250)
     lwis=125
     
     #define milk yield (kg/cow/year) for the breed in the dairy system (141)
     myis=141 
     
     #dressing percentage for the milking cow meat per cow 
     dis = 0.85
     
     
     
     #feed basket for dairy wet season
     #natural grass in percent (15)
     ifng1<<-47.223208
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
     ifconos1<<- 52.776792
     
     
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
     
     ################################# followers  ############
     
     
     #define liveweigtht in kg for the the breed in dairy system (250)
     lwda<<-125
     
     #define milk yield (kg/cow/year) for the breed in the dairy system (1000)
     myda<<-0 
     
     #feed basket for dairy wet season
     #natural grass in percent (15)
     dafng1<<-42.60399
     #crop residues cerals (40)
     dafrc1<<-17.284697
     #crop residue from rice
     dafrr1<<-0
     #crop residue legumes (30)
     dafrl1<<-0
     #planted fodder ()
     dafpf1<<-0
     # concentrates cereal (maize bran) (5)
     dafconc1<<- 0
     # concentrates oilseed cake (10)
     dafconos1<<- 40.111305
     
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
     ipcc<<- 1 
     
     #########################parmeters specific to the soil pathway##################
     
     
     #linking the manure availability to the production system 
     
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
     pgc<<-0.0
     #legumes
     pgl<<-0.0
     #planted fodder
     pgpf<<-0.0
     #grassland
     pgg<<- 0.0
     
     
     #############soil management option on cropland (ghg)
     perc_til<<- 0 #percentage of cropland that is tilled 
     perc_redtil <<- 100 #percentage of cropland that is on reduced till
     perc_notil<<-0 #percentage of cropland that is on no till
     
     perc_inlow<<-100  #percentage of land with low input 
     perc_inmedium<<-0  #percentage of land with medium input 
     perc_inhighnoman <<-0  #percentage of land with high input no manure 
     perc_inhighman <<-0   #percentage of land with high input with manure
     
     
     #####reading some r info
     setwd(path)
     pixel<<-read.csv('1-input/parameter/pixel.csv')
     pixel<<-as.numeric(pixel[2])
     
     ##############################land use driven scenarios
     library(raster)
     
     #do we run a land use change driven scenario? then we need to run the land use change module first 
     # and read here the file indicating the pixels that have changed
     
     #add the path to the changes in land use rasters
     #path to changing cropland i.e. cropland change layer
     
     add<<-0 # in percent, will be devided by 100 in the luc code
     
     
     setwd(path)
     #now overwrite variables with preset
    
     if(preset==1){
         # get the parameter of the  dairy system
         temp<-scenario[ , c('Mvar',M)]
         names(temp)[2]<-'ppara'
         for(i in  which(! temp$Dvar== ''))
         {
             assign(as.character(temp$Dvar[i]), temp$ppara[i])
         }}
     
     if(preset==1){
         # get the parameter of the meat system
         temp<-scenario[ , c('Fvar',Fa)]
         names(temp)[2]<-'ppara'
         for(i in  which(! temp$Fvar== ''))
         {
             assign(as.character(temp$Fvar[i]), temp$ppara[i])
         }}
     
     if(preset==1){
         # get the parameter of the fattening  system
         temp<-scenario[ , c('Tvar',Tr)]
         names(temp)[2]<-'ppara'
         for(i in  which(! temp$Tvar== ''))
         {
             assign(as.character(temp$Tvar[i]), temp$ppara[i])
         }}
     if(preset==1){
         # get the parameter of the crop 
         temp<-scenario[ , c('Cvar',Ca)]
         names(temp)[2]<-'ppara'
         for(i in  which(! temp$Cvar== ''))
         {
             assign(as.character(temp$Cvar[i]), temp$ppara[i])
         }}
     
     # end of else loop
     setwd(path)
     
     # end of else loop
     setwd(path)
     
     #source('3-cleaned/2-load_data.r')
     setwd(path)
     
     source('3-cleaned/2-feedbasket_nonlinear_impact.r')
     
     paste("Feed basket parameters updated for this session.")
   })


output$plot <- renderText(
    { pok()


      })

  pok1<- eventReactive(input$gowt, {

    if(input$gowt==0)
      return()
setwd(path)
    source('3-cleaned/1-water.r')})

  output$plot12 <- renderPlot(
    { pok1()


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
    source('3-cleaned/1-ghg.r')
    })

  output$plot123 <- renderPlot(
    { pok1gh()


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
    source('3-cleaned/1-biodiv.r')
    })

  output$plot12bid <- renderPlot(
    { pok1bdiv()


    })

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
   source('3-cleaned/1-soil.r')
    })

  output$plotsoil <- renderPlot(
    { psoil()


    })

  ptsoil<- eventReactive(input$gosol, {

    if(input$gosol==0)
      return()
      
    grid.table(soil_ind2)
   
  })

  output$plotablesoil <- renderPlot(
    { ptsoil()


    })


  ptbaseprod<- eventReactive(input$go, {
    
    if(input$go==0)
      return()
    
    grid.table(prod_ind2)

  })
  
  output$baseplot <- renderPlot(
    { ptbaseprod()
        
    })
  
  ptbaseprod2<- eventReactive(input$go, {
      
      if(input$go==0)
          return()
      setwd(path)
      source('3-cleaned/2-feedbasket_nonlinear_impact.r')
        }) 
     
 
  output$baseplot2 <- renderPlot(
      { ptbaseprod2()
          
      })

}

shinyApp(ui = ui,server)

