# Code related to population ecology

# A package is needed for point pattern analysis
install.packages("spatstat")
> library(spatstat) #just to check if the package is correctly installed

#Lets use the bei data
bei 

#Now we plot the data
plot(bei)

#Resize the plot
plot(bei, pch=19, cex=.5) 

#Additional database
bei.extra
plot(bei.extra)

#Plot only one part of the dataset: elev
plot(bei.extra$elev)

elev <- bei.extra$elev

#If you don't know the name of the variable, better use numbers (the number of the element)
plot(bei.extra[[1]])
