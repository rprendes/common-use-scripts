## Gonzalez-Prendes R 2021
##Plot means differences by selected SNPs in ggplot 

library(lsmeans)
library(ggpubr)

d <- read.table("snps.raw",header=T)
s<-read.table("lipidtraits1.txt",head=T)
snps_phen<-read.table("snpsPhen.txt",head=F)
## keep commun ids in two files 
s<-s[s[,"IID"] %in% d[,"IID"],]
d<-d[d[,"IID"] %in% s[,"IID"],]
## check order
all(d[,"IID"] == s[,"IID"])

## merge by ids
merged<-merge(d,s,by="IID")

## list of snps nad phen 
snps<-c(
"rs331967252_A",
"rs341517389_C",
"rs321511384_A",
"rs325796313_A",
"rs328825271_A")

phen<-c("ldl_45_dias",
"Ldl_190_diaslog",
"Col_45_diaslog",
"Col_190_diaslog",
"Hdl_45_diaslog",
"Hdl_190_diaslog",
"Trig_45_diaslog",
"Trig_190_diaslog")
snps_phen<-c()
for (i in snps) {
for (e in phen) {
tmp<-c(paste(i),paste(e))
snps_phen<-rbind(snps_phen,tmp)
}
}
snps_phen<-as.data.frame(snps_phen)

#for (i in 1:dim(snps_phen)[1]){
### calculate means 
#typing.lm = lm(snps_phen[i,2] ~ snps_phen[i,1], data = merged)
#power_response_lm_model = lm(Response~Power,data=Data)
#lsmeans(typing.lm ,snps_phen[i,2])
#}

dim(snps_phen)
merged<-na.omit(merged)

for (i in 1:dim(snps_phen)[1]){
print(snps_phen[i,2])
pdf(paste("plot",snps_phen[i,1],snps_phen[i,2],".pdf",sep="_"))
print(ggboxplot(merged, x = snps_phen[i,1], y = snps_phen[i,2],
          color = snps_phen[i,1], palette = "jco",
          add = "jitter") +
          stat_compare_means())
dev.off()
}

