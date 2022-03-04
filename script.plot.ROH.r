genotypeFilePath <- "./SNPpruned2ROH.ped"
mapFilePath <- "./SNPpruned2ROH.map"

dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths(Sys.getenv("R_LIBS_USER"))


install.packages("detectRUNS",repos = "http://cran.us.r-project.org")

##Runs of homozygosity were identified for each animal separately and reduced panel and for comparative purposes only.
library(ggplot2)
library(detectRUNS)

roh_plink <- slidingRUNS.run(genotypeFile = genotypeFilePath, mapFile = mapFilePath
    , windowSize = 15, threshold = 0.05, minSNP = 20, ROHet = FALSE
    , maxOppWindow = 1, maxMissWindow = 1, maxGap = 10^6
    , minLengthBps = 250000, minDensity = 1/10^3 # SNP/kbps
    , maxOppRun = NULL, maxMissRun = NULL)


#FROH#program = "detectRUNS"
inbreeding_roh_plink<-Froh_inbreeding(roh_plink, mapFilePath, genome_wide = TRUE)


#####pLOTS
tiff("plot_FROH.tiff",height = 11, width = 17, units = 'cm', compression = "lzw",res = 600)
plot_InbreedingChr(runs = roh_plink, mapFile = mapFilePath, style="All") #boxplot Froh per breed, with style= All hace plot por cromosoma y por grupo
dev.off()


pdf("plot_StackedRuns.pdf")
plot_StackedRuns(roh_plink)
dev.off()

tiff("plot_PatternRuns.tiff",height = 11, width = 17, units = 'cm', compression = "lzw",res = 600)

plot_PatternRuns(roh_plink, mapFilePath, method = c("sum", "mean"),
                 outputName = NULL, savePlots = FALSE, plotTitle = NULL)
dev.off()

tiff("plot_manhattanRuns.tiff",height = 11, width = 17, units = 'cm', compression = "lzw",res = 600)
plot_manhattanRuns(roh_plink, genotypeFilePath, mapFilePath, savePlots = TRUE, plotTitle = NULL)   #per population#
dev.off()          

pdf("plot_SnpsInRuns.pdf",15,8)
plot_SnpsInRuns(runs = roh_plink, genotypeFile = genotypeFilePath, mapFile = mapFilePath,savePlots = F) + 
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
panel.background = element_blank(),
legend.key=element_blank(),
legend.background=element_blank(),
axis.line = element_line(colour = "black")) +
theme(legend.background=element_blank())

dev.off()



