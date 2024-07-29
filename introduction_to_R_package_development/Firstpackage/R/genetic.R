#' Title
#'
#' @param path path to file
#'
#' @return
#' @export
#'
#' @examples
genetic <- function(path) {
  library(readr)
  library(dplyr)
  library(ggplot2)

  # import data
  expression <- read.csv(path)

  # define filter parameter
  deg_pval <- 0.05 # max p value to define DEGs
  deg_logFC <- 2 # min logFC value

  # gene expression analysis
  expression$diffexpressed <- "Not Significant"
  expression$diffexpressed[expression$log2FoldChange  > deg_logFC  & expression$pvalue < deg_pval ] <- "Upregulated genes"
  expression$diffexpressed[expression$log2FoldChange  < -deg_logFC & expression$pvalue < deg_pval] <- "Downregulated genes"
  expression
}
