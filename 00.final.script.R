#Final script including all the different scripts during lectures

#----------------------------#

#Summary

# 01 Beginning
# 02.1 Population density
# 02.2 Populations distribution
# 03 Communities Multivariate And Overlaping Analysis
# 04 Remote sensing visualisation
# 05 Spectral indices
# 06 Time Series
# 07 Import Data
# 08 Copernicus Data
# 09 Classification
# 10 Variability
# 11 Principal Component Analysis

#-----------------------------#

#01 Beginning

# 42 is the meaning of life
# Using hashtag you can write comments, or anything you want. It won't run in R

# R as a calculator
2+3

#Assign to an object
zima <- 2+3
zima

duccio <- 5+3
duccio

final <- zima * duccio
final

final^2

# array
Sophi <- c (10,20, 30, 50, 70) #microplastics
# functions have parentheses and inside them there are arguments

paula <- c (100,500,600,1000,2000) #people

#Use function plot to plot, explore different arguments to change labels, size, color, etc
plot (paula,Sophi)
plot (paula,Sophi, xlab="number of people", ylab="microplastics")
plot (paula,Sophi, xlab="number of people", ylab="microplastics",pch=19)
plot (paula,Sophi, xlab="number of people", ylab="microplastics",pch=19,cex=2)
plot (paula,Sophi, xlab="number of people", ylab="microplastics",pch=19,cex=1.5,col="grey")

#Annother way to approach

people <- paula
microplastics <- sophi
plot(people, microplastics, pch=19, cex=2)
plot(people, microplastics, pch=19, cex=2, col="blue")

#----------------------------#

#02.1 Population density

# Code related to population ecology

# A package is needed for point pattern analysis
install.packages("spatstat")

#just to check if the package is correctly installed
> library(spatstat) 

#Lets use the bei data
bei 

#Now we plot the data
plot(bei)

#Resize the plot-cex and change the symbol-pch
plot(bei, pch=19, cex=.5) 

#Additional database
bei.extra
plot(bei.extra)

#Plot only one part of the dataset: elev
plot(bei.extra$elev)
elev <- bei.extra$elev
plot (elev)

#If you don't know the name of the variable, better use numbers (the number of the element)
plot(bei.extra[[1]])
elev2 <- bei.extra[[1]]
plot(elev2)

# passing from points to a countinuous surface
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.2)

#Create a palette of colors
#Is a vector that we can use multiple times by calling it. 
#Try to select appropiate colors for daltonics. Be inclusive
#Play with the colors
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(density_map, col=cl)
points(bei,cex=.5,col="white")
cl <- colorRampPalette(c("navyblue", "steelblue", "lightblue", "seashell2"))(100)
plot(density_map, col=cl)
points(bei,cex=.5,col="white")

plot(bei.extra)
elev <- bei.extra[[1]] # bei.extra$elev
plot(elev)

# multiframe
#Use this function to plot various plots in one single one
#Change the order of the arguments to change between rows and columns
par(mfrow=c(1,2))
plot(densitymap)
plot(elev)

par(mfrow=c(2,1))
plot(densitymap)
plot(elev)

#Now do it with three plots
par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

#----------------------------#

#02.2 Populations distribution

#Why population disperce over landscape in a certain manner?

#Run the libraries we are going to use
library(sdm)
library(rgdal)
library(terra)


file <- system.file("external/species.shp", package="sdm")
rana <- vect(file)
rana
plot(rana)
rana$Occurrence

#Plot only occurrence
plot(rana[rana$Occurrence == 1,],col='black',pch=16)

#Plot only absence
points(rana[rana$Occurrence == 0,],col='red',pch=16)

#Selecting presences
presence <- rana[rana$Occurrence == 1]
presence
plot(presence,col="black")

#Selecting absences
abse <- rana[rana$Occurrence == 0,]
plot(abse,col="red")

#plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(presence,col="black")
plot(abse,col="red")
plot(presence,col="black")

# To erase all the plots:
dev.off()

# exercise: plot pres and abse altogether with two different colours
plot(pres, col="dark blue")
points(abse, col="light blue")

path <- system.file("external", package="sdm")
path
lst <- list.files(path=path,pattern='asc$',full.names = T)
lst

# predictors: environmental variables
#Set the correct folder to serach for the files

elev <- rast("C:/Users/santo/AppData/Local/R/win-library/4.3/sdm/external/elevation.asc")
prec <- rast("C:/Users/santo/AppData/Local/R/win-library/4.3/sdm/external/precipitation.asc")
temp <- rast("C:/Users/santo/AppData/Local/R/win-library/4.3/sdm/external/temperature.asc")
vege <- rast("C:/Users/santo/AppData/Local/R/win-library/4.3/sdm/external/vegetation.asc")

preds <- c(elev, prec, temp, vege)
cl <- colorRampPalette(c('red','orange','yellow','green')) (100)
plot(preds, col=cl) 

