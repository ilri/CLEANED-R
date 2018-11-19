######################################CLEANED Tanzania SAIRLA################################################

# cleaned version 2
# code by Catherine Pfeifer, ILRI, c.pfeifer@cgiar.org
#code created on 20.6.2016
# last modified 22.1.2018
#clearing all memory 
rm(list=ls(all=TRUE))
#set path to cleaned tool
path<-'D:/Dropbox/Cleaned Ethiopia'

setwd(path)
###################################This sheet defines all user defined variables#################

source('2-load_data.r')
setwd(path)

# enter the number of animals per system 
#the dual purpose dairy cow 
numcow_es<-22000 # see parameterization excel file 
# the dual puropse fattening and rearing 
numcow_sis <- 19000
# dual system : draft animals 
numcow_da <- 10000

# the specialized dairy with improved breeds 
numcow_is <-500
  
# sheep 
numsheep <- 100000


preset <-1 #if 1 the interface uses the presets if 0 or other it uses the manual input below. 
scenario<-read.csv('1-input/parameter/preset.csv',  skip=2)

# select from the preset scenario

DD<- 'DD0'  #options are (DD0, DD1,DD2)
DF<- 'DF0'  #options are (DF0, DF1, DF2)
DA<- 'DA0'  #options are (DA0, DA1, DA2)
SD <- 'SD0'  #options are (SD0, SD1, SD2)
SH<- "SH0" # options are (SH0, SH1 and SH2)

Cr<- 'Cr0' #options are (Cr0,Cr1)

#give your scanario a name 
name<-"mybaserun"

#############################manual defintion of the parameters#####################


#seasonality 
# climate seasonality # based on usaid livelihood zones 
ds<- 8 # dry season
ws<- 12-ds # wet season  

#DEFINE THE DIFFERENT SYSTEM 
#################################

# the dual system dairy
#define liveweigtht in kg for the the breed in the extensive system (200)
lwes=200 
#define milk yield (kg/cow/year) for the breed in the extensive system (400) #500 for health
myes=1100 # 5 litre a day for 220 days 

des<-0

#dry season 
#natural grass in percent (51)
efng1<- 0
#crop residues cerals (49)
efrc1<- 0
#crop residue legumes (0) 
efrl1<-0
#planted fodder (0)
efpf1<-0
# concentrates cereal (maize bran) (0)
efconc1<- 0
# concentrates oilseed cake (0)
efconos1<- 0
#hey()
efhay1<-0
# silage made from grass
efsil1<-0

#wet season  
#natural grass in percent (98)
efng2<- 0  
#crop residues cerals (2)
efrc2<- 0 
#crop residue legumes (0) 
efrl2<-0
#planted fodder (0)
efpf2<-0  #
# concentrates cereal (maize bran) (0)
efconc2<- 0
# concentrates oilseed cake (0)
efconos2<- 0
#hey()
efhay2<-0
# silage made from grass
efsil2<-0
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

# dual system meat 

#define liveweigtht in kg for the the breed in the dual purpose system  (200)
lwsis=200  
#define milk yield (kg/cow/year) for the breed in the semi intensive system (2000) 
mysis=0

#feed basket  for dual systeme meed
#dressing percentage 
dsis = 0.7

#feed basket  semi-intensive  system season dry
#natural grass in percent (33)
sfng1<-0
#crop residues cereals (35)
sfrc1<-0
#crop residue from rice
sfrr1<- 0
#crop residue legumes (12)
sfrl1<-0
#planted fodder (10)
sfpf1<-0
# concentrates cereal (maize bran) (5)
sfconc1<- 0
# concentrates oilseed cake (5)
sfconos1<- 0
#hey()
sfhay1<-0
# silage made from grass
sfsil1<-0



# wet season 
#natural grass in percent (57)
sfng2<-0
#crop residues cereals (10)
sfrc2<-0
#crop residue from rice (0)
sfrr2<-0
#crop residue legumes (5) 
sfrl2<-0
#planted fodder (14)
sfpf2<-0
# concentrates cereal (maize bran) (5)
sfconc2<- 0
# concentrates oilseed cake (9)
sfconos2<- 0
#hey()
sfhay2<-0
# silage made from grass
sfsil2<-0

# manure management in the semi-intensive system in percent (100%)
#(if ipcc=1, then no need to adjust this )
sis_lagoon_perc<- 00
sis_liquidslurry_perc<-00
sis_solidstorage_perc<-00
sis_drylot_perc<-00
sis_pasture_perc<-00
sis_dailyspread_perc<-80
sis_digester_perc<-00
sis_fuel_perc<-00
sis_other_perc<-20



## draft system 

#define liveweigtht in kg for the the breed as draft animals (220)
lwda=220

