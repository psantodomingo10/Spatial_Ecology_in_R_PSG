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
