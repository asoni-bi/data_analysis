#ggscatter, tidyr

tab = read.table("Formatted_Filtered_data_multiboxplot_ggplot2_updated.txt", header=T)
names(tab)

library(ggplot2)
install.packages("ggpubr")
library(ggpubr)

theme_set(
  theme_minimal()
)

my_Theme = theme(
  axis.title.x = element_text(size=16),
  axis.text.x = element_text(size=12),
  axis.text.y = element_text(size=12),
  axis.title.y = element_text(size=16),
  legend.title = element_text(size = 16)
)

no_natab=tab[which(is.na(tab$tAI_full.1)=="FALSE" & is.na(tab$real_protein_synthesis_per_mrna.1)=="FALSE"),]

dim(tab)
dim(no_natab)

# tRNA Adaptation Index (tAI) → a measure of how well a gene’s codons match 
# the tRNA pool of the organism (how efficiently it can be translated)
# Protein synthesis rate per mRNA → how much protein is 
# actually produced per mRNA transcript
# positive correlation -> Genes with higher tAI values (more optimal codons) 
# tend to have higher protein synthesis rates
# Suggests that tRNA availability and codon usage directly affect translation efficiency
# conf.int is confidence interval
# Suppose you're estimating the mean protein synthesis rate for a gene. 
# If the sample mean is 0.5, a 95% CI might be [0.45, 0.55]
# A 95% confidence interval means:
# If we repeated the experiment 100 times, 
# about 95 of those intervals would contain the true value we're trying to estimate.”
# CI is the shared area around the regression line
# Narrow CI → More precise estimate of the trend.
# Wide CI → Greater uncertainty.
# CI crossing horizontal axis → Possibly no significant trend.
ggscatter(no_natab, 
          x="tAI_full.1", 
          y="real_protein_synthesis_per_mrna.1",
          add="reg.line", 
          conf.int=TRUE, 
          col=rgb(0.4,0.4,0.4,0.5),
          add.params=list(fill="lightblue"),
          ggtheme=theme_minimal()
          ) +
  stat_cor(method="pearson") + 
  my_Theme + 
  ylim(0,1) + 
  labs(x="tRNA Adaptation Index(tAI)", 
       y="Protein synthesis rate per mRNA")

dev.copy2pdf(file="Cor_ProtSyn_permRNA_tAIfull.pdf", useDingbats=F)
dev.off()

# TIDYR
library(tidyr)
data <- tibble(sample=c('Sample1', 'Sample2'), 
               geneA_iso1=c(54, 32), geneA_iso2=c(63, 55), 
               geneB=c(14, 20))
df <- as.data.frame(data)
data
df
#Refer to notes(R3-plots_Bioconductor) for tibble vs df, and factors
uniteddf=unite(df, geneA_iso1, geneA_iso2, col="geneA", sep="/")
uniteddf

df_renewed=separate(uniteddf, geneA, sep="/", into=c("geneA_iso1", "geneA_iso2"))
df_renewed

longer_df=separate_longer_delim(uniteddf, geneA, delim="/")
longer_df

pivoted_df=pivot_longer(df, cols=2:3, names_to="geneA_isoforms", values_to="value")
pivoted_df

backtooriginal_df=pivot_wider(pivoted_df, names_from="geneA_isoforms", values_from="value")
backtooriginal_df


data_with_na <- tibble(sample=c('Sample1', 'Sample2', 'Sample3'), 
                               geneA_iso1=c(54, NA, 34), geneA_iso2=c(63, 55, 40), 
                               geneB=c(14, 12, NA))
data_with_na
drop_na(data_with_na, geneA_iso1)
drop_na(data_with_na)

#for geneA_iso1, we are replacing NAs by mean of the non-NA values, and for geneB, 
#we are replacing NAs by 0
replace_na(data_with_na, list(geneA_iso1=mean(na.omit(data_with_na$geneA_iso1)), geneB=0))

