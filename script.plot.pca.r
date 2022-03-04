args<-commandArgs(TRUE)



library(ggplot2)
#args1 = *eigenvec
#args2 = *.eigenval
#args3 = file with IDS and Breed information

# read in data
pca <- read.table(args[1], head = FALSE)
eigenval <- read.table(args[2])


# first convert to percentage variance explained
pve <- data.frame(PC = 1:2, pve = eigenval/sum(eigenval)*100)
names(pve)[2]<-"pve"

# sort out the pca data

# set names
names(pca)[1] <- "ind"
names(pca)[3:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-2))

## add breed id

pca_names <- read.table(args[3],head=F,sep='\t')
names(pca_names)<-c("ind","Breed")

pca<-merge(pca_names,pca,by="ind")
pca<-pca[,-3]


# sort out the individual and popoulation 

# remake data.frame

pdf("pca_plot.pdf")
# plot pca
b <- ggplot(pca, aes(PC1, PC2, col = Breed, shape = Breed)) + geom_point(size = 3)
b <- b + coord_equal() + theme_light()
b + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))
dev.off()
