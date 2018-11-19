library(gridExtra)
setwd(path)


if(preset==1){
    # get the parameter of the pastoral extensive system
    temp<-scenario[ , c('Avar', Ap)]
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
    for(i in  which(! temp$Mvar== ''))
    {
        assign(as.character(temp$Mvar[i]), temp$ppara[i])
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


#read parameter
para<-read.csv('1-input/parameter/para.csv')
para$value<-as.numeric(para$value)
dim<-dim(para)
obs<-dim [1]
for(i in seq_along(para$name))
{assign(as.character(para$name[i]), para$value[i])}
prod_base<-read.csv('1-input/base_run/prod_ind.csv', row.names = NULL)
#prod_base<-prod_base[,2:18]

cropland<-raster('1-input/spatial/lu/cropland.tif')
grazland<-raster('1-input/spatial/lu/grazland.tif')
riceland<-raster('1-input/spatial/lu/riz.tif')

ccrop<-raster('1-input/spatial/lu/ccrop.tif')
icrop<-raster('1-input/spatial/lu/icrop.tif')
cropland<-raster('1-input/spatial/lu/cropland.tif')
grazland<-raster('1-input/spatial/lu/grazland.tif')
cforet<-raster('1-input/spatial/lu/cforet.tif')
gforet<-raster('1-input/spatial/lu/gforet.tif')
pforet<-raster('1-input/spatial/lu/pforet.tif')
asava<-raster('1-input/spatial/lu/asava.tif')
arsava<-raster('1-input/spatial/lu/arsava.tif')
hsava<-raster('1-input/spatial/lu/hsava.tif')
astep<-raster('1-input/spatial/lu/astep.tif')
arstep<-raster('1-input/spatial/lu/arstep.tif')
hstep<-raster('1-input/spatial/lu/hstep.tif')
autre<-raster('1-input/spatial/lu/autre.tif')
eau<-raster('1-input/spatial/lu/eau.tif')



if (lucs==1) {
  source('3-cleaned/2-luccomp.r')
}


###################computation of the number of animals in the landscape##########
#numbers of cow in the area
#815000 Huet based on Robinson et al livestock distribution i.e. FAO stat 2010
numcow_tl<-tl*atl
numcow_tpt<- tpt*atpt
numcow_tt<- tt*att

numcow<-numcow_tpt+numcow_tl+numcow_tt*st1/12+numcow_d+numcow_f+numcow_da

############################these are the computation for cattle############################
# for any other animal, this has to be adjusted based on IPCC guidlines 


#total energy requirement per average cow per year per system

#maintenance energy eq 10.3, and table 10.4

er_mes<-0.322 *lwes^0.75
er_mles <-0.386 *lwles^0.75
er_msis<-0.370*lwsis^0.75
er_mis<-0.386*lwis^0.75
er_mda<-0.370*lwsis^0.75
#activity energy equ 10.4 table 10.5

er_ames<-0.36*er_mes # large gazing area
er_amles<-0.15*er_mles # assumtion these animal still graze a bit  so the value is between 0 and 0.17
er_amsis<-0*er_mis 
er_amis<-0.1*er_mis # assumtion these animal still graze a bit  so the value is between 0 and 0.17
er_amda<-0.15*er_mda
#lactation energy eq 10.8 assuming milk fat content of 3.5%, this equation is per year 
er_lles<-myles*(1.47+0.4*3.5)
er_les<-0
er_lsis<-0 
er_lis<-myis*(1.47+0.4*3.5)
er_lda<-0
#net energy requirement per cow per day
erc_es_tt<-(er_mes+er_ames)+ er_les/365 
erc_es_tpt<-(er_mes+er_ames)+ er_les/365 
erc_les<-(er_mles+er_amles)+ er_lles/365 
erc_sis<-(er_msis+er_amsis)+ er_lsis/365 
erc_is<-(er_mis+er_amis)+ er_lis/365 
erc_da<-(er_mda+er_amda)+ er_lda/365 +er_mda*0.1*1#draft energy 

#total energy needed for transhumance season 1 when all animals are in Bama
erc_st1<-(erc_es_tt * numcow_tt + erc_es_tpt *numcow_tpt + erc_les *numcow_tl +numcow_f * erc_sis +numcow_d* erc_is +erc_da*numcow_da)*365*st1/12
erc_st2<-(erc_es_tpt *numcow_tpt + erc_les *numcow_tl +numcow_f * erc_sis +numcow_d* erc_is +numcow_da*erc_da)*365*st2/12
#total energy requirement 
erc<-erc_st1+erc_st2
##############################################################################################
#calculate energy requirement in by season  from each feed source 

#wet season 
ng_ws<-efng1/100*numcow_tt*erc_es_tt*ws_st1/12  +(lefng1/100 *numcow_tl*erc_les + sfng1/100*numcow_f*erc_sis + ifng1/100 * numcow_d*erc_is + dafng1/100 * (numcow_da*erc_da+numcow_tpt*erc_es_tpt))*ws/12
rc_ws<- efrc1/100*numcow_tt*erc_es_tt*ws_st1/12  +(lefrc1/100 *numcow_tl*erc_les + sfrc1/100*numcow_f*erc_sis + ifrc1/100 * numcow_d*erc_is+ dafrc1/100 *(numcow_tpt*erc_es_tpt + numcow_da*erc_da))*ws/12
rr_ws<- efrr1/100* numcow_tt*erc_es_tt*ws_st1/12  +(lefrr1/100 *numcow_tl*erc_les + sfrr1/100*numcow_f*erc_sis + ifrr1/100 * numcow_d*erc_is+ dafrr1/100 * (numcow_tpt*erc_es_tpt + numcow_da*erc_da))*ws/12
rl_ws<-efrl1/100*numcow_tt*erc_es_tt*ws_st1/12 +(lefrl1/100 *numcow_tl*erc_les + sfrl1/100*numcow_f*erc_sis + ifrl1/100 * numcow_d*erc_is+ dafrl1/100 *(numcow_tpt*erc_es_tpt + numcow_da*erc_da))*ws/12
pf_ws<-efpf1/100*numcow_tt*erc_es_tt*ws_st1/12 +(lefpf1/100 *numcow_tl*erc_les + sfpf1/100*numcow_f*erc_sis + ifpf1/100 * numcow_d*erc_is+ dafpf1/100 *(numcow_tpt*erc_es_tpt +  numcow_da*erc_da))*ws/12
conc_ws<-efconc1/100*numcow_tt*erc_es_tt*ws_st1/12  +(lefconc1/100*erc_les *numcow_tl + sfconc1/100*numcow_f*erc_sis + ifconc1/100 * numcow_d*erc_is+ dafconc1/100 *(numcow_tpt*erc_es_tpt + numcow_da*erc_da))*ws/12
conos_ws<-efconos1/100* numcow_tt*erc_es_tt*ws_st1/12+(lefconos1/100*erc_les *numcow_tl + sfconos1/100*numcow_f*erc_sis + ifconos1/100 * numcow_d*erc_is+ dafconos1/100 *(numcow_tpt*erc_es_tpt +numcow_da*erc_da))*ws/12

#dry season 
ng_ds<-(efng2/100* numcow_tt*erc_es_tt*ds_st1/12)+(efng2/100*numcow_tpt*erc_es_tpt + lefng2/100 *numcow_tl*erc_les + sfng2/100*numcow_f*erc_sis + ifng2/100 * numcow_d*erc_is+ dafng2/100 * numcow_da*erc_da)*ds/12
rc_ds<- (efrc2/100*numcow_tt*erc_es_tt*ds_st1/12)+(efrc2/100*numcow_tpt*erc_es_tpt +lefrc2/100 *numcow_tl*erc_les + sfrc2/100*numcow_f*erc_sis + ifrc2/100 * numcow_d*erc_is+ dafrc2/100 * numcow_da*erc_da)*ds/12
rr_ds<- (efrr2/100*numcow_tt*erc_es_tt*ds_st1/12)  +(efrr2/100*numcow_tpt*erc_es_tpt +lefrr2/100 *numcow_tl*erc_les + sfrr2/100*numcow_f*erc_sis + ifrr2/100 * numcow_d*erc_is+ dafrr2/100 * numcow_da*erc_da)*ds/12
rl_ds<-(efrl2/100* numcow_tt*erc_es_tt*ds_st1/12)+(efrl2/100*numcow_tpt*erc_es_tpt   +lefrl2/100 *numcow_tl*erc_les + sfrl2/100*numcow_f*erc_sis + ifrl2/100 * numcow_d*erc_is + dafrl2/100 * numcow_da*erc_da)*ds/12
pf_ds<-(efpf2/100*numcow_tt*erc_es_tt*ds_st1/12) +(efpf2/100*numcow_tpt*erc_es_tpt +lefpf2/100 *numcow_tl*erc_les + sfpf2/100*numcow_f*erc_sis + ifpf2/100 * numcow_d*erc_is + dafpf2/100 * numcow_da*erc_da)*ds/12
conc_ds<-(efconc2/100* numcow_tt*erc_es_tt*ds_st1/12)+(efconc2/100*numcow_tpt*erc_es_tpt +lefconc2/100*erc_les *numcow_tl + sfconc2/100*numcow_f*erc_sis + ifconc2/100 * numcow_d*erc_is+ dafconc2/100 * numcow_da*erc_da)*ds/12
conos_ds<-(efconos2/100* numcow_tt*erc_es_tt*ds_st1/12) +(efconos2/100*numcow_tpt*erc_es_tpt +lefconos2/100*erc_les *numcow_tl + sfconos2/100*numcow_f*erc_sis + ifconos2/100 * numcow_d*erc_is+ dafconos2/100 * numcow_da*erc_da)*ds/12

#total energy required from each source of food
ng<-ng_ws + ng_ds
rc<- rc_ws + rc_ds
rr<- rr_ws+ rr_ds
rl<-rl_ws + rl_ds
pf<-pf_ws + pf_ds
conc<-conc_ws + conc_ds
conos<-conos_ws + conos_ds

# fraction of each fodder at landscape scale over the year step. 
fng<- ng/(ng+rc+rl+pf+conc+conos+rr)
frc<- rc/(ng+rc+rl+pf+conc+conos+rr)
frr<- rr/(ng+rc+rl+pf+conc+conos+rr)
frl<-rl/(ng+rc+rl+pf+conc+conos+rr)
fpf<-pf/(ng+rc+rl+pf+conc+conos+rr)
fconc<-conc/(ng+rc+rl+pf+conc+conos+rr)
fconos<-conos/(ng+rc+rl+pf+conc+conos+rr)


#calculating the fresh weight of feed in basket 
# corrected for the fact that meg (metabolizing energy)
fw_g<-ng/(meg)
fw_rc<-rc/(merc)
fw_rl<-rl/(merl)
fw_pf<-pf/(mepf)
fw_rr<-rr/(merr)
fw_conc<-conc/(meconc)
fw_conos<-conos/(meconos)


#ratio of net energy available in the diet for maintenance to digestible energy consumed (REM)
#first compute digestibiliy of the landscape level feed
#de<-(ng*d_g+rc*d_rc+rl*d_rl+pf*d_pf+conc*d_conc+conos*d_conos+rr*d_rr)*100 # this seems to be wrong 11.3.2017
de<-(fng*d_g+frc*d_rc+frl*d_rl+fpf*d_pf+fconc*d_conc+fconos*d_conos+frr*d_rr)*100
#REM = ratio of net energy available in a diet for maintenance to digestible energy consumed
rem=(1.123-(4.092*10^-3*de)+(1.126*10^-5*de^2)-(25.4/de))

#yearly gross energy requirement at landscape scale
gerc<-(erc/rem)/(de/100) # this is annual 23.1.2018


# calculate production 
# milk production in tons of litre 
milk_les<-numcow_tl*myles *0.001
milk_is<- numcow_d * myis * 0.001 
milk<-milk_les+milk_is
#meat production in kg tons
meat_es <-  (numcow_tpt+ numcow_tt) *lwes*des * 0.001 
# here we actually account for the total meat produced regarless that the animals are not always in the area
meat_sis <- (numcow_f * lwsis* dsis)*0.001
# also dairy cows here do not contribute to meat, and it is the potential meat production, assume we cull them all
meat<-meat_es+meat_sis
# area needed for the feed production (with adjustement to pass from ha to km2, and tons to kg)
#first we need to compute the fodder yield. This is done by multiplying the crop yield with the
# residue factor, which is the part that is used as feed. This is computed in the water pararmeter
#excel sheet and accounts for post harvest loss

fun=function(x){x*(1+pgc)*rfm} # residue factor to account for what is consummed by livestock only
fy_rc<-overlay(y_maize,fun=fun)

fun=function(x){x*rfl}
fy_rl<-overlay(y_pulse,fun=fun)

fun=function(x){x*rfrr}
fy_rr<-overlay(y_rice,fun=fun)

fun=function(x,y){x*(1+pgc)*y}
y_maizec<-overlay(y_maize,cropland,fun=fun)
# max_c<-cellStats(y_maizec,stat='sum')
# 
y_pulsec<-overlay(y_pulse,cropland,fun=fun)
# max_l<-cellStats(y_pulsec,stat='sum')
# 
y_ricec<-overlay(y_rice,riceland,fun=fun)
# max_r<-cellStats(y_ricec,stat='sum')

 fy_rcc<-overlay(fy_rc,cropland,fun=fun)
# max_rc<-cellStats(fy_rcc,stat='sum')
# 
 fy_rlc<-overlay(fy_rl,cropland,fun=fun)
# max_rl<-cellStats(fy_rlc,stat='sum')
# 
 fy_rrc<-overlay(fy_rr,riceland,fun=fun)
# max_rl<-cellStats(fy_rlc,stat='sum')
###check from here in principle one should not work with the area but the produce... 


#we assume that every cropland pixel produces the basket so we need to correct the total production
#from the area to avoid double planting 

#compute the percentage of each feed on cropland
#so we need to compute the area used for each crop (in term of pixels, so in a 900m2)
fy_rcc[fy_rcc==0]<-NaN
avg_rc<-cellStats(fy_rcc,stat='mean')
#area required 
ar_rc<-fw_rc/avg_rc *pixel^2/1000000 # number pixel * adjustement in km2

fy_rlc[fy_rlc==0]<-NaN
avg_rl<-cellStats(fy_rlc,stat='mean')
ar_rl<-fw_rl/avg_rl * pixel^2/1000000
ar_pf<-fw_pf/(fy_pf*1000/10000*pixel^2*rfpf)

fy_rrc[fy_rrc==0]<-NaN
avg_rr<-cellStats(fy_rrc,stat='mean')
ar_rr<-fw_rr/avg_rr *pixel^2/1000000


#calculate the production of planted fodder under cropland 
croparea<-cellStats(cropland,stat='sum')*pixel^2/1000000 #area in km
# computing needs for the crossing animals assuming they are staying 1 month in the area
ar_c_c<-(erc_es_tt/12*numcow_c/merc)/(avg_rc)*pixel^2/1000000
#total cropland area required
ar<-ar_rc+ar_rl+ar_pf+ar_c_c


diff_ar<-croparea-ar
if (diff_ar>0){
  import_c = 0
  } else {import_c=-diff_ar
  } # now imports are in area in km2 
diff_ar<-round(diff_ar, digit=0)
#calculate the production under grazing land 


grazarea<-cellStats(grazland,stat='sum')*pixel^2/1000000 #area in km2
ar_g<-fw_g/(fy_g*10/0.01) #*(1000 to get to tons) *0.01 from ha to km2,  we are alredy in tons

# computing needs for the crossing animals assuming they are staying 1 month in the area
ar_g_c<-(erc_es_tt/12*numcow_c/meg)/(fy_g*10/0.01)
grazarea<-grazarea-ar_g_c

diff_g <- grazarea-ar_g
if (diff_g>0){
  import_g = 0
} else {import_g<- -diff_g}
diff_g <- round(diff_g, digit=0)

#calculate production under riceland
ricearea<-cellStats(riceland,stat='sum')*pixel^2/1000000 #area in km
ar_rr<-fw_rr/avg_rr  *pixel^2/1000000
diff_rr <- ricearea-ar_rr
if (diff_rr>0){ 
  import_rr = 0
} else {import_rr<- -diff_rr}
diff_rr<-round(diff_rr, digit=0)

####################################moving the manure management computation here as they are used in soil and ghg 
species<-'dairyCows'
species2<- 'Othercattle'
species3<- 'OtherCattle'
species4<- 'Cattle'

#Africa, Asia, Latin America
region='Africa'
country='Burkina Faso' # for global forest ressource
#for dairy 
# extracting the IPCC parameter for each management type depending on temperature 
mms_lagoon<-(les_lagoon_perc*numcow_tl+is_lagoon_perc*numcow_d)
mms_liquidslurry<-(les_liquidslurry_perc*numcow_tl+is_liquidslurry_perc*numcow_d)
mms_solidstorage<-(les_solidstorage_perc*numcow_tl+is_solidstorage_perc*numcow_d)
mms_drylot<-(les_drylot_perc*numcow_tl+is_drylot_perc*numcow_d)
mms_pasture<-(les_pasture_perc*numcow_tl+is_pasture_perc*numcow_d)
mms_dailyspread<-(les_dailyspread_perc*numcow_tl+is_dailyspread_perc*numcow_d)
mms_digester<-(les_digester_perc*numcow_tl+is_digester_perc*numcow_d)
mms_fuel<-(les_fuel_perc*numcow_tl+is_fuel_perc*numcow_d)
mms_other<-(les_other_perc*numcow_tl+is_other_perc*numcow_d)
mms_total<-mms_lagoon+mms_liquidslurry+mms_solidstorage+mms_drylot+mms_pasture+mms_dailyspread+mms_fuel+mms_other

mms_lagoon_perc<-mms_lagoon/mms_total*100
mms_liquidslurry_perc<- mms_liquidslurry/mms_total*100
mms_solidstorage_perc<- mms_solidstorage/mms_total*100
mms_drylot_perc<- mms_drylot/mms_total*100
mms_pasture_perc<- mms_pasture/mms_total*100
mms_dailyspread_perc<- mms_dailyspread/mms_total*100
mms_digester_perc<- mms_digester/mms_total*100
mms_fuel_perc<- mms_fuel/mms_total*100
mms_other_perc<- mms_other/mms_total*100

mms_params1 <- read.csv('1-input/parameter/MMSparams.csv')
mms_params <-subset(mms_params1 , mms_params1$Species==species&mms_params1$Region==region)
B0<-mms_params$B0

if(ipcc==1){
  mms_lagoon_perc<-mms_params$lagoon_perc
  mms_liquidslurry_perc<-mms_params$Liquid.slurry_perc
  mms_solidstorage_perc<-mms_params$Solid.storage_perc
  mms_drylot_perc<-mms_params$Dry.lot_perc
  mms_pasture_perc<-mms_params$Pasture_perc
  mms_dailyspread_perc<-mms_params$Daily.spread_perc
  mms_digester_perc<-mms_params$Digester_perc
  mms_fuel_perc<-mms_params$Burned.for.fuel_perc
  mms_other_perc<-mms_params$Other_perc}


mms_params <-subset(mms_params1 , mms_params1$Species==species2 &mms_params1$Region==region)
B02<-mms_params$B0

mms_lagoon2<-(es_lagoon_perc*numcow_tpt+es_lagoon_perc*numcow_tt*st1/12+sis_lagoon_perc*numcow_f+da_lagoon_perc*numcow_da)
mms_liquidslurry2<-(es_liquidslurry_perc*numcow_tpt+es_liquidslurry_perc*numcow_tt*st1/12+sis_liquidslurry_perc*numcow_f+da_liquidslurry_perc*numcow_da)
mms_solidstorage2<-(es_solidstorage_perc*numcow_tpt+es_solidstorage_perc*numcow_tt*st1/12+sis_solidstorage_perc*numcow_f+da_solidstorage_perc*numcow_da)
mms_drylot2<-(es_drylot_perc*numcow_tpt+es_drylot_perc*numcow_tt*st1/12+sis_drylot_perc*numcow_f+da_drylot_perc*numcow_da)
mms_pasture2<-(es_pasture_perc*numcow_tpt+es_pasture_perc*numcow_tt*st1/12+sis_pasture_perc*numcow_f+da_pasture_perc*numcow_da)
mms_dailyspread2<-(es_dailyspread_perc*numcow_tpt+es_dailyspread_perc*numcow_tt*st1/12+sis_dailyspread_perc*numcow_f)
mms_digester2<-(es_digester_perc*numcow_tpt+es_digester_perc*numcow_tt*st1/12+sis_digester_perc*numcow_f)
mms_fuel2<-(es_fuel_perc*numcow_tpt+es_fuel_perc*numcow_tt*st1/12+sis_fuel_perc*numcow_f+da_fuel_perc*numcow_da)
mms_other2<-(es_other_perc*numcow_tpt+es_other_perc*numcow_tt*st1/12+sis_other_perc*numcow_f+da_other_perc*numcow_da)
mms_total2<-mms_lagoon2+mms_liquidslurry2+mms_solidstorage2+mms_drylot2+mms_pasture2+mms_dailyspread2+mms_fuel2+mms_other2

mms_lagoon_perc2<-mms_lagoon2/mms_total2*100
mms_liquidslurry_perc2<- mms_liquidslurry2/mms_total2*100
mms_solidstorage_perc2<- mms_solidstorage2/mms_total2*100
mms_drylot_perc2<- mms_drylot2/mms_total2*100
mms_pasture_perc2<- mms_pasture2/mms_total2*100
mms_dailyspread_perc2<- mms_dailyspread2/mms_total2*100
mms_digester_perc2<- mms_digester2/mms_total2*100
mms_fuel_perc2<- mms_fuel2/mms_total2*100
mms_other_perc2<- mms_other2/mms_total2*100

if(ipcc==1){
  mms_lagoon_perc2<-mms_params$lagoon_perc
  mms_liquidslurry_perc2<-mms_params$Liquid.slurry_perc
  mms_solidstorage_perc2<-mms_params$Solid.storage_perc
  mms_drylot_perc2<-mms_params$Dry.lot_perc
  mms_pasture_perc2<-mms_params$Pasture_perc
  mms_dailyspread_perc2<-mms_params$Daily.spread_perc
  mms_digester_perc2<-mms_params$Digester_perc
  mms_fuel_perc2<-mms_params$Burned.for.fuel_perc
  mms_other_perc2<-mms_params$Other_perc}



import_c<-round(import_c,digits=0)
import_g<-round(import_g,digits=0)
import_rr<-round(import_rr,digits=0)
croparea<-round(croparea,digits=0)
grazarea<-round(grazarea,digits=0)
ricearea<-round(ricearea,digits=0)
ar_g<-round(ar_g,digits=1)
ar<-round(ar,digits=1)
ar_rr<-round(ar_rr,digits=1)


prod_ind<-data.frame( meat, milk ,croparea,grazarea, ricearea, ar, ar_g, ar_rr ,import_c, import_g  ,import_rr, numcow, numcow_tt,numcow_tpt, numcow_tl, numcow_d, numcow_f, numcow_da )
prod_ind_diff<-prod_ind-prod_base
prod_ind_per<-round(prod_ind_diff/prod_base, digit=1)
prod_ind_per<-ifelse(is.na(prod_ind_per),0,prod_ind_per)
prod_ind2<-rbind(prod_ind,prod_ind_diff)
prod_ind2<-rbind(prod_ind2, prod_ind_per)
names(prod_ind2)<-c("meat produced","milk produced", 'total area available for crop', 'total area available for pasture', "total available area for rice", "crop area used", 'pasture area used', 'rice area used'
, "import crop", 'import pasture', "import rice",'total numbers of cows', 'long transhumance cows', 'short transhumance cows', 'pastoral dairy cows', 'specialized dairy cows', 'fattening cows', 'draft animals' )

prod_ind2<-data.frame(t(prod_ind2))
colnames(prod_ind2)<-c('base','diff','percent')
##steve edits
prod_ind_val<-read.csv('1-input/parameter/productivity_val.csv')
prod_ind2$evaluation <- ifelse(prod_ind2$percent <= prod_ind_val$peu, 'low', ifelse((prod_ind2$percent >= prod_ind_val$peu) & (prod_ind2$percent <= prod_ind_val$peu),'medium','high'))

setwd("4-output")
pdf(paste(name,"productivity.pdf", sep="-"))
#par(mfrow=(c(2,1)))

plot(NA, xlim=c(0,100), ylim=c(0,10), bty='n',
     xaxt='n', yaxt='n', xlab='', ylab='')
grid.table(prod_ind2)

dev.off()

write.csv(prod_ind,paste(name,"prod_ind.csv", sep="-"),row.names = F)
setwd(path)

