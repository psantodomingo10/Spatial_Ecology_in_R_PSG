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
