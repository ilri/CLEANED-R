#path <<-'D:/MOSEVICTOR_PC/MOSE_E/ILRI_SHINY_APP2017/UPDATED2017NOV/CLEANED - Burkina2.11.2017/CLEANED - Burkina'

setwd(path)

############################################computation resulting from land use change#########
ccrop<-raster('1-input/spatial/lu/ccrop.tif')
icrop<-raster('1-input/spatial/lu/icrop.tif')
cropland<-raster('1-input/spatial/lu/cropland.tif')
riz<-raster('1-input/spatial/lu/riz.tif')
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
grazland<-raster('1-input/spatial/lu/grazland.tif')



################################################################################################
#extracting data for scenarios 
# here we will need to adjust the reclassification depending on the input layer 
fun=function(x,y){x+y}
cropland<-overlay(cropland,addcrop,fun=fun)
rcl2<- cbind(c(0,1,2 ),
             c(0,1,1))
cropland <- reclassify(cropland, rcl=rcl2)

rcl10<- cbind(c(0,1 ),
             c(0,2))
addcrop<-reclassify(addcrop, rcl=rcl10)


fun2=function(x,y){(x-y)}
temp<-overlay(grazland,addcrop,fun=fun2)
rcl3<- cbind(c(-2,-1,0,1 ),
             c(0,0,0,1))
grazland <- reclassify(temp, rcl=rcl3)
rcl4<- cbind(c(-2,-1,0,1 ),
             c(0,1,0,0))
lostgraz=reclassify(temp, rcl=rcl4)


# extracting dense forest
temp<-overlay(cforet,addcrop,fun=fun2)
cforet <- reclassify(temp, rcl=rcl3)
lostcforet <- reclassify(temp, rcl=rcl4)

temp<-overlay(gforet,addcrop,fun=fun2)
gforet <- reclassify(temp, rcl=rcl3)
lostgforet <- reclassify(temp, rcl=rcl4)

temp<-overlay(pforet,addcrop,fun=fun2)
pforet <- reclassify(temp, rcl=rcl3)
lostpforet <- reclassify(temp, rcl=rcl4)

temp<-overlay(asava,addcrop,fun=fun2)
asava <- reclassify(temp, rcl=rcl3)
lostasava <- reclassify(temp, rcl=rcl4)

temp<-overlay(arsava,addcrop,fun=fun2)
arsava <- reclassify(temp, rcl=rcl3)
lostarsava <- reclassify(temp, rcl=rcl4)

temp<-overlay(hsava,addcrop,fun=fun2)
hsava <- reclassify(temp, rcl=rcl3)
losthsava <- reclassify(temp, rcl=rcl4)


temp<-overlay(astep,addcrop,fun=fun2)
astep <- reclassify(temp, rcl=rcl3)
lostastep <- reclassify(temp, rcl=rcl4)

temp<-overlay(arstep,addcrop,fun=fun2)
arstep <- reclassify(temp, rcl=rcl3)
lostarstep <- reclassify(temp, rcl=rcl4)

temp<-overlay(hstep,addcrop,fun=fun2)
hstep <- reclassify(temp, rcl=rcl3)
losthstep <- reclassify(temp, rcl=rcl4)

temp<-overlay(riz,addcrop,fun=fun2)
riz <- reclassify(temp, rcl=rcl3)
lostriz <- reclassify(temp, rcl=rcl4)

temp<-overlay(autre,addcrop,fun=fun2)
autre <- reclassify(temp, rcl=rcl3)
lostautre <- reclassify(temp, rcl=rcl4)


fun=function(a,b,c){a+b+c}
lostforest<-overlay(lostcforet,lostgforet,lostpforet,fun=fun)



rcl10<- cbind(c(0,2 ),
              c(0,1))
addcrop<-reclassify(addcrop, rcl=rcl10)