#Plot all 4 predictors in a single plot
par(mfrow=c(2,2))

plot(preds$elevation, col=cl,main="Elevation")
points(rana[rana$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl,main="Temperature")
points(rana[rana$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl,main="Precipitation")
points(rana[rana$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl,main="Vegetation" )
points(rana[rana$Occurrence == 1,], pch=16)

#----------------------------#

#03 Communities Multivariate Overlaping

### Communities multivariate

#Open the library we are gonig to use
library(vegan)

data(dune)
dune
head(dune)
View(dune)

### detrended correspondence analysis

ordenado <- decorana(dune)
ordenado

ldc1=3.7004
ldc2=3.1166
ldc3=1.30055
ldc4=1.47888
total= ldc1+ldc2+ldc3+ldc4
pldc1=3.7004/total*100
pldc2=3.1166/total*100
pldc3=1.30055/total*100
pldc4=1.47888/total*100

plot(ordenado)

###Communities overlap

library(overlap)
data(kerinci)
View(kerinci)

#Change the time from radians to normal time
kerinci$timeRad <- kerinci$Time * 2 * pi

#Make a density plot for the tiger across time
tiger <- kerinci[kerinci$Sps=="tiger",]
tiger
timetig <- tiger$timeRad
densityPlot(timetig, rug=TRUE)

#Make a density plot for the macaque across time
maca <- kerinci[kerinci$Sps=="macaque",]
maca
timemaca <- maca$timeRad
densityPlot(timemaca, rug=TRUE)

#Make the overlap plot to see when do the tiger and macaque presence overlap
overlapPlot(timetig, timemaca)
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')

kerinci$Sps
summary(kerinci$Sps)

#Make a density plot for the tapir across time
tapi <- kerinci[kerinci$Sps=="tapir",]
tapi
timetapi <- tapi$timeRad
densityPlot(timetapi, rug=TRUE)

#Make the overlap plot to see when do the tapir and macaque presence overlap
overlapPlot(timemaca, timetapi)

#----------------------------#

#04 Remote sensing visualisation

####imageRy
# RS data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")  # from devtools
# in case you have not terra
# install.packages("terra")

#Open libraries we are going to use
library(imageRy)
library(terra)

#Get the list of the data
im.list()

#Import and asign the blue, green, red and infrared bands
bband <- im.import("sentinel.dolomites.b2.tif")
gband <- im.import("sentinel.dolomites.b3.tif")
rband <- im.import("sentinel.dolomites.b4.tif") 
irband <- im.import("sentinel.dolomites.b8.tif")

#Creating color palettes for each of the bands
clblue <- colorRampPalette(c("darkblue", "blue", "lightblue"))(100)
clgreen <- colorRampPalette(c("darkgreen", "green", "lightgreen"))(100)
clred <- colorRampPalette(c("darkred", "red", "coral"))(100)
clir <- colorRampPalette(c("brown", "orange", "yellow"))(100)

#Plot each band
plot(bband,col=clblue)
plot(gband,col=clgreen)
plot(rband,col=clred)
plot(irband,col=clir)

#Now plot them in multiframe
par(mfrow=c(2,2))
plot(bband,col=clblue)
plot(gband,col=clgreen)
plot(rband,col=clred)
plot(irband,col=clir)

#Plot all of them in gray scale
sentdo <- c(bband, gband, rband, irband)
clall <- colorRampPalette(c("black", "darkgray", "gray")) (100)
plot(sentdo, col=clall)

#----------------------------#

#05 Spectral indices

###Vegetation indices

#Open the libraries we are going to use
library(imageRy)
library(terra)

#Import an image from 1992
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
#Bands: 1=NIR 2=RED 3=GREEN
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, 2, 1, 3)
im.plotRGB(m1992, 2, 3, 1)

#Import an image from 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg")
#Bands: 1=NIR 2=RED 3=GREEN
im.plotRGB(m2006, 1, 2, 3)
im.plotRGB(m2006, 2, 1, 3)
im.plotRGB(m2006, 2, 3, 1)

# build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, 2, 3, 1)
im.plotRGB(m2006, 2, 3, 1)

# DVI = NIR - RED
# bands: 1=NIR, 2=RED, 3=GREEN

dvi1992 = m1992[[1]] - m1992[[2]] #Calculando el DVI
dvi1992
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi1992, col=cl)

dvi2006 = m2006[[1]] - m2006[[2]] #Calculando el DVI
dvi2006
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi2006, col=cl)

##Calcular NDVI
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi2006 = (m2006[[1]] - m2006[[2]]) / (m2006[[1]] + m2006[[2]])

#Par. Multiframe
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#Speeding up calculation
dvi1992i <- im.dvi(m1992, 1, 2)
dvi2006i <- im.dvi(m2006, 1, 2)

#----------------------------#

#06 Time Series

# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#Instal 2 packages useful to analyse raster images
install.packages("raster")
install.packages("rasterVis")

