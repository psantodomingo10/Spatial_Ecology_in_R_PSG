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
