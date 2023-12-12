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