#Run libraries we are going to use
library(raster)
library(rasterVis)
library(imageRy)
library(terra)
library(rgdal)

#Import the data
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

#Plot in multiframe
par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#Plot the difference
dif <- EN01[[1]]-EN13[[1]]
plot(dif)

#Change color palette
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(dif,col=cldif)

### New example: temperature in Greenland

g2000 <- im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(g2000, col=clg)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col=clg)

par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

# stacking the data
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

# Exercise: make the differencxe between the first and the final elemnts of the stack
difg <- stackg[[1]] - stackg[[4]]
# difg <- g2000 - g2015
plot(difg, col=cldif)

# Exercise: make a RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3)

#----------------------------#

#07 Import Data

# 1 Download an image from internet
# 2 Save in a known folder

# 3 Set the working directory
setwd("C:/Users/santo/Downloads")

# 4 Open library terra and others that allow to use jpg and rasters
library(terra)
library(rgdal)
library(raster)

#Download a pair of images from internet and import them
NajafAntes <- rast("najafiraq_oli_2023219_lrg.jpg")
NajafAntes
plot(NajafAntes)
NajafDesp <- rast("najafiraq_etm_2003140_lrg.jpg")
NajafDesp
plot(NajafDesp)

#Plot them multiframe
par(mfrow=c(2,1))
plot(NajafAntes)
plot(NajafDesp)

#Change rows for columns
par(mfrow=c(1,2))
plot(NajafAntes)
plot(NajafDesp)

plotRGB(NajafAntes,r=1,g=2,b=3)

clvir <- colorRampPalette(c("violet", "darkblue", "blue", "green", "yellow"))(100)

plot(NajafAntes [[1]], col=clvir)
plot(NajafAntes [[2]])
plot(NajafAntes [[3]])


# Download your own preferred image:
typhoon <- rast("mawar_vir2_2023144_lrg.jpg")

plotRGB(typhoon, r=1, g=2, b=3)
plotRGB(typhoon, r=2, g=1, b=3)
plotRGB(typhoon, r=3, g=2, b=1)


# The Mato Grosso image can be downloaded directly from EO-NASA:

mato <- rast("matogrosso_l5_1992219_lrg.jpg")
plotRGB(mato, r=1, g=2, b=3) 
plotRGB(mato, r=2, g=1, b=3) 

#----------------------------#

#08 Copernicus Data

# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4)
library(terra)

# install.packages("name_of_the_package_here")

setwd("~/Downloads") # in W*****s \ means /

soilm2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023)

# there are two elements, let's use the first one!
plot(soilm2023[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilm2023[[1]], col=cl)

ext <- c(22, 26, 55, 57) # minlong, maxlong, minlat, maxlat
soilm2023c <- crop(soilm2023, ext)

plot(soilm2023c[[1]], col=cl)

# new image
soilm2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023_24)
soilm2023_24c <- crop(soilm2023_24, ext)
plot(soilm2023_24c[[1]], col=cl)

#----------------------------#

#09 Classification

### Classifying rasters
### Classifying satellite images and estimate the amount of change

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

#Open libraies we are going to use
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

install.packages("patchwork")
library(patchwork)

# classify satellite data

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun)

plotRGB(sun, 1, 2, 3)
plot(sunc)

#Import the images you want to analyse
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

#Classify the images and select the clusters in which you want to divide
m1992c <- im.classify(m1992, num_clusters=2)
m2006c <- im.classify(m2006, num_clusters=2)

#Plot the classified images
plot(m1992c)
plot(m2006c)

#Calculate the frequncies
freq1992 <- freq(m1992c)
freq1992
freq2006 <- freq(m2006c)
freq2006

#Calculate the percentages
tot1992 = ncell(m1992)
perc1992 = freq1992 * 100 / tot1992
perc1992
tot2006 = ncell(m2006)
perc2006 = freq2006 * 100 / tot2006
perc2006

# building the final table
#With the results interpret them and create the vectors with the results
cover <- c("forest","agriculture") 
perc1992 <- c(83.08, 16.91)
perc2006 <- c(45.31, 54.69)

#Create the dataframe with the results
p <- data.frame(cover, perc1992, perc2006)
p

# final output
p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white")
p1+p2

# final output, rescaled
p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2

#----------------------------#

# 10 Variability

# measurement of RS based variability

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

# band 1 = NIR
# band 2 = red
# band 3 = green

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]]
plot(nir)

# moving window
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)

# Exercise: calculate variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# Exercise 2: plot via par(mfrow()) the 3x3 and the 7x7 standard deviation
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

# original image plus the 7x7 sd
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)

#----------------------------#

# 11 Principal Component Analysis

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

pairs(sent)

# perform PCA on sent
sentpc <- im.pca(sent)
pc1 <- sentpc$PC1

viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

# calculating standard deviation ontop of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)
# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

# stack all the standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)

#----------------------------#
