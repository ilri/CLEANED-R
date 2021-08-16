
setwd(path)

############################################computation resulting from land use change#########



################################################################################################
#extracting data for scenarios 
# here we will need to adjust the reclassification depending on the input layer 
cropland<-cropland+addcrop


rcl2<- cbind(c(0,1,2 ),
             c(0,1,1))
cropland <- reclassify(cropland, rcl=rcl2)


### make a loop for all other land cover 

varname<-c(l11,l12,l30,l40 ,l50 ,l60 , l61,l62 ,l70 ,l71 ,l72 ,l80 ,l81 ,l82 ,l90 ,l100 ,l110 ,l120 ,l121 ,
           l122,l130 ,l140 ,l150 , l152,l153,l160,l170,l180,l190,l200,l201,l202,l220) 
varname2<-varname
rcl10<- cbind(c(0,1 ),
              c(0,2))
addcrop<-reclassify(addcrop, rcl=rcl10)

for (i in 1:length(varname)) {
    temp<-varname[[i]]-addcrop
    rcl3<- cbind(c(-2,-1,0,1 ),
                 c(0,0,0,1))
    varname[i]<- reclassify(temp, rcl=rcl3)
    names(varname[[i]])<-names(varname2[[i]])
    rcl4<- cbind(c(-2,-1,0,1 ),
             c(0,1,0,0))
    varname[length(varname)+1]<- reclassify(temp, rcl=rcl4)
    names(varname[length(varname)+1])<-paste0('lost', names(varname2[[i]]))
    }

rcl10<- cbind(c(0,2 ),
              c(0,1))
addcrop<-reclassify(addcrop, rcl=rcl10)


### this is the the part we adjust the cropycorr layers 
# there are several option 
corrOption<- 1  # 1 is all is 100% cropland, 2 all is mosaik so 50%, 3 it depends which land use is nearest

if (corrOption==1) {
     cropycorr<-cropycorr+ addcrop
     
} else if (corrOption==2) {
     cropycorr<-cropycorr+ addcrop*mosc1
} else {
     cropycorr<-cropycorr+ addcrop*nearestcrop +addcrop*(1-nearestcrop)*mosc1
     }

grazland<-l130+l120+l121+l122+l110+l100
grazycorr<-l130+l120*mosg1+l121*mosg1+l122*mosg1+l110*mosg2+l100*mosg2+l30*(1-mosc1)+l40*(1-mosc2)


