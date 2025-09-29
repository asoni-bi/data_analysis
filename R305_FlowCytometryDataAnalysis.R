#Flow Cytometry data analysis
#Bioconductor Packages: 
#flowCore(allows us access flow cytometry data) and flowViz(to visualize)

#3 Parts: Data Processing, Filtering, Visualization and Analysis

# if(!require("BiocManager", quietly="TRUE"))
#   install.packages("BiocManager")
BiocManager::install("flowCore")
library(flowCore)

#PROCESSING
#T0.Test, T1.Test...are flowFrames not data frames
#flowFrames include:
# 1) Cell-level data (i.e. the measured fluorescence/scatter values)
# 2) Metadata about the experiment (channels, compensation, etc.)
#flowFrames are not easily editable in base R
#So, they are 1st converted to data frames(for clustering, PCA etc)
#flowFrames can't be exported to text directly
#So, to share them, to import in Python or Excel, 
#or to create training or testing datasets, flowFrames are 1st converted to text files
T0.Test=read.FCS("data/R305/20240226_Test_0h_027.fcs")
T1.Test=read.FCS("data/R305/20240226_Test_1h_028.fcs")
T2.Test=read.FCS("data/R305/20240226_Test_2h_029.fcs")
T3.Test=read.FCS("data/R305/20240226_Test_3h_030.fcs")
T4.Test=read.FCS("data/R305/20240226_Test_4h_031.fcs")
T5.Test=read.FCS("data/R305/20240226_Test_5h_032.fcs")

summary(T0.Test)

#write these files to text files so that we don't have to read fcc again
write.table(exprs(T0.Test), "data/R305/Test_t0.txt")
#converting to data frames to analyse with base R
STest.t0=exprs(T0.Test)
head(STest.t0)

#Explanation for why  head(T0.Test) and head(STest.t0) give same output:
#R shows the expression matrix when printing a flowFrame
#T0.Test is a flowFrame object
#It contains:
#exprs(T0.Test) — the numeric matrix (cells × channels)
#parameters(T0.Test) — metadata about the channels
#description(T0.Test) — more metadata
#STest.t0 is just the matrix
#Always extract the expression matrix with exprs() 
#if you want to analyze or manipulate the numeric data directly

#OR we can read the text file and store in the data frame
STest.t0=read.table("data/R305/Test_t0.txt")
head(STest.t0)

STest.t1=exprs(T1.Test)
STest.t2=exprs(T2.Test)
STest.t3=exprs(T3.Test)
STest.t4=exprs(T4.Test)
STest.t5=exprs(T5.Test)

#FILTERING
summary(STest.t5)
#noise could be (examples): 	
#Very small FSC-A and SSC-A = debris
#High autofluorescence, variable scatter = Dead Cells
#FSC-A too high (2× signal) = Doublets or cell aggregates(2 cells passing together), etc

#FSC and SSC should ideally never be negative, 
#since they represent physical scatter — but processing or faulty data can break that

#To filter cell aggregates we use FSC-A/FSC-H or SSC-A/SSC-H data
#Let's use SSC-A/SSC-H as FSC-A/FSC-H has some -ve values

#We need to write the remaining flowFrames to text file 
#and then change to data frame to access FSC or SSC values
write.table(exprs(T1.Test), "data/R305/Test_t1.txt")
write.table(exprs(T2.Test), "data/R305/Test_t2.txt")
write.table(exprs(T3.Test), "data/R305/Test_t3.txt")
write.table(exprs(T4.Test), "data/R305/Test_t4.txt")
write.table(exprs(T5.Test), "data/R305/Test_t5.txt")

STest.t1=read.table("data/R305/Test_t1.txt")
STest.t2=read.table("data/R305/Test_t2.txt")
STest.t3=read.table("data/R305/Test_t3.txt")
STest.t4=read.table("data/R305/Test_t4.txt")
STest.t5=read.table("data/R305/Test_t5.txt")

#Plot the data for filtering
plot(STest.t0$SSC.A, STest.t0$SSC.A/STest.t0$SSC.H)
plot(STest.t0$SSC.A, STest.t0$SSC.A/STest.t0$SSC.H)
plot(STest.t1$SSC.A, STest.t1$SSC.A/STest.t1$SSC.H)
plot(STest.t2$SSC.A, STest.t2$SSC.A/STest.t2$SSC.H)
plot(STest.t3$SSC.A, STest.t3$SSC.A/STest.t3$SSC.H)
plot(STest.t4$SSC.A, STest.t4$SSC.A/STest.t4$SSC.H)
plot(STest.t5$SSC.A, STest.t5$SSC.A/STest.t5$SSC.H)

#Changing plot attributes - colour, xlim etc
plot(STest.t0$SSC.A, STest.t0$SSC.A/STest.t0$SSC.H, xlim=c(0,15000), 
     col=rgb(0,0,0.5,0.05), cex=0.1)
#The points that form dark blue part the cell, 
#and the scattered points above it are cell aggregates
#now, we can draw a horizontal line, lty=2 represents dotted
abline(h=1.5, lty=2, col='red')
#add vertical line
abline(v=500, lty=2, col='red')
#h=1.5(on y axis) and v=500(on x axis), 
#point under which all single cell data(good data) is present




