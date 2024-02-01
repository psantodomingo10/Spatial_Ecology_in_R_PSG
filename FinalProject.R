### Pedro Santodomingo Garzón
### Final Project Spatial Ecology in R
### 2024

### In this project i'm going to evaluate the deforestation rates in the 
### Colombian Amazonia over the last years

### Load the necessary libraries
library(raster) #to work with raster files
library(terra) #to manipulate data in raster form
library(ncdf4) #to import the .nc copernicus files
library(imageRy) #Modify and share images
library(patchwork) #to plot muliframe graphs
library(ggplot2) #to create graphs with ggplot function
library(viridis) #color palette for colorblind people

### Set the working directory
setwd("C:/Users/santo/Documentos/Spatial Ecology")

### Import the downloaded data

### In this case, the data was dowloaded from copernicus and it corresponds
### to the Fraction of Green Vegetation Cover (FCOVER)

### I dowloaded the data for years 2000, 2005, 2010 and 2015
FCOVER2000 <- rast("c_gls_FCOVER_200001200000_GLOBE_VGT_V2.0.2.nc")
FCOVER2005 <- rast("c_gls_FCOVER_200501200000_GLOBE_VGT_V2.0.1.nc")
FCOVER2010 <- rast("c_gls_FCOVER_201001200000_GLOBE_VGT_V2.0.1.nc")
FCOVER2015 <- rast("c_gls_FCOVER-RT6_201501200000_GLOBE_PROBAV_V2.0.2.nc")

### As every file has inside various images, i'm going to stack in a new
### object only the first image of each file
FCOVERstack <-  c(FCOVER2000[[1]],FCOVER2005[[1]],
                  FCOVER2010[[1]],FCOVER2015[[1]])

### I'm going to focus only in the Macarena Region, so let's create a variable
### with the following coordinates
ext <- c(-75, -71, 0.5, 3)

### Crop the object with only the first image of each file with the coordinates
### establised before

###Now we have the images of the FCOVER for the interested region 
FCOVERCol <- crop(FCOVERstack,ext)

### Let's have a look
plot(FCOVERCol,main=c("January 2000","January 2005",
                      "January 2010","January 2015"))

### Now  calculate the difference between each period of time
difCoverCol0500 <- FCOVERCol[[1]]-FCOVERCol[[2]]
difCoverCol1005 <- FCOVERCol[[2]]-FCOVERCol[[3]]
difCoverCol1510 <- FCOVERCol[[3]]-FCOVERCol[[4]]
difCoverColTotal <- FCOVERCol[[1]]-FCOVERCol[[4]]

### Let's see the results
cl <- colorRampPalette(c("black","darkblue", "blue", "lightblue","white")) (100)
par(mfrow=c(2,2))
plot(difCoverCol0500,col=cl,main="Change 2000-2005")
plot(difCoverCol1005,col=cl, main="Change 2005-2010")
plot(difCoverCol1510,col=cl, main="Change 2010-2015")
plot(difCoverColTotal,col=cl, main="Change 2000-2015")

###In order to see better results, i'm going to classify the results in 
###three categories: Reforestation, No change, Deforestation
difCoverCol0500c <- im.classify(difCoverCol0500,c(-0.0001,0,0.0001))
difCoverCol1005c <- im.classify(difCoverCol1005,c(-0.0001,0,0.0001))
difCoverCol1510c <- im.classify(difCoverCol1510,c(-0.0001,0,0.0001))
difCoverColTotalc <- im.classify(difCoverColTotal,c(-0.0001,0,0.0001))

####Calculate the total number of pixels in the images
totalpix <- ncell(difCoverColTotalc)

###Calculate the percentage of each category in each period of time
freq(difCoverCol0500c)/totalpix
freq(difCoverCol1005c)/totalpix
freq(difCoverCol1510c)/totalpix
freq(difCoverColTotalc)/totalpix

###These are the results:
###> freq(difCoverCol0500c)/totalpix
###layer        value     count
###1 7.971939e-06 7.971939e-06 0.1209343
###2 7.971939e-06 1.594388e-05 0.7015784
###3 7.971939e-06 2.391582e-05 0.1774872
###> freq(difCoverCol1005c)/totalpix
###layer        value     count
###1 7.971939e-06 7.971939e-06 0.5409678
###2 7.971939e-06 1.594388e-05 0.3306282
###3 7.971939e-06 2.391582e-05 0.1284040
###> freq(difCoverCol1510c)/totalpix
###layer        value      count
###1 7.971939e-06 7.971939e-06 0.16256378
###2 7.971939e-06 1.594388e-05 0.80277423
###3 7.971939e-06 2.391582e-05 0.03466199
###> freq(difCoverColTotalc)/totalpix
###layer        value      count
###1 7.971939e-06 7.971939e-06 0.13971620
###2 7.971939e-06 1.594388e-05 0.80713489
###3 7.971939e-06 2.391582e-05 0.05314892

###Create the results table
classChgRes <- c("Reforestation", "No Change","Deforestation")
f00t05 <- c(12,70,18)
f05t10 <- c(54,33,13)
f10t15 <- c(16,80,4)
f00t15 <- c(14,81,5)
ChgRes <- data.frame(classChgRes,f00t05,f05t10,f10t15,f00t15)