#define milk yield (kg/cow/year) fro the draft animal (1000)
myda=0 
# dressing percenatge
dda<- 0.5 

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
#hey()
dafhay1<-0
# silage made from grass
dafsil1<-0




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
#hey()
dafhay2<-0
# silage made 
dafsil2<-0

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



################################################### specialized dairy system 
#define liveweigtht in kg for the the breed in the intensive system (300)
lwis=250

#define milk yield (kg/cow/year) for the breed in the intensive system (7500)
myis=2200

#feed basket for intensive system
#dry season
#natural grass in percent (20)
ifng1<-0
#crop residues cerals (30)
ifrc1<-0
#crop residue from rice (0)
ifrr1<-0
#crop residue legumes (10)
ifrl1<-0
#planted fodder (30)
ifpf1<-0
# concentrates cereal (maize bran) (10)
ifconc1<- 0
# concentrates oilseed cake (10)
ifconos1<- 0
#hey()
ifhay1<-0
# silage made from grass
ifsil1<-0



#feed basket for dairy wet season
#natural grass in percent (30)
ifng2<-0
#crop residues cerals (10)
ifrc2<-0
#crop residue from rice (0)
ifrr2<-  0
#crop residue legumes (5)
ifrl2<-0
#planted fodder (35)
ifpf2<-0
# concentrates cereal (maize bran) (10)
ifconc2<- 0
# concentrates oilseed cake (10)
ifconos2<- 0
#hey()
ifhay2<-0
# silage made from grass
ifsil2<-0

# manure management in the semi-intensive system in percent (100%)
#(if ipcc=1, then no need to adjust this )
is_lagoon_perc<- 00
is_liquidslurry_perc<-00
is_solidstorage_perc<-00
is_drylot_perc<-00
is_pasture_perc<-00
is_dailyspread_perc<-90
is_digester_perc<-5
is_fuel_perc<-00
is_other_perc<-5


####### sheep 
#define liveweigtht in kg for the the breed as draft animals (20)
lwsh=20

#define dressing persentage
dsh = 0.7

#feed basket for dairy wet season
#natural grass in percent (15)
shfng1<-0
#crop residues cerals (40)
shfrc1<-0
#crop residue from rice
shfrr1<-0
#crop residue legumes (30)
shfrl1<-0
#planted fodder ()
shfpf1<-0
# concentrates cereal (maize bran) (5)
shfconc1<- 0
# concentrates oilseed cake (10)
shfconos1<- 0
#hey()
shhay1<-0
# silage made from grass
shsil2<-0


#feed basket for sheep dry season
#natural grass in percent (60)
shfng2<-0
#crop residues cerals (0)
shfrc2<-0
#crop residue from rice
shfrr2<- 0 
#crop residue legumes (10)
shfrl2<-0
#planted fodder (10)
shfpf2<-0
# concentrates cereal (maize bran) (20)
shfconc2<- 0
# concentrates oilseed cake (10)
shfconos2<- 0
#hey()
shhay2<-0
# silage made 
shsil2<-0

sh_pasture_perc<-50



#######################################################################################
#global variable definition

#ipcc= 1 the code will use ipcc tier 2 standards for manure storage in stead of the user defined one
ipcc=0


#exogenous yield productivity gain in percentage of yield
#crop
pgc= 0.0
#legumes
pgl=0.0
#planted fodder
pgpf=0.0
#grassland
pgg= 0.0



#linking the manure availability to the production system 
mprod_es<- 2 #manure production from a cow in the dual system - rearing/fattening and draf per day
mprod_da<- 2 #manure production from a cow in the dual system - rearing/fattening and draf per day
mprod_sis<- 3 #manure production from a cow from in the dual system lactating animals per day
mprod_is<- 4  #manure production from a cow in the specialized dairy per day
mprod_sh<- 0.1

#percent of stored manure applied to the different crop
#cereal (mprod_c *% to this crop for linking with production )
manc<-0.8
# legumes  (mprod_c *% to this crop for linking with production )
manl<-0
#planted fodder  (mprod_c *% to this crop for linking with production )
manpf<- 0
#rice  (mprod_r *% to this crop for linking with production )
manr<- 0 
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
pixel<-pixel[2]

##############################land use driven scenarios


start<- Sys.time()

source('2-feedbasket_nonlinear2.r')


#########################################run CLEANED##################################


#run the water pathway 
setwd(path)
source('1-water.r')
#run the greenhouse gas pathway
setwd(path)  
source('1-ghg.r')
#run the biodiversity pathway
# setwd(path)
# source('3-cleaned/1-biodiv.r')
# run the soil pathway
setwd(path)
source('1-soil.r')


#ouput maps can be found in the 4- ouput map folder 
end<-Sys.time()

end-start