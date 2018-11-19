####################################CLEANED version 2 for Burkina Faso ################################################
# cleaned version 2
# code by Catherine Pfeifer, ILRI, c.pfeifer@cgiar.org
#code created on 20.6.2016
#clearing all memory 
rm(list=ls(all=TRUE))
#set path to cleaned tool


path<-'D:/Dropbox/BURKINA_FASO_CLEANED_22.02.2018/CLEANED - Burkina'
#path<-'D:/MOSEVICTOR_PC/MOSE_E/ILRI_SHINY_APP2017/UPDATED2017NOV/CLEANED-Burkina6.11.2017/Cleaned - Burkina'
setwd(path)

source('3-cleaned/2-load_data.r')
###################################This sheet defines all user defined variables#################
#defining the number of animal in each system 

# in the extensive agro-pastoral system (both transhumant and dairy animal)
#nombre de troupeau qui font la longue transhumance (70 in Bama)
tt<-100
#nombre de troupeau laitier (150 in Bama)
tl<-200
#nombre de troupeau qui ne font que la petite transhumance (180 in Bama)
tpt<-238
#nombre moyen ou modal de tete dans un troupeau pour la petite ou la grande transhumance
att<-100
atpt<-100
# nombre moyen ou modal de tete d'un troupeau laitier
atl<-25


# in the dairy only system (1400)
numcow_d <-  1400


# in the fattening system (55000)
numcow_f<- 55000 

# in draft system (22500) 
numcow_da <- 22500

#number of crossing animals 
numcow_c<- 200000

# presets 
preset <-1 #if 1 the interface uses the presets if 0 or other it uses the manual input below. 
scenario<-read.csv('1-input/parameter/preset.csv',  skip=2)

# select from the preset scenario

Ap<- 'A1'  #options are (ABR, A1)
L<- 'L1'  #options are (LBR, L1, L2)
M<- 'M1'  #options are (MBR, M1, M2)
Fa<- 'F1'  #options are (FBR, F1, F2)
Tr<- 'T1'  #options are (TBR, T1)


Ca<- 'C1' #options are (CBR, C1)
LUC<- 'LUC1'  #options are (LUC0, LUC1,LUC2,LUC3,LUC4)

#give your scanario a name 
name<-"baserun"
#############################manual defintion of the parameters#####################


#seasonality 
#transhumance seasonality 
st1<- 6 # season when transhumant animals are paturage in Bama and small transhumance in the study area (juillet-novembre)
st2<- 12-st1 # season when transhumant animals are gone (decembre - june) 
#crop seasonality 
ds<- 7 #dry season (October- April)
ws<- 12-ds  # wet season (May-September )

ws_st1<-3 # number of month the transhumant troupeau is in area during the wet season
ds_st1<-3 # number of month the transhumant troupeau is in area during the dry season


#DEFINE THE DIFFERENT SYSTEM 
#################################

# the extensive agro pastoral system
# definition de l'animal extensif transhumant
#define liveweigtht in kg for the the breed in the transhumant system (200)
lwes=200 
# definition de l'animal extensif laitier
#define liveweigtht in kg for the the breed in the transhumant system (200)
lwles=220 
#define milk yield (kg/cow/year) for the breed in the extensive system (400) 
myles=600 # http://www.abcburkina.net/fr/nos-dossiers/la-filiere-lait/586-18-performances-laitieres-des-vaches-de-races-locales
#dressing percentage http://www.dpi.nsw.gov.au/__data/assets/pdf_file/0006/103992/dressing-percentages-for-cattle.pdf
des = 0.38

#feed basket for transhumant troupeau in the extensive systems
# season wet season 
#natural grass in percent (95)
efng1<- 0  
#crop residues cerals (0)
efrc1<- 0
#crop residue from rice
efrr1<-100  
#crop residue legumes (10) 
efrl1<-0
#planted fodder (0)
efpf1<-0  
# concentrates cereal (maize bran) (0)
efconc1<- 0
# concentrates oilseed cake (0)
efconos1<- 0
#check if a 100%

