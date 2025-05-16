#Correlation Analysis

drug_concentration=c(5,10,15,20,25,30,35)
drug_efficacy = c(20,24,28,33,36,39,42)
#pch can be 2,4,6,10,12,20
plot(drung_concentration, drug_efficacy, pch=20,cex=2) 
plot(drung_concentration, drug_efficacy, pch=20,cex=1,col='blue')
# This gives high cor=0.995.., which means null hypothesis can be rejected
# and alternative hypothesis is that true correlation is not equal to 0
cor.test(drug_concentration, drug_efficacy, method="spearman")
plot(drug_concentration, drug_efficacy, pch=20,cex=2,col='blue')
plot(drug_concentration, drug_efficacy, pch=20,cex=2,col='blue',
     xlab="Drug Dose", ylab="Efficacy")
plot(drug_concentration, drug_efficacy, pch=20,cex=1.5,col='blue',
     xlab="Drug Dose", ylab="Efficacy", cex.lab=0.8)
plot(drug_concentration, drug_efficacy, pch=20,cex=1.5,col='blue',
     xlab="Drug Dose", ylab="Efficacy", cex.lab=0.8, cex.axis=0.8)
plot(drug_concentration, drug_efficacy, pch=20,cex=1.5,col='blue',
     xlab="Drug Dose", ylab="Efficacy", cex.lab=0.8, cex.axis=0.8,
     main="Efficacy plot for drug xyz", cex.main=1.2)
dev.off() #to close the plot

#Correlation analysis on larger data
data=read.table("Filtered_MERGED_DATA_Yeast.txt", header=T)
head(names(data))
head(data[,1]) #get first 6 gene names

#YPD: Yeast extract Peptone Dextrose medium (yeast growth medium)
#SD: Synthetic Defined medium
#AVGEXP_YPD: Yeast's gene expression levels when in YPD medium
#AVGEXP_SD: Yeast's gene expression levels when in SD medium

cor.test(data$AVGEXP_YPD,data$Prom_H3K9ac_vsH3)
cor.test(data$AVGEXP_YPD,data$Prom_H3K9ac_vsH3, method="spearman")

#Stronger correlation below
#DM_YPD: Change in gene expression under YPD (rich medium)
#DM_SD: Change in gene expression under SD (minimal medium)
#Prom_H3K9ac_vsH3:comparison of histone modification levels 
#at promoter regions in a ChIP-seq experiment
#Prom: Promoter region of a gene
#H3K9ac: Acetylation of lysine 9 on histone H3
#vsH3: Comparison is being made against total H3, 
#which refers to the general abundance of histone H3, 
#used as a normalization control.
#Num_RegTF_YeastractYT:
#Num_RegTF: Number of Regulatory Transcription Factors 
#(counts how many known TFs regulate a particular gene)
#Yeastract: YEASTRACT database( It includes experimental evidence 
#of TF–gene interactions (binding, expression, etc.))
#YT could be: shorthand for a specific type of evidence used in YEASTRACT
#"Yeastract Textmined", "Yeastract Total", or a condition/filter used
cor.test(data$DM_YPD, data$Num_RegTF_YeastractYT)
cortest <- cor.test(data$DM_YPD, data$Num_RegTF_YeastractYT)
cortest$p.value
cortest$statistic
cortest$parameter
cortest$data.name
cortest$estimate 

plot(data$DM_YPD,data$Num_RegTF_YeastractYT,pch=20,col='blue')
plot(data$DM_YPD,data$Num_RegTF_YeastractYT,pch=20,col=rgb(0,0,1,0.3))
plot(data$DM_YPD,data$Num_RegTF_YeastractYT,pch=20,col=rgb(0,0,1,0.6))
plot(data$DM_YPD,data$Num_RegTF_YeastractYT,pch=20,col=rgb(0,0,1,0.3),
    xlab="Expression Hetergeneity", ylab="No. of regulatory TFs", cex.lab=0.7)