###Create the ggplots
p0500 <- ggplot(ChgRes, aes(x=classChgRes, y=f00t05)) + 
      geom_bar(stat="identity", 
               fill=c("yellow","grey","purple"))+
                 geom_text(aes(label = f00t05), 
                           size = 4, 
                           hjust = 0.5, vjust = 3, position = "stack")
p1005 <- ggplot(ChgRes, aes(x=classChgRes, y=f05t10)) + 
  geom_bar(stat="identity", 
           fill=c("yellow","grey","purple"))+
  geom_text(aes(label = f05t10), 
            size = 4, 
            hjust = 0.5, vjust = 3, position = "stack")
p1510 <- ggplot(ChgRes, aes(x=classChgRes, y=f10t15)) + 
  geom_bar(stat="identity", 
           fill=c("yellow","grey","purple"))+
  geom_text(aes(label = f10t15), 
            size = 4, 
            hjust = 0.5, vjust = 1)
pTotal <- ggplot(ChgRes, aes(x=classChgRes, y=f00t15)) + 
  geom_bar(stat="identity", 
           fill=c("yellow","grey","purple"))+
  geom_text(aes(label = f00t15), 
            size = 4, 
            hjust = 0.5, vjust = 1)


###Print the results
par(mfrow=c(1,1))
cldif <- colorRampPalette(c("yellow","grey","purple"))(100)
plot(difCoverCol0500c,col=cldif,main="Change 2000-2005")
p0500
plot(difCoverCol1005c,col=cldif,main="Change 2005-2010")
p1005
plot(difCoverCol1510c,col=cldif,main="Change 2010-2015")
p1510
plot(difCoverColTotalc,col=cldif,main="Change 2000-2015")
pTotal

###As the results don't show a clear pattern, we are going to focus on a more
###specific area.

###Now i have downloaded images from Sentinel-2
###The images are in false color, so bands 8, 4 and 3 that corresponds to
###8: NIR band, 4: Red band and 3: Green band

###Import the images
Macarena2016 <- rast ("2016-01-17-00_00_2016-01-17-23_59_Sentinel-2_L1C_False_color.jpg")
Macarena2024 <- rast ("2024-01-10-00_00_2024-01-10-23_59_Sentinel-2_L1C_False_color.jpg")

###Let's have a look
par(mfrow=c(2,1))
plotRGB(Macarena2016,1,2,3)
plotRGB(Macarena2024,1,2,3)

###Calculate the DVI
###DVI = NIR - RED
###bands: 1=NIR, 2=RED, 3=GREEN

par(mfrow=c(2,1))
dvi2016 <- Macarena2016[[1]]-Macarena2016[[2]]
plot(dvi2016,col=cl,main="dvi 2016")
dvi2024 <- Macarena2024[[1]]-Macarena2024[[2]]
plot(dvi2024,col=cl,main="dvi 2024")

###Calculate the NDVI
###NDVI=DVI/NIR + RED
###bands: 1=NIR, 2=RED, 3=GREEN

ndvi2016 <- dvi2016/(Macarena2016[[1]]+Macarena2016[[2]])
plot(ndvi2016,col=cl,main="NDVI 2016")
ndvi2024 <- dvi2024/(Macarena2024[[1]]+Macarena2024[[2]])
plot(ndvi2024,col=cl,main="NDVI 2024")

###Classify the images

par(mfrow=c(1,1))
Macarena2016c <- im.classify(Macarena2016,num_clusters = 4)
Macarena2024c <- im.classify(Macarena2024,num_clusters = 2)
plot(Macarena2016c[[1]],col=cl)
plot(Macarena2024c[[1]],col=cl)

####Calculate the total number of pixels in the images
totalpix2016 <- ncell(Macarena2016c)
totalpix2024 <- ncell(Macarena2024c)

###Calculate the percentage of each category in each period of time
freq(Macarena2016c[[1]])/totalpix2016
freq(Macarena2024c[[1]])/totalpix2024

###These are the results:
###> freq(Macarena2016c[[1]])/totalpix2016
###layer        value       count
###1 1.397585e-06 1.397585e-06 0.048264199
###2 1.397585e-06 2.795170e-06 0.185998994
###3 1.397585e-06 4.192755e-06 0.006359012
###4 1.397585e-06 5.590340e-06 0.759377795
###> freq(Macarena2024c[[1]])/totalpix2024
###layer        value     count
###1 1.397585e-06 1.397585e-06 0.2861849
###2 1.397585e-06 2.795170e-06 0.7138151

###Create the results table
classForest <- c("Forest","Deforested")
y2016 <- c(76,24)
y2024 <- c(71,29)
ChgMacarena <- data.frame(classForest,y2016,y2024)

###Final Tables
m1 <- ggplot(ChgMacarena, aes(x=classForest, y=y2016, color=classForest)) + 
  geom_bar(stat="identity", fill="white") + ylim(c(0,100))

m2 <- ggplot(ChgMacarena, aes(x=classForest, y=y2024, color=classForest)) + 
  geom_bar(stat="identity", fill="white") + ylim(c(0,100))

m1 + m2
