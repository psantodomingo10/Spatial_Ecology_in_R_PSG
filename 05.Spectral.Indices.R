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
