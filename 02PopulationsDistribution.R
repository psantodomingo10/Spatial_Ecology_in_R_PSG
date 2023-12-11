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