#season dry season  
#natural grass in percent (100)
efng2<- 0  
#crop residues cerals (0)
efrc2<- 0 
#crop residue from rice
efrr2<-0 
#crop residue legumes (0) 
efrl2<-0
#planted fodder (0)
efpf2<-0  #
# concentrates cereal (maize bran) (0)
efconc2<- 0
# concentrates oilseed cake (0)
efconos2<- 0
#check if a 100%

#feed basket for milking troupeau in the extensive systems
# season wet
#natural grass in percent (95)
lefng1<- 0  
#crop residues cerals (0)
lefrc1<- 0
#crop residue from rice
lefrr1<-0
#crop residue legumes (10) 
lefrl1<-0
#planted fodder (0)
lefpf1<-0  #Feed scenario 20 
# concentrates cereal (maize bran) (0)
lefconc1<- 0
# concentrates oilseed cake (0)
lefconos1<- 0
#check if a 100%

#season dry 
#natural grass in percent (100)
lefng2<- 0  
#crop residues cerals (0)
lefrc2<- 0  
#crop residue from rice
lefrr2<-0
#crop residue legumes (0) 
lefrl2<-0
#planted fodder (0)
lefpf2<-0  #Feed scenario 20 
# concentrates cereal (maize bran) (0)
lefconc2<- 0
# concentrates oilseed cake (0)
lefconos2<- 0
#check if a 100%


# manure management in the extensive system  system in percent (100%)
#(if ipcc=1, then no need to adjust this )
es_lagoon_perc<- 00
es_liquidslurry_perc<-00
es_solidstorage_perc<-00
es_drylot_perc<-00
es_pasture_perc<-100
es_dailyspread_perc<-00
es_digester_perc<-00
es_fuel_perc<-00
es_other_perc<-00
#do by season 


#manure management for the troupeau laitier
les_lagoon_perc<- 00
les_liquidslurry_perc<-00
les_solidstorage_perc<-20
les_drylot_perc<-00
les_pasture_perc<-80
les_dailyspread_perc<-00
les_digester_perc<-00
les_fuel_perc<-00
les_other_perc<-00
#do by season 



####################################### the fattening system###################



#define liveweigtht in kg for the the breed in the semi intensive system (250)
lwsis=250 
#define milk yield (kg/cow/year) for the breed in the semi intensive system (0)
mysis=0

#dressing percentage http://www.dpi.nsw.gov.au/__data/assets/pdf_file/0006/103992/dressing-percentages-for-cattle.pdf
dsis = 0.48

#feed basket  for fattening  system season wet

#natural grass in percent (15)
sfng1<-0
#crop residues cereals (40)
sfrc1<-0
#crop residue from rice
sfrr1<- 0
#crop residue legumes (30)
sfrl1<-0
#planted fodder ()
sfpf1<-0 
# concentrates cereal (maize bran) (5)
sfconc1<- 0
# concentrates oilseed cake (10)
sfconos1<- 0  

# dry season 
#natural grass in percent (50)
sfng2<-0
#crop residues cereals (0)
sfrc2<-0
#crop residue from rice
sfrr2<-0 
#crop residue legumes (5) 
sfrl2<-0
#planted fodder (12)
sfpf2<-0 
# concentrates cereal (maize bran) (20)
sfconc2<- 0
# concentrates oilseed cake (10)
sfconos2<- 0  

# manure management in the fattening system in percent (100%)
#(if ipcc=1, then no need to adjust this )
sis_lagoon_perc<- 00
sis_liquidslurry_perc<-00
sis_solidstorage_perc<-100
sis_drylot_perc<-00
sis_pasture_perc<-00
sis_dailyspread_perc<-00
sis_digester_perc<-00
sis_fuel_perc<-00
sis_other_perc<-00


################################# dairy system non pastoral ############


#define liveweigtht in kg for the the breed in dairy system (250)
lwis=250

#define milk yield (kg/cow/year) for the breed in the dairy system (1000)
myis=1000 #http://www.abcburkina.net/fr/nos-dossiers/la-filiere-lait/586-18-performances-laitieres-des-vaches-de-races-locales

#feed basket for dairy wet season
#natural grass in percent (15)
ifng1<-0
#crop residues cerals (40)
ifrc1<-0
#crop residue from rice
ifrr1<-0
#crop residue legumes (30)
ifrl1<-0
#planted fodder ()
ifpf1<-0
# concentrates cereal (maize bran) (5)
ifconc1<- 0
# concentrates oilseed cake (10)
ifconos1<- 0

