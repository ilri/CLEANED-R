######################### water pathway ##############
#by Catherine Pfeifer
#20.6.2016
#clearing all memory 
#Version BF 1.2


# read libraries
library(raster)
library(maptools)
library(RColorBrewer)
library(gridExtra)
setwd(path)

water_base<-read.csv('1-input/base_run/water_ind.csv', row.names = NULL)
#water_base<-water_base[,2:7]
water_map<-raster('1-input/base_run/water_map.tif')

############################water requirement

#computing water requirment for the crops
#adjusting et in mm (it is now a high)

fun=function(x,y){x*y}
ET_grasl<-overlay(ET_grasl,cropland,fun=fun)
ET_maize<-overlay(ET_maize,cropland,fun=fun)
ET_pulse<-overlay(ET_pulse,cropland,fun=fun)
ET_gras<-overlay(ET_gras,grazland,fun=fun)
ET_rice<-overlay(ET_rice,riceland,fun=fun)

#plot(ET_grasl)

# now we need to adjust the ET by the proportion in the feed basket 
# these proportions are based on area used for each crop given the total crop area


fun=function(x,y,z,v,w){((ar_rc/croparea))*x+(ar_rl/croparea)*y+(ar_pf/croparea)*z+ (ar_g/grazarea)*v+(ar_rr/ricearea)*w}
wr<-overlay(ET_maize,ET_pulse,ET_grasl,ET_gras,ET_rice,fun=fun)
#plot(wr)


##############create the indicator
#spatial indicator : water use intensity 
fun<-function(x,y){x/y}
wui<-overlay(wr,rain,fun=fun)
#plot(wui)
#plot(sarea,add=TRUE)

#the lanscape level indicator 
# total water consumed by feed 
#wui_avg<-round(cellStats(wr,stat='mean'),1)  
wr_sum<-round(cellStats(wr,stat='sum'),0)
wu_animal<-round(wr_sum/numcow,0) #num cow here takes the average of the pastoral cows over the year
wdiff<-round((cellStats(rain, stat='sum')-wr_sum)/1000, 0) # in cubic meters

# why not per produce 
wu_milk<-round(wr_sum/(milk_les+milk_is),0) #num cow here takes the average of the pastoral cows over the year
wu_meat<-round(wr_sum/(meat_es+meat_sis),0) #num cow here takes the average of the pastoral cows over the year
#average water intensity 
wui_avg<-round(cellStats(wui,stat='mean'),3) 


#indifference computation 
water_ind<-data.frame(wr_sum, wdiff, wu_animal,wu_milk,wu_meat,wui_avg )
water_ind_diff<-water_ind-water_base
water_map_diff<-(wui-water_map)
water_ind_diff<-water_ind-water_base
water_ind2<-rbind(water_ind,water_ind_diff)
water_ind_perc<-round(water_ind_diff/water_base*100, digit=1)
water_ind2<-rbind(water_ind2,water_ind_perc)
names(water_ind2)<-c("total eau consommée","difference entre pluie et eau consommée", 'eau consommee par tête', 'eau consommée par tonne de lait', "eau consommée par tonne de viande", "intensite moyenne de consommation d'eau")
water_ind2<-data.frame(t(water_ind2))
colnames(water_ind2)<-c('resultat','difference','Pourcent')


##steve edits
water_ind_val<-read.csv('1-input/parameter/water_val.csv')
water_ind2$val <- ifelse(water_ind2$Pourcent <= water_ind_val$peu, 'faible', ifelse((water_ind2$Pourcent >= water_ind_val$peu) & (water_ind2$Pourcent <= water_ind_val$peu),'moyen','important'))


title<-paste('Impact eau : intensité de consommation', name, sep=" ")
col<-colorRampPalette(brewer.pal(9,'Blues'))(100)
col2<-colorRampPalette((brewer.pal(9,'Reds')))(100)

title2<-paste('Impact eau : difference', name, sep=" ")


par(mfrow=c(1,2),mar=c(2, 4.5, 2, 6))

#pdf(paste(name,"water_pathway.pdf", sep="-"))
#par(mfrow=(c(2,1)))
plot(wui*100, legend.width=1, legend.shrink=0.45,col=col)
plot(sarea, add=TRUE)
title(title)
plot(water_map_diff, legend.width=1, legend.shrink=0.45,col=col2)
plot(sarea, add=TRUE)
title(title2)
#plot(NA, xlim=c(0,100), ylim=c(0,10), bty='n',
     #xaxt='n', yaxt='n', xlab='', ylab='')







#################################visualisation 
#extract the maps for final user
setwd("4-output")

pdf(paste(name,"water_pathway.pdf", sep="-"))
#par(mfrow=(c(2,1)))
plot(wui*100, legend.width=1, legend.shrink=0.75,col=col)
plot(sarea, add=TRUE)
title(title)
plot(water_map_diff, legend.width=1, legend.shrink=0.75,col=col2)
plot(sarea, add=TRUE)
title(title2)
plot(NA, xlim=c(0,100), ylim=c(0,10), bty='n',
     xaxt='n', yaxt='n', xlab='', ylab='')
grid.table(water_ind2)


dev.off()


# tiff(paste(name,"water_pathway.tiff", sep ="-"))
# plot(wui*100, legend.width=1, legend.shrink=0.75,col=col)
# plot(sarea, add=TRUE)
# title(title)
# dev.off()

writeRaster(wui,paste(name,"water_map.tif", sep="-"), overwrite= T)
write.csv(water_ind,paste(name,"water_ind.csv", sep="-"),row.names = F)
