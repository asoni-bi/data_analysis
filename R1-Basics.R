# installing R packages
install.packages("ggplot2")

# installing packages from Bioconductor
if(!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GenomeInfoDb")
BiocManager::install("DESeq2")
# Basic functions
getwd() # working directory
setwd("../DataAnalysis_in_R")

variable <- 3
ls() # lists all variables
rm(variable) 
ls()

# Arithmetic operators
a <- 2 + 3
a
a<- 2 * 3
a
a <- 10^3
a
c <- 5%%2
c
c <- 5%/%2
c

# Mathematical functions (log, exp, max, min, median, var, sd, IQR, sum, round)
max(2,3,4)

data=c(5, 10, 20, 30)
mean(data) #mean(5, 10, 20, 30) is incorrect, need to pass data structure

sd(data)

round(1.00276, 2)
round(1.01276, 2)

# Relational operators
a <- 3
b <- 4
# gives TRUE or FALSE
a == b
a != b
a > b
a < b

# logical operators &, &&, |, ||

# Basic Programming: if-else, for, while
x1 = 3
x4 = 5
if(x1>2 && x4<10) {
  val = x4^x1
  print(val)
}

for(i in 1:10) {
  print(10^i)
}

i=1
while(i<10) {
  val = log(i)
  print(val)
  i=i+1
}

# function
squared=function(x) {
  val = x^2
  print(val)
}

squared(10)

# Statistical functions:
# rdpq(random, probability density, cumulative probability, quantile)]
# binomial distribution: rbinom, dbinom, pbinom, qbinom
# poisson distribution: rpois, dpois, ppois, qpois
# normal distribution: rnorm, dnorm, pnorm, qnorm
# uniform distribution: runif, dunif, punif, qunif

# generating standard normal distribution of 1000 values
val <- rnorm(n=1000, mean=0, sd=1)
head(val, 10)
tail(val, 10)
# How to visualize whether this actually is a normal distribution?(graph)
hist(val)
# close the graph
dev.off()

# to check the body of function, just type it
dnorm
rnorm

dnorm_val <- dnorm(1, mean=0, sd=1)

rnorm_val <- rnorm(10, mean = 10, sd = 2)
rnorm_val
hist(rnorm_val)

# probability that a normally distributed random variable is 
# less than or equal to a specific value
pnorm(8, mean=10, sd=1)
pnorm(10, mean=10, sd=1)

# to get the probability of a value being above the specified threshold
# lower.tail (lower represents left, 
# tails represent cumulative probability)
# so lower.tail represents cumulative probability on the left side of the curve
# by default lower.tail = T which means 
# probability of a random variable in normal distribution
# being on the left of given threshold is calculated
pnorm(8, mean=10, sd=1, lower.tail = F)
pnorm(10, mean=10, sd=1, lower.tail = F)
pnorm(12, mean=10, sd=1, lower.tail = F)

# Returns the value (quantile) at which 
# 95% of the normal distribution lies below it
# qnorm is reverse of pnorm
# pnorm takes a threshold value and gives probability whereas 
# qnorm takes probability and gives the threshold value
qnorm(0.95, mean = 0, sd = 1)
qnorm(0.05, mean = 0, sd = 1)

# these functions for other distributions--Binomial, poisson, uniform
# such as qbinom, qpois etc have different parameters
qbinom
pbinom

# Gives the probability that a player will make 7 or fewer baskets
# out of 10 shots 
pbinom(7, size = 10, prob = 0.5)
# This gives 0.94 which means 
# the player will make 7 or fewer baskets in 94% of the games

# Gives the threshold number of baskets which the player will make
# in 90% of the games
qbinom(0.9, size = 10, prob = 0.5)

# Testing all these functions
# random in all distributions
rnorm(5, mean=170, sd=1)
rbinom(3, size=10, prob=0.5)
rpois(6, lambda = 5)
runif(6, min=2, max=200)

#Data types: Numeric, Character/String, Logical, Factors
#Data Structures: Vectors, Lists, Matrices, Data frames
vector1 <- c(1,2,6,8,4,9)
vector2 <- c("a", "f", "h", "j", "n")
vector3 <- c(1:7)
vector4 <- seq(1,5, by=0.4)
vector5 <- rep(c(7,4,2), times=3)
vector6 <- rep(c(4,7,6), each=4)

#Accessing vector elements
vector1[2]
vector1[-3] #returns all except 3rd
vector1[3:6] #3: will give error, 3:7 will give NA as last element
vector1[-(3:6)] #all except 3 to 6
vector1[c(2,5,6)]
vector1[-c(2,5)] #all except 2nd and 5th
vector1[vector1==8]
vector1[vector1>2]
vector1[vector1 %in% c(1,6,9)]
vector2[vector2 %in% c("h", "n")]

#Vector Functions
length(vector1)
sort(vector1)
rev(vector1)
unique(vector5)
vector3[2]=0
vector3[length(vector3)+1] = 10
append(vector3, 11)

# lists (multiple data types)
list1 <- list(c(1:3), c("Apple","Strawberries","Kiwi"))
list1[1]
list1[[1]]
# to access an element from a vector in the list
# to access "kiwi"
list1[[2]][3]
# This can be used to assign or reassign values too
list1[[2]][3] = "Orange"
list1
list1[[2]][4] = "Cherries"
list1

# Matrix (2D array to store data)
M <- matrix(4, nrow=2, ncol=3, byrow=TRUE)
M <- matrix(4:9, nrow=2, ncol=3, byrow=TRUE)
M <- matrix(4:9, nrow=2, ncol=3, byrow=FALSE)
M <- matrix(c(4,7,8,0,3,6), nrow=2, ncol=3, byrow=TRUE)
rownames(M) <- c("gene1", "gene2")
colnames(M) <- c("sample1", "sample2", "sample3")

# OR give row and col names while creating matrix
m <- matrix(1:9, nrow = 3, ncol = 3,
            dimnames = list(c("Gene1", "Gene2", "Gene3"),
                            c("Sample1", "Sample2", "Sample3")))
dim(m)  #To get the matrix size
# Accessing Matrix elements 
M[2,3]
M["gene1", "sample2"]
m["Gene2",]
m[,"Sample3"]
m[c(1,3), c(1,2)] #multiple rows (row1&3) & cols (cols1&2)

# Diagonal matrix (rest of the elements will be 0)
dm <- diag(c(3,4,6,8), nrow=4, ncol=4)
dm

# Identity matrix
im <- diag(6, nrow=4, ncol=4)
im

# Transposing matrix: rows becomes columns and vice versa
tm <- t(m)
tm

# Matrix multiplication
M_cross_m <- M %*% m
M_cross_m

m %*% M #Error in m %*% M : non-conformable arguments
# ncol of 1st matrix should be equal to nrow of 2nd matrix
# M is 2x3 and m is 3x3, so (M x m) will work but not (m x M)
# M(2x3) x m(3x3) will give a matrix of size 2x3
# matrix1(4x3) x matrix2(3x6)will give a matrix of size 4x6
# https://www.youtube.com/watch?v=2spTnAiQg4M

# DATA FRAMES(tabular data): most imp data structure
df <- data.frame(fruit=c("apple","cherry","mango","orange","plum","pome",
                         "banana","melon", "cantaloupe", "lime", "avo" ), 
                 price=c(3,2,4,1,7,1,5,7,0,3,6))
df
dim(df)
rownames(df)
colnames(df)
ncol(df)
nrow(df)
df[,2]
df[3,]
df[2, 2]
df$fruit
show(df)
head(df) # top 6 values
tail(df) # bottom 6 values
newrow=c("pear", 4) #running this again will add the same row again
rbind(df, newrow) # doesn't make changes to df, 
# to add the row permanently, assign the function to df
df <- rbind(df, newrow)
newcol= data.frame(weight=rep(c(2,5,4,3), times=3))
cbind(df, newcol)
df <- cbind(df, newcol)
df1 <- data.frame(val1=c(9,10,2), val2=c(3,6,11))
rownames(df1)
rownames(df1) <- colnames(df)
rownames(df1)

# READING WRITING files







