## Code for plot LD block length distribution## 
## using plink and R

input=file2use

plink --bfile $input --blocks --blocks-max-kb 1000 --no-pheno-req --out LD_BLOCK

####This produces LD_BLOCK.blocks.det. Then some R.

dfr <- read.delim("LD_BLOCK.blocks.det",sep="",header=T,check.names=F,stringsAsFactors=F)
colnames(dfr) <- tolower(colnames(dfr))

library(ggplot2)
# ld block density
pdf("ld_block_density.pdf")
ggplot(dfr,aes(x=kb))+
  geom_density(size=0.5,colour="red")+
  labs(x="LD block length (Kb)",y="Density")+
  theme(
  # Hide panel borders and remove grid lines
  panel.border = element_blank(),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  # Change axis line
  axis.line = element_line(colour = "blue")
  )
dev.off()

