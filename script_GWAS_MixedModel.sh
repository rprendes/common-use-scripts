
# GWAS with Linear Mixed Models (GWAS) GEMMA https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3386377/ and plot in R


# Input files from plink 

file.bed # binary genotypes 
file.bim # geno info
file.fam # family and phenotype information. After the last column you can include 0 or 1 for binary traits or quatitative traits

## download and install gemma executable from https://github.com/genetics-statistics/GEMMA/releases

## 1- calculate relationship matrix from SNPs 
gemma -bfile file -gk 1 -o file_K_matrix # -gk:  type of kinship/relatedness matrix to generate (default 1; valid value 1-2; 1: centered matrix; 2: standardized matrix.

# results will be in out/ folder

## 2 - run gwas 
gemma -bfile file -k  output/file_K_matrix.cXX.txt -lmm 4 -o out_file


## 3- Manhattan plotplot in R
cd out/
# from the .assoc.txt file use only chr,rs, ps and p_lrt

# in R with qqman package

library(qqman)
library(data.table)

a <- fread("out_file.assoc.txt",select = c("chr", "rs", "ps","p_lrt"),data.table = F)

# Make the Manhattan plot on the gwasResults dataset
pdf("manhatan.pdf")
manhattan(gwasResults, chr="chr", bp="ps", snp="rs", p="p_lrt" )
dev.off()
