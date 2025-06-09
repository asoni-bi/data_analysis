#Data Visualization Techniques

# *********Histogram************
data=read.table("Filtered_MERGED_DATA_Yeast.txt", header=T)
hist(data$DM_YPD)
#change bin size
hist(data$DM_YPD, breaks=50)
#If we want to compare histograms for 2 different parameters, replacing 
#frequency by probability density allows us to compare them at the same scale
#we don't look at the number of observations in each bin, rather we look at
#for example, 10% observations are in 1st bin, 30% in next and so on
#This helps bringing the two parameters at a comparable scale
hist(data$DM_YPD, breaks=50, prob=T)
hist(data$DM_SD, breaks=50, prob=T)

#more options(cex is for font size)
hist(data$DM_YPD, breaks=50, prob=T, cex.axis=1.2, xlab="Noise in YPD",
     cex.lab=1.4, main="Histogram of Noise in YPD", cex.main=1.5)
#color r=red g=green b=blue and the 4th number is for transparency
hist(data$DM_YPD, breaks=50, prob=T, cex.axis=1.2, xlab="Noise in YPD",
     cex.lab=1.4, main="Histogram of Noise in YPD", cex.main=1.5,
     col=rgb(1,0,0,0.3))
#get rid of border
hist(data$DM_YPD, breaks=50, prob=T, cex.axis=1.2, xlab="Noise in YPD",
     cex.lab=1.4, main="Histogram of Noise in YPD", cex.main=1.5,
     col=rgb(1,0,0,0.3), border=F)
#We have changed the color for DM_SD histogram, removed the border, and added
#it on top of the DM_YPD histogram by 'add=T'
hist(data$DM_SD, breaks=50, prob=T, col=rgb(0,0,1,0.3), border=F, add=T)
#See that the graph is going above the max Y axis which is 0.2 now
#change it to 0.35 in the initial graph
hist(data$DM_YPD, breaks=50, prob=T, cex.axis=0.9, xlab="Noise in YPD",
     cex.lab=1, main="Histogram of Noise in YPD", cex.main=1.3,
     col=rgb(1,0,0,0.3), border=F, ylim=c(0,0.35))
hist(data$DM_SD, breaks=50, prob=T, col=rgb(0,0,1,0.3), border=F, add=T)
#This overlapping visualization is fine for 2 parameters but not for more
#Save the histogram in pdf(pdf maintains resolution), to keep resolution of
#points, use 'useDingbats=F'
dev.copy2pdf(file="Histogram_noise.pdf", useDingbats=F)
#close the histogram and the file
dev.off()

# **********Density plot**************
density(data$DM_YPD)
plot(density(data$DM_YPD))
#lwd is line width
plot(density(data$DM_YPD), cex.axis=0.9, xlab="Expression noise", cex.lab=1,
     main="Density plot of noise", cex.main=1.3, col="red", lwd=1.5)
#Now we will add another parameter/environmental condition DM_SD
#using 'lines' we are asking to add the new parameter plot on top of the old
#below line gives error 'missing values', could be NA values in data
lines(density(data$DM_SD), col="blue", lwd=3)
#to check if there are NA values
is.na(data$DM_SD) #There are TRUE values in o/p so NA values are present
#using na.omit of data$DM_SD, we remove the NAs
lines(density(na.omit(data$DM_SD)), col="blue", lwd=3)
#Increase the Y axis range as graph is going above max y which is 0.2 
plot(density(data$DM_YPD), cex.axis=0.9, xlab="Expression noise", cex.lab=1,
     main="Density plot of noise",cex.main=1.3, col="red", lwd=1,ylim=c(0,0.35))
lines(density(na.omit(data$DM_SD)), col="blue", lwd=1.5)
#Add Num_RegTF_YeastractYT graph on top (just to see how we can compare multiple
#parameters with density plot unlike histogram)
lines(density(data$Num_RegTF_YeastractYT), col="green", lwd=2)
dev.copy2pdf(file="Density_plot_noise.pdf", useDingbats=F)
dev.off()

# ********Mean sd plots*************
tab=read.table("GrowthCurve_YPD_24h.txt", header=T)
names(tab)
View(tab) #to see the data in table format
#mean values; error bars showing standard deviation
library(matrixStats)
#rowMeans can directly operate on dataframes(no need for a matrix)
g01mean=rowMeans(tab[,c(2,3,4)])
head(g01mean)
#To get SDs, the data subset first needs to be stored in form of matrix
g01sd=rowSds(as.matrix(tab[,c(2,3,4)]))
head(g01sd)

g02mean=rowMeans(tab[,c(5,6,7)])
g02sd=rowSds(as.matrix(tab[,c(5,6,7)]))

g03mean=rowMeans(tab[,c(8,9,10)])
g03sd=rowSds(as.matrix(tab[,c(8,9,10)]))

g10001mean=rowMeans(tab[,c(11,12,13)])
g10001sd=rowSds(as.matrix(tab[,c(11,12,13)]))

