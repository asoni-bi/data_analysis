#Box plot
data=read.table("Filtered_MERGED_DATA_Yeast.txt", header=T)
View(data)

noTATAbox=data[which(data$TATAbox==0),]
yesTATAbox=data[which(data$TATAbox==1),]
View(noTATAbox)

boxplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD)
#Remove '1' and '2' from x and y label
boxplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD, xaxt="n")
boxplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD, xaxt="n", cex.axis=1.2, 
        ylab="Expression noise in YPD", xlab="TATAbox versions", cex.lab=1.2,
        col=c(rgb(0.5,0,0,0.5), rgb(0,0,0.5,0.5)))
# Now add custom x-axis only once (running this again will add labels on top)
#here, these labels behaves as ticks(or numbers in other plots on x axis) and
#therefore their size is controlled by cex.axis
axis(side=1, label=c("NoTATAbox", "YesTATAbox"), at=c(1,2), cex.axis=0.8)

#outline=F removes points beyond the IQ or interquartile range
boxplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD, xaxt="n", cex.axis=1.2, 
        ylab="Expression noise in YPD", xlab="TATAbox versions", cex.lab=1.2,
        col=c(rgb(0.5,0,0,0.5), rgb(0,0,0.5,0.5)), outline=F)
#adding ylim
boxplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD, xaxt="n", cex.axis=1.2, 
        ylab="Expression noise in YPD", xlab="TATAbox versions", cex.lab=1.2,
        col=c(rgb(0.5,0,0,0.5), rgb(0,0,0.5,0.5)), outline=F, ylim=c(-8, 40))
axis(side=1, label=c("NoTATAbox", "YesTATAbox"), at=c(1,2), cex.axis=0.8)
#adding data points on top
stripchart(noTATAbox$DM_YPD, vertical=T, method="jitter", add=T, at=1, 
           col=rgb(0.5,0,0,0.1), pch=20)
stripchart(noTATAbox$DM_YPD, vertical=T, method="jitter", add=T, at=2, 
           col=rgb(0,0,0.5,0.1), pch=20)



