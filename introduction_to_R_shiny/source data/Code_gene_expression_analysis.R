#
library(readr)
library(dplyr)
library(ggplot2)

# import data
expression <- read.csv("source data/expression.csv")

# define filter parameter
deg_pval <- 0.05 # max p value to define DEGs
deg_logFC <- 2 # min log fc value 

# gene expression analysis 
expression$diffexpressed <- "Not Significant"
expression$diffexpressed[expression$log2FoldChange  > deg_logFC  & expression$pvalue < deg_pval ] <- "Upregulated genes"
expression$diffexpressed[expression$log2FoldChange  < -deg_logFC & expression$pvalue < deg_pval] <- "Downregulated genes"

# Visualize the results as a volcano plot
ggplot(data=expression, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) +
  geom_point() + theme_minimal() + theme(text = element_text(size = 15))
