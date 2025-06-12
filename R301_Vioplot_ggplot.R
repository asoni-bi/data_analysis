#VIOLIN plot or Vioplot, ggplot2
#Boxplot shows dense data points. Vioplot helps is visualizing data points clearly 
data = read.table("Filtered_MERGED_DATA_Yeast.txt", header=T)
#Get all rows(all values) in which TATAbox=0 in noTATAbox
noTATAbox=data[which(data$TATAbox==0), ]
yesTATAbox=data[which(data$TATAbox==1), ]

install.packages("vioplot")
library(violplot)

vioplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD)
vioplot(noTATAbox$DM_YPD, yesTATAbox$DM_YPD, 
        col=c(rgb(0.5,0,0,0.3), rgb(0,0,0.5,0.3)), 
        names=c("noTATAbox", "yesTATAbox"), cex.axis=1,
        main="Expression noise comparison", cex.main=1.4)
legend("topleft", fill=c(rgb(0.5,0,0,0.3), rgb(0,0,0.5,0.3)), 
       legend=c("No TATAbox", "TATAbox"))

dev.copy2pdf(file="ViolinPlot_noise_TATAbox.pdf", useDingbats=F)
dev.off()

#GGPLOT
gg_data = read.table("H2O2_Evol.txt", header=T)
View(gg_data)

library(ggplot2)
library(tidyr)
library(dplyr)

#reshaping a data frame (gg_data) from wide format to long format
#-Round: keep Round fixed (do not gather it — treat it as an identifier)
df <- gg_data %>% select(Round, A1, A2, A3, N1, N2, N3) %>% 
  gather(key="variable", value="value", -Round)

View(df)
#'value' and 'Round' are x and y labels and should be the same as col names
ggplot(df, aes(x=Round, y=value))
a = ggplot(df, aes(x=Round, y=value))
#geom_point will add points, geom line is connecting the points
#with geom_line(aes(color=variable), any color is added to the 6 lines
#with scale_color_manual, we specify the color for each
#theme_minimal remove grey background
a + geom_point(size=2, aes(color=variable)) + 
  geom_line(aes(color=variable), linewidth=1) +
  scale_color_manual(values=c("#000066","#3333FF","#3399FF","#CC3300","#FF3300","#FF9900")) +
  theme_minimal() + 
  scale_y_continuous(limits=c(0, 180), breaks=seq(0, 180, 15)) +
  scale_x_continuous(limits=c(0, 10), breaks=seq(0, 10, 1))

dev.copy2pdf(file="ggplot_example_H2O2_evol.pdf", useDingbats=F)
dev.off()
