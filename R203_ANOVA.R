data=read.table("Filtered_MERGED_DATA_Yeast.txt", header = T)
#Below we are defining the ANOVA model
#AVGEXP_YPD is dependent variable and others are independent
model <- aov(data$AVGEXP_YPD ~ data$TATAbox + data$Num_RegTF_YeastractYT)
model
summary.aov(model)