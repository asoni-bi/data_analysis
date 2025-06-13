#dplyr (from tidyverse)
library(dplyr)

noisedata=read.table("Filtered_MERGED_DATA_Yeast.txt", header=T)
ncol(noisedata)
nrow(noisedata)
noisedata[1:10, 1:10]
View(noisedata)

#MUTATE
newdata=noisedata %>% mutate(fracExpSD=AVGEXP_SD/AVGEXP_YPD, .keep="all")
tail(colnames(newdata)) #fracExpSD is added as the last col

newdata_2=noisedata %>% mutate(fracExpSD=AVGEXP_SD/AVGEXP_YPD, .keep="none")
colnames(newdata_2) #keeps only the new col

#RENAME
newdata=noisedata %>% rename(MeanExpSD=AVGEXP_SD)
newdata[1:5, 1:5]

#SELECT
new_table=noisedata %>% select(AVGEXP_YPD, DM_YPD, Gene)
head(new_table)

new_table=noisedata %>% select(AVGEXP_YPD:DM_SD)
head(new_table)

new_table=noisedata %>% select(!STRE_elem)
noisedata[1:8, 1:8] #STRE_elem col is present
new_table[1:8, 1:8] #STRE_elem col is not present

#RELOCATE

new_table=noisedata %>% relocate(DM_YPD_CLASS, .after=last_col())
tail(colnames(new_table))

#FILTER
new_table=noisedata %>% filter(DM_YPD > 1)
View(new_table[1:20, 1:20])
dim(noisedata)
dim(new_table)

new_table=noisedata %>% filter(DM_YPD > 1 & AVGEXP_YPD > 100)
new_table[1:5, 1:5]
dim(noisedata)
dim(new_table)

#DISTINCT (unique values in col Num_RegTF_YeastractYT)
View(noisedata %>% distinct(Num_RegTF_YeastractYT))

#SLICE (on rows)
new_table=noisedata %>% slice(10:15) #6 rows
dim(new_table)

new_table = noisedata[10:15, ]
dim(new_table)

#both the above do the same but slice is better and clearer to use 
#if you are working with tidyverse

#gives top 100 rows
new_table = noisedata %>% slice_head(n=100)
dim(new_table)

#SUMMARISE
#statistical functions used with summarise - sum(), min(), max(), 
#n() - count of rows, sd(), median(), mean(), first(), last()
noisedata %>% summarise(avg = mean(DM_SD)) #gives NA as avg
noisedata %>% summarise(avg = mean(na.omit(DM_SD)))

#Note: summary() is a base function in R which returns:
#Min, 1st Qu, Mean, Median, 3rd Qu, Max from a data frame

#COUNT
noisedata %>% count(Num_RegTF_YeastractYT) %>% 
  slice_head(n=5)
#from the data, we can see that there are 33 genes which have 0 transcription factors
# 1 gene with 2 TFs, 3 genes with 6 TFs and so on

#ARRANGE (arranges in ascending order)
new_table = noisedata %>% arrange(Num_RegTF_YeastractYT)
head(new_table$Num_RegTF_YeastractYT)
tail(new_table$Num_RegTF_YeastractYT) #shows ascending arrangement

new_table = noisedata %>% arrange(desc(Num_RegTF_YeastractYT))
tail(new_table$Num_RegTF_YeastractYT)
head(new_table$Num_RegTF_YeastractYT) #shows descending arrangement

#GROUP BY
results = noisedata %>% group_by(Num_RegTF_YeastractYT) %>%
  summarise(avg = mean(AVGEXP_YPD))
results

print(results, n=100)

#Testing if there is any correlation between 
#grouped Num_RegTF_YeastractYT and avg which is the mean(AVGEXP_YPD)
cor.test(results$Num_RegTF_YeastractYT, results$avg) #no correlation



