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