g10002mean=rowMeans(tab[,c(14,15,16)])
g10002sd=rowSds(as.matrix(tab[,c(14,15,16)]))

g10003mean=rowMeans(tab[,c(17,18,19)])
g10003sd=rowSds(as.matrix(tab[,c(17,18,19)]))

#Now we have generated all means and SDs
#Error bars are given by sd
#Using SDs we generate lower and upper values (+ or - SD from mean)
g01.dn=g01mean-g01sd
g01.up=g01mean+g01sd

g02.dn=g02mean-g02sd
g02.up=g02mean+g02sd

g03.dn=g03mean-g03sd
g03.up=g03mean+g03sd

g10001.dn=g10001mean-g10001sd
g10001.up=g10001mean+g10001sd

g10002.dn=g10002mean-g10002sd
g10002.up=g10002mean+g10002sd

g10003.dn=g10003mean-g10003sd
g10003.up=g10003mean+g10003sd

#Now we will use all these values to generate a Mean-sd plot
#pch is point types
plot(tab$Time_h, g01mean, pch=20, cex=0.8, cex.axis=0.9, cex.lab=1,
     xlab="Time(h)", ylab="OD600", col="#000066")
#join the points (by drawing a line on top)
lines(tab$Time_h, g01mean, col="#000066")
#add arrows, tab$Time_h, g01.dn, tab$Time_h, g01.up - tell coordinates
#where the arrow should start and end
#here the SDs for g01 are really small, so the arrows are not visible
arrows(tab$Time_h, g01.dn, tab$Time_h, g01.up, code=0, angle=90, col="#000066",
       cex=0.8)

#g01, g02, g03, g10001, g10002, g10003 are the six strains growing in YPD
#Now we want to compare their growth, so we'll add data on top of the plot
#to add on top, we use 'points'

points(tab$Time_h, g02mean, pch=20, cex=0.8, col="#3333FF")
lines(tab$Time_h, g02mean, col="#3333FF")
arrows(tab$Time_h, g02.dn, tab$Time_h, g02.up, code=0, angle=90, col="#3333FF",
       cex=0.8)

points(tab$Time_h, g03mean, pch=20, cex=0.8, col="#3399FF")
lines(tab$Time_h, g03mean, col="#3399FF")
arrows(tab$Time_h, g03.dn, tab$Time_h, g03.up, code=0, angle=90, col="#3399FF",
       cex=0.8)

#for g10001, we can see slightly different data points(non overlapping)
#The small lines on points towards the right are arrows(or sd) at angle=90
points(tab$Time_h, g10001mean, pch=20, cex=0.8, col="#CC3300")
lines(tab$Time_h, g10001mean, col="#CC3300")
arrows(tab$Time_h, g10001.dn, tab$Time_h, g10001.up, code=0, angle=90, 
       col="#CC3300", cex=0.8)

points(tab$Time_h, g10002mean, pch=20, cex=0.8, col="#FF3300")
lines(tab$Time_h, g10002mean, col="#FF3300")
arrows(tab$Time_h, g10002.dn, tab$Time_h, g10002.up, code=0, angle=90, 
       col="#FF3300", cex=0.8)

points(tab$Time_h, g10003mean, pch=20, cex=0.8, col="#FF9900")
lines(tab$Time_h, g10003mean, col="#FF9900")
arrows(tab$Time_h, g10003.dn, tab$Time_h, g10003.up, code=0, angle=90, 
       col="#FF9900", cex=0.8)

#example for strain g01 - replicates g01_YPD1, g01_YPD2, g01_YPD3
#1st we calculated mean of the 3 values for each row or each Time_h value
#Similarly we calculated SD for 3 values in each row
#Then we established the upper bound and lower bound growth values by mean+/-SD
#Each point in the plot represents mean of the 3 replicates for each Time_h
#We add the plot for every strain in different color
#Vertical bars are error bars or standard deviation as the vertical line above
#the point represents deviation towards the upper-bound value and the vertical 
#line below represents deviation towards the lower-bound value
#Small SD (short bar) - Replicates are tightly clustered (high precision)
#Large SD (tall bar) - Replicates are variable (less precision)
#No overlap between strains - Suggests differences may be significant
#Overlapping bars - Differences might be due to variability
#Example
#g01mean = 0.35, g01sd = 0.02 → error bar: 0.33 to 0.37
#g02mean = 0.36, g02sd = 0.03 → error bar: 0.33 to 0.39
#Error bar ranges: g01: [0.33, 0.37]; g02: [0.33, 0.39]
#g01 range is within g02 range, so SD bar will overlap
#If the error bars overlap, it suggests that:
#The difference in means (e.g. 0.35 vs 0.36) might just be due to 
#natural variation in the replicates (i.e., noise).
#We cannot confidently say that one strain grew better than the other 
#just based on visual difference.
#In contrast, if error bars do not overlap, that often (but not always) suggests:
#The difference is larger than random variation, 
#so it might be statistically significant.

dev.copy2pdf(file="GrowthCurve_G_YPD.pdf", width=12, height=6, useDingbats=F)
dev.off()



