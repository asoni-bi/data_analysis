#Bioconductor packages

if(!require("BiocManager", quietly=TRUE))
  install.packages("BiocManager")

BiocManager::install("biomaRt")
BiocManager::install("GO.db")
library(biomaRt)
library(GO.db)
data=read.table("Processed_GSM4200292_Dropseq.LymphGland.Normal.72hAEL.lib1.UMIcount.txt", header=T)
#this data set is derived from ncbi GEO using the id GSM4200292

go.map=read.table("GO_mapping.txt", sep="\t", header=T)

#changing dataframe 'data' to a matrix to ensure all values are numeric
#allows the use of functions like matrix algebra
#data[, 1], you get a data frame column
#cd[, 1], you get a numeric vector
cd=data.matrix(data)
cd[1:10, 1:10] 
#row names are gene names and col names are sample names(these 
#samples have the gene expression count data)

#BIOMART
ensembl <- useMart("ENSEMBL_MART_ENSEMBL", dataset="dmelanogaster_gene_ensembl", 
                   host="https://may2024.archive.ensembl.org")
listAttributes(ensembl)[1:10,]

go <- getBM(attributes=c("ensembl_gene_id", "go_id"), filters="ensembl_gene_id",
            values=rownames(cd), mart=ensembl)

library(GO.db)
# Adding the GO-term to the dataframe from GO.db
go$term <- Term(go$go_id)
head(go$term)
head(go)

#Here we are splitting the gene ids and grouping them by term
#(some gene ids have the same term)
go.env <- split(go$ensembl_gene_id, paste(go$go_id,go$term))
head(go.env)

#here we are creating another dataframe 'maplist' which adds only those
#GOids from go.map for which columns 'class' has value 'BP'
#There are 3 types of classes usually BP=Biological Processes
head(go.map)
maplist <- go.map$GOid[which(go.map$Class=='BP')]
head(maplist)
summary(maplist)

#### 

## Creating a GO data.frame file

library(GO.db)
#GOTERM is an environment (a kind of named lookup table) that maps GO IDs 
#(like "GO:0006915") to detailed GO term objects
xx <- as.list(GOTERM)
head(xx)
nn = length(xx)
nn
#Create empty matrix with NA values(matrix because we don't want anything in it yet)
output <- matrix(ncol=3, nrow=nn)
head(output)
#Fill the matrix
#xx[[i]] returns the element (xx[i] will return the element as a list)
#We want the absolute GOID, Term, and Ontology from the 1st record ith record in GOTERM
for(i in 1:nn){
  a=GOID(xx[[i]])
  b=Term(xx[[i]])
  c=Ontology(xx[[i]])
  output[i,] <- c(a,b,c) #adding the 3 values in the 1st row of output matrix
}
head(output)
#changing matrix to dataframe
output <- data.frame(output)
head(output)

#we can now add column names
colnames(output)=c("GOid", "Description", "Class")
head(output)

#save the output in a file
#quote=F is to exclude ", row.names=F to exclude row numbers, separator is tab
write.table(output, "GO_mapping_output.txt", quote=F, row.names=F, sep="\t")
