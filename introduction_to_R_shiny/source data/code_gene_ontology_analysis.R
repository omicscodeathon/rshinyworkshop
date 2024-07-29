library(clusterProfiler)
library(enrichplot)
library(org.Hs.eg.db)

# read data
expression <- read.csv("source data/expression-data.csv")
# define filter parameter
deg_pval <- 0.05 # max p value to define DEGs
deg_logFC <- 2 # min log fc value 
expression$diffexpressed <- "Not Significant"
expression$diffexpressed[expression$log2FoldChange  > deg_logFC  & expression$pvalue < deg_pval ] <- "Upregulated genes"
expression$diffexpressed[expression$log2FoldChange  < -deg_logFC & expression$pvalue < deg_pval] <- "Downregulated genes"


DEGs <- as.data.frame(expression[expression$diffexpressed != "Not Significant",])


ontology <- enrichGO(gene = DEGs$gene, OrgDb="org.Hs.eg.db", keyType="SYMBOL", ont='ALL')


# bar plot
barplot(ontology, showCategory=10)

# Dotplot
dotplot(ontology, showCategory=10)