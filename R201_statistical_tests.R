# t.test, Wilcox.test, Paired data, chisq.test
#mutant A (MIC data)
x = c(43,27,33,28,34)
#mutant B (MIC data)
y = c(31,23,22,26,25)

# t-test (parametric)
t.test(x,y)

#Wilcox test (non-parametric)
wilcox.test(x,y)

#Paired tests(example, cancer and healthy sample data) can also be done
#Gives different results
t.test(x,y, paired=T)
wilcox.test(x,y,paired=T)

# Since sample size is small, non-parametric is better

# We can check whether the normality(distribution) assumption is valid
# We need larger dataset to check that
z = c(0,5,6,7,10,15,20,28,30,45)

qqnorm(z)
qqnorm(z,pch=16)
qqline(z,col='blue')
#If the normality distribution holds, most data points will lie around this line

#Working with larger data
data=read.table("Filtered_MERGED_DATA_Yeast.txt", header=T)
names(data) #returns names of all the columns
head(names(data))
t.test(data$AVGEXP_YPD, data$AVGEXP_SD)
t.test(data$AVGEXP_YPD, data$AVGEXP_SD)
wilcox.test(data$AVGEXP_YPD, data$AVGEXP_SD)

#checking normality assumption
qqnorm(data$AVGEXP_YPD)
qqline(data$AVGEXP_YPD, col="blue")
# many data points are not along this blue line
# so we can say it is not normally distributed

#YPD: Yeast extract Peptone Dextrose medium (yeast growth medium)
#SD: Synthetic Defined medium
#AVGEXP_YPD: Yeast's gene expression levels when in YPD medium
#AVGEXP_SD: Yeast's gene expression levels when in SD medium
hist(data$AVGEXP_YPD) #clearly not normal, data is skewed in one direction
hist(data$AVGEXP_YPD, breaks=1000)
hist(data$AVGEXP_YPD, breaks=1000, xlim=c(0,1000))

head(data$AVGEXP_SD)







