args<-commandArgs(TRUE)



library(ggplot2)
library(RColorBrewer)
#args1 = *eigenvec
#args2 = *.eigenval
#args3 = file with IDS and Breed information


# example  Rscript script.plot.pca.r pca.eigenvec pca.eigenval ids.txt


# read in data
pca <- read.table(args[1], head = FALSE)
eigenval <- read.table(args[2])


# first convert to percentage variance explained
pve <- data.frame(PC = 1:2, pve = eigenval/sum(eigenval)*100)
names(pve)[2]<-"pve"

# sort out the pca data

# set names
names(pca)[2] <- "ind" ## rename second column from pca out
names(pca)[3:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-2))

## add breed id

pca_names <- read.table(args[3],head=T,sep='\t')[c(1,2)] ## only ids and factor to color

names(pca_names)<-c("ind","Breed")

pca<-merge(pca_names,pca,by="ind")
pca<-pca[,-3]
head(pca)
pca$Breed<-as.factor(pca$Breed)
length(unique(pca$Breed))
table(pca$Breed)
write.table(as.data.frame(summary(pca$Breed)),"summary.txt")
print("ok")
# sort out the individual and popoulation 



## color

colourfactors = length(unique(pca$Breed))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

pdf("pca_plot.pdf",12,7)
# plot pca
b <- ggplot(pca, aes(PC1, PC2, col = Breed, shape = Breed)) + geom_point(size = 3) +
scale_shape_manual(values=1:nlevels(pca$Breed))
b <- b + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
panel.background = element_blank(), axis.line = element_line(colour = "black"))
b + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))
dev.off()
