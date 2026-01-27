### pophelper to analyse STRUCTURE results

#for mac users also need to install openssl
install.packages("openssl")

# install dependencies
install.packages(c("ggplot2","gridExtra","label.switching","tidyr","remotes"),repos="https://cloud.r-project.org")

# install pophelper package from GitHub
remotes::install_github('royfrancis/pophelper')


library(pophelper)
library(ggplot2)
library(gridExtra)
setwd("~/Documents/R_folder/SNP_NLR_extraction/bcftools_call")

#listing all the results file sin a vector and then converting to Qfile for pophelper
sfiles<-list.files(path = "results_10runs_STRUCTURE_SNP_NLR_extraction_MISS50_Musa_acuminata_pahang_v4",full.names = T)
slist<-readQ(files=sfiles,indlabfromfile=T)
class(slist) 
head(slist[[1]])
attributes(slist)
attributes(slist[[1]])
names(attributes(slist[[1]]))

#tabulateQ: takes a ‘qlist’ and produces a table of runs with various parameters. 
# To write results to working directory, set writetable=TRUE and exportpath="."
tlist <- tabulateQ(qlist=slist, writetable = T, exportpath = getwd())

#summariseQ: table from tabulateQ()collapsed by K based on the number of runs. 
sr1 <- summariseQ(tlist, writetable = T, exportpath = getwd())

#evannoMethodStrucutre: estimate the optimal number of K,input summariseQ table
opt_K<-evannoMethodStructure(data=sr1,exportplot = T, returnplot = T, writetable = T,na.rm = T, exportpath = getwd(), basesize = 5,linesize = 0.5)
#grid.arrange(opt_K) ##Error in grid.arrange(opt_K) : could not find function "grid.arrange"
grid.arrange(opt_K)


##### Align clusters across replicates for the chosen K population
setwd("~/Documents/R_folder/SNP_NLR_extraction/bcftools_call/results_10runs_STRUCTURE_SNP_NLR_extraction_MISS50_Musa_acuminata_pahang_v4")

#listing all the results file sin a vector and then converting to Qfile for pophelper
files_6<-list.files(pattern = "^K6_.*_f$")
slist_6 <- readQ(files = files_6)
# indlab(slist_6[[1]])
slist_aligned_6 <- alignK(slist_6)
for(i in seq_along(slist_aligned_6)) {
  fname <- paste0("K6_aligned_run", i, ".csv")
  write.csv(slist_aligned_6[[i]], fname, row.names = FALSE)
}

## new version to calcualte the average q
install.packages("devtools")
devtools::install_github("royfrancis/pophelper", force = TRUE)


## plot K=6 ONLY
library(reshape) 
library(dplyr)
library(tidyr)
library(lattice)
library(gridExtra)
library(grid)

K6<- read.csv("Average_Q_6.csv",header=TRUE)
K6<- read.csv("Average_Q_6_7col.csv",header=TRUE)

K6$Label <- factor(K6$Label, levels = K6$Label)
pcaPalette <- c("lightblue","royalblue","darkorchid","forestgreen","darkred","darkorange","hotpink","plum1")
K6rg <- gather(K6,key,value,-Label,-pops)

#plot pop proportion
cog<-ggplot(data=K6rg, aes(x=Label, y=value, fill=key)) +
  geom_bar(stat="identity")
cog3 <- cog +theme(axis.text.x=element_text(angle = 55, hjust = 1, size=3))+ylab ("Genotype") + scale_y_continuous(expand = c(0,0)) 
cog4 <- cog3 + scale_fill_manual(values=pcaPalette)

pdf(file = "plot_SNP_NLT_aa_K6.pdf",width=10,height=4)
cog4
dev.off()

#