#feed basket for dairy dry season
#natural grass in percent (60)
ifng2<-0
#crop residues cerals (0)
ifrc2<-0
#crop residue from rice
ifrr2<- 0 
#crop residue legumes (10)
ifrl2<-0
#planted fodder (10)
ifpf2<-0
# concentrates cereal (maize bran) (20)
ifconc2<- 0
# concentrates oilseed cake (10)
ifconos2<- 0


# manure management in the semi-intensive system in percent (100%)
#(if ipcc=1, then no need to adjust this )
is_lagoon_perc<- 00
is_liquidslurry_perc<-00
is_solidstorage_perc<-100
is_drylot_perc<-00
is_pasture_perc<-00
is_dailyspread_perc<-00
is_digester_perc<-00
is_fuel_perc<-00
is_other_perc<-00

################################# draft animals ############


#define liveweigtht in kg for the the breed in dairy system (250)
lwda=220

#define milk yield (kg/cow/year) for the breed in the dairy system (1000)
myda=0 

#feed basket for dairy wet season
#natural grass in percent (15)
dafng1<-0
#crop residues cerals (40)
dafrc1<-0
#crop residue from rice
dafrr1<-0
#crop residue legumes (30)
dafrl1<-0
#planted fodder ()
dafpf1<-0
# concentrates cereal (maize bran) (5)
dafconc1<- 0
# concentrates oilseed cake (10)
dafconos1<- 0

#feed basket for dairy dry season
#natural grass in percent (60)
dafng2<-0
#crop residues cerals (0)
dafrc2<-0
#crop residue from rice
dafrr2<- 0 
#crop residue legumes (10)
dafrl2<-0
#planted fodder (10)
dafpf2<-0
# concentrates cereal (maize bran) (20)
dafconc2<- 0
# concentrates oilseed cake (10)
dafconos2<- 0


# manure management in the semi-intensive system in percent (100%)
#(if ipcc=1, then no need to adjust this )
da_lagoon_perc<- 00
da_liquidslurry_perc<-00
da_solidstorage_perc<-100
da_drylot_perc<-00
da_pasture_perc<-00
da_dailyspread_perc<-00
da_digester_perc<-00
da_fuel_perc<-00
da_other_perc<-00


#######################################################################################
#global variable definition
#ipcc= 1 the code will use ipcc tier 2 standards for manure storage in stead of the user defined one
ipcc=0 

#########################parmeters specific to the soil pathway##################


#linking the manure availability to the production system 
mprod_e<- 2 #manure production from a cow in the traditional system per day
mprod_tl<- 3 #manure production from a cow from in the troupeau laitier per day
mprod_f<- 3 #manure production from a cow in the fattening system per day
mprod_d<- 3 #manure production from a cow in the dairy system per day
mprod_da<- 3 #manure production from a cow in the dairy system per day


#percent of stored manure applied to the different crop
#cereal (mprod_c *% to this crop for linking with production )
manc<-0.4
# legumes  (mprod_c *% to this crop for linking with production )
manl<-0
#planted fodder  (mprod_c *% to this crop for linking with production )
manpf<- 0
#rice  (mprod_r *% to this crop for linking with production )
manr<- 0.4 
#grazing land  (mprod_r *% to this crop for linking with production )
mangraz<-0 

# application of slurry kg/ha
#cereal ()
sluc<-0
# legumes (0)
slul<-0
#planted fodder ()
slupf<-0
#grazing land
slugraz<-0
#rice land
slur<-0


slurryconv<- 0.001 #conversion rate between slurry (NPK) and Nitrogen
#we need a source here What about compost and other manure. 

#inorganic fertilizer application in kg per hectare

#cereal (50 is recommended)
fertc<- 0
#rice (50 is recommended)
fertr<- 0
# legumes (0)
fertl<- 0
#planted fodder 
fertpf<- 0
#grazing land
fertgraz<- 0

Fertconv<- 0.2 #conversion rate between fertilizer (NPK) and Nitrogen, depends on the locally available ferilizer, +/- 20%
# from impact lit we know that DAP is most commonly used - Joanne is looking for conversion rates


#exogenous yield productivity gain in percentage of yield
#crop
pgc= 0.0
#legumes
pgl=0.0
#planted fodder
pgpf=0.0
#grassland
pgg= 0.0

# rice 
pgr= 0.0

#############soil management option on cropland (ghg)
perc_til= 0 #percentage of cropland that is tilled 
perc_redtil = 100 #percentage of cropland that is on reduced till
perc_notil = 0 #percentage of cropland that is on no till

perc_inlow = 100  #percentage of land with low input 
perc_inmedium = 0  #percentage of land with medium input 
perc_inhighnoman =0  #percentage of land with high input no manure 
perc_inhighman =0   #percentage of land with high input with manure


#####reading some r info
setwd(path)
pixel<-read.csv('1-input/parameter/pixel.csv')
pixel<-as.numeric(pixel[2])

##############################land use driven scenarios
library(raster)

#do we run a land use change driven scenario? then we need to run the land use change module first 
# and read here the file indicating the pixels that have changed

#add the path to the changes in land use rasters
#path to changing cropland i.e. cropland change layer
cpath<-'1-input/spatial/landuse_scenario'
lucs<-1
if (LUC=='LUC1'){
  addcrop<- raster(paste(cpath,as.character(scenario[37,'LUC1']),sep="/"))

} else {if(LUC=='LUC2'){
  addcrop<- raster(paste(cpath,as.character(scenario[37,'LUC2']),sep="/"))
} else {if(LUC=='LUC3'){
  addcrop<- raster(paste(cpath,as.character(scenario[37,'LUC3']),sep="/"))
} else{if(LUC=='LUC4') {
  addcrop<- raster(paste(cpath,as.character(scenario[37,'LUC4']),sep="/"))
} else {lucs<-0}
}}}


setwd(path)
#now overwrite variables with preset
if(preset==1){
  # get the parameter of the pastoral extensive system
  temp<-scenario[ ,c('Avar', Ap)]
  names(temp)[2]<-'ppara'
  for(i in  which(! temp$Avar== ''))
  {
    assign(as.character(temp$Avar[i]), temp$ppara[i])
  }}

if(preset==1){  
  # get the parameter of the pastoral dairy system
  temp<-scenario[ , c('Lvar',L)]
  names(temp)[2]<-'ppara'
  for(i in  which(! temp$Lvar== ''))
  {
    assign(as.character(temp$Lvar[i]), temp$ppara[i])
  }}

if(preset==1){
  # get the parameter of the  dairy system
  temp<-scenario[ , c('Mvar',M)]
  names(temp)[2]<-'ppara'
  for(i in  which(! temp$Dvar== ''))
  {
    assign(as.character(temp$Dvar[i]), temp$ppara[i])
  }}

if(preset==1){
  # get the parameter of the fattening system
  temp<-scenario[ , c('Fvar',Fa)]
  names(temp)[2]<-'ppara'
  for(i in  which(! temp$Fvar== ''))
  {
    assign(as.character(temp$Fvar[i]), temp$ppara[i])
  }}

if(preset==1){
  # get the parameter of the draft system
  temp<-scenario[ , c('Tvar',Tr)]
  names(temp)[2]<-'ppara'
  for(i in  which(! temp$Tvar== ''))
  {
    assign(as.character(temp$Tvar[i]), temp$ppara[i])
  }}
if(preset==1){
  # get the parameter of the draft system
  temp<-scenario[ , c('Cvar',Ca)]
  names(temp)[2]<-'ppara'
  for(i in  which(! temp$Cvar== ''))
  {
    assign(as.character(temp$Cvar[i]), temp$ppara[i])
  }}

# end of else loop

setwd(path)

source('3-cleaned/2-feedbasket_nonlinear2.r')



# #########################################run CLEANED##################################
# 
#run the water pathway 
setwd(path)
source('3-cleaned/1-water.r')
#run the greenhouse gas pathway
setwd(path)  
source('3-cleaned/1-ghg3.r')
#run the biodiversity pathway
setwd(path)
source('3-cleaned/1-biodiv.r')

setwd(path)
source('3-cleaned/1-soil.r')

# #ouput maps can be found in the 4- ouput map folder 

