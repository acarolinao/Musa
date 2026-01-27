setwd("~/Documents/R_folder/SNP_NLR_extraction/bcftools_call/PCA SNP NLR extraction")
install.packages('ggfortify')
install.packages("ggplot2")

library(ggfortify)

###PCA_1 with 201 SNP NLR extracted
AA <-read.csv(file.choose(),h=T)
df<-AA[2:6]

pca_res<-prcomp(df,scale. = TRUE)
autoplot(pca_res)

#with cluster colors
autoplot(pca_res, data = AA, colour='Cluster')
#with cluster shapes
autoplot(pca_res, data = AA, colour='Cluster',frame=TRUE)


###PCA_2 with 175 SNP NLR extracted (- 26 unclustered up to cl16 Saba clusters)
AA_175 <-read.csv(file.choose(),h=T)
df_175<-AA_175[2:6]

pca_res_175<-prcomp(df_175,scale. = TRUE)
autoplot(pca_res_175)

#with cluster colors
autoplot(pca_res_175, data = AA_175, colour='Cluster')
#with cluster shapes
autoplot(pca_res_175, data = AA_175, colour='Cluster',frame=TRUE)


###PCA_3 with 162 SNP NLR extracted (- 26 unclustered - 13 pangenome)
AA_162 <-read.csv(file.choose(),h=T)
df_162<-AA_162[2:6]

pca_res_162<-prcomp(df_162,scale. = TRUE)
autoplot(pca_res_162)

#with cluster colors
autoplot(pca_res_162, data = AA_162, colour='Cluster')
#with cluster shapes
autoplot(pca_res_162, data = AA_162, colour='Cluster',frame=TRUE)
#with cluster spheres
autoplot(pca_res_162, data = AA_162, colour='Cluster',frame=TRUE, frame.type='norm')

###PCA_4 with 165 SNP WG (- unclustered -pangenome) open the SNP WG folder
AA_WG_162 <-read.csv(file.choose(),h=T)
df_WG_162<-AA_WG_162[2:6]

pca_res_WG_162<-prcomp(df_WG_162,scale. = TRUE)
autoplot(pca_res_WG_162)

#with cluster colors
autoplot(pca_res_WG_162, data = AA_WG_162, colour='Cluster')
#with cluster shapes
autoplot(pca_res_WG_162, data = AA_WG_162, colour='Cluster',frame=TRUE)
#with cluster spheres
autoplot(pca_res_WG_162, data = AA_WG_162, colour='Cluster',frame=TRUE, frame.type='norm')


#### ________________ Sep 2025 
###PCA_5 with 175 Whole Genome Thinned vcf NLR extracted (25 clusters (8 wild relatives) - 26 unclustered - 9 pangenome))
AA_175_WG <-read.csv(file.choose(),h=T) # SNP WG/
df_175_WG <-AA_175_WG[2:6]

pca_res_175_WG <-prcomp(df_175_WG ,scale. = TRUE)
autoplot(pca_res_175_WG) # default is X PCA1, y PCA2. It can be changed if adden into the bracket: , x=1, y=3

#,label = TRUE, label.label = "Cluster" ##(to get the name sof all the samples in a cluster)
#with cluster colors
autoplot(pca_res_175_WG, data = AA_175_WG, colour='Cluster') + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
#with cluster shapes
dev.off()
pdf(file = "SNP_GW_175samples_25cluster_pca1_2_8wild_w10_h6.pdf", width = 8, height = 6)
autoplot(pca_res_175_WG, data = AA_175_WG, colour='Cluster',frame=TRUE, names=TRUE) + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
dev.off()
pdf(file = "SNP_GW_175samples_25cluster_pca1_3_8wild_w10_h6.pdf", width = 8, height = 6)
autoplot(pca_res_175_WG, x=1, y=3, data = AA_175_WG, colour='Cluster',frame=TRUE, names=TRUE) + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
dev.off()
pdf(file = "SNP_GW_175samples_25cluster_pca2_3_8wild_w10_h6.pdf", width = 8, height = 6)
autoplot(pca_res_175_WG, x=2, y=3, data = AA_175_WG, colour='Cluster',frame=TRUE, names=TRUE) + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
dev.off()
pdf(file = "SNP_GW_175samples_25cluster_pca2_4_8wild_w10_h6.pdf", width = 8, height = 6)
autoplot(pca_res_175_WG, x=2, y=4, data = AA_175_WG, colour='Cluster',frame=TRUE, names=TRUE) + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
dev.off()
#with cluster spheres
autoplot(pca_res_175_WG, data = AA_175_WG, colour='Cluster',frame=TRUE, frame.type='norm') + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
#with cluster names in each sample
autoplot(pca_res_175_WG, data = AA_175_WG, colour='Cluster',frame=TRUE, names=TRUE, label= TRUE, label.label='Cluster') + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
# with one label per cluster


#### ________________ Sep 2025 for thesis
###PCA_6s with 175 Whole Genome Thinned vcf NLR extracted (25 clusters (8 wild relatives) - 26 unclustered - 9 pangenome))
# PCA matrix is called AA_175_WG
# and has columns: Sample, PC1, PC2, PC3, PC4, PC5, Cluster
library(ggfortify)
AA_175_WG <-read.csv(file.choose(),h=T)

## normal PCA, colors by cluster ellipse
ggplot(AA_175_WG, aes(x = PC1, y = PC2, colour = Cluster)) +
  geom_point(size = 2) +                                   # points
  stat_ellipse(aes(group = Cluster, colour = Cluster),     # frames
               type = "t", level = 0.95) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  theme_minimal()

# Compute cluster centroids for clsuter labels
library(dplyr)

scores <- as.data.frame(AA_175_WG[,2:3]) # first 2 PCs
scores$Cluster <- AA_175_WG$Cluster

centroids <- scores %>%
  group_by(Cluster) %>%
  summarise(PC1 = mean(PC1), PC2 = mean(PC2))

# Plot PCA with cluster centroids labeled
ggplot(AA_175_WG, aes(x = PC1, y = PC2, colour = Cluster)) +
  geom_point(size = 2) +                                   # points
  stat_ellipse(aes(group = Cluster, colour = Cluster),     # frames
               type = "t", level = 0.95) +
  geom_text(data = centroids,                              # cluster labels
            aes(label = Cluster), size = 4, show.legend = TRUE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  theme_minimal()

## normal PCA, colors by cluster polygonal, this are the ones in the thesis sep 10 2025
install.packages("concaveman")
library(concaveman) # or grDevices::chull for convex hull

## calculate the variance explain for each PC
# keep only PC columns
pc_only <- AA_175_WG[, grep("^PC", names(AA_175_WG))]
# variance per PC = eigenvalues
eig_vals <- apply(pc_only, 2, var)
# % variance explained
var_exp <- eig_vals / sum(eig_vals) * 100
round(var_exp, 2)
data.frame(PC = names(var_exp),
           VarianceExplained = round(var_exp, 2))

scree_df1 <- data.frame(PC = factor(names(var_exp), levels = names(var_exp)), Variance = var_exp)
ggplot(scree_df1, aes(x = PC, y = Variance)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = paste0(round(Variance, 1), "%")),
            vjust = -0.5, size = 3.5) +
  labs(x = "Principal Component", y = "Variance Explained (%)",
       title = "Scree Plot of PCA") +
  theme_minimal()

ggplot(scree_df1, aes(x = as.numeric(PC), y = Variance)) +
  geom_line() +
  geom_point(size = 2) +
  scale_x_continuous(breaks = 1:nrow(scree_df1),
                     labels = levels(scree_df1$PC)) +
  labs(x = "Principal Component", y = "Variance Explained (%)",
       title = "Scree Plot of PCA") +
  theme_minimal()

scree_df2 <- data.frame(
  PC = 1:length(var_exp),
  Variance = var_exp,
  Cumulative = cumsum(var_exp))

dev.off()
png(file = "Explained_variance_and_cummulative_w5000_h6000_res_600_size25.png", width=5000, height=6000, res=600)
ggplot(scree_df2, aes(x = PC)) +
  # bars for variance per PC
  geom_col(aes(y = Variance), fill = "steelblue", alpha = 0.7) +
  # cumulative line
  geom_line(aes(y = Cumulative), colour = "red", size = 1) +
  geom_point(aes(y = Cumulative), colour = "red", size = 2) +
  # labels
  geom_text(aes(y = Variance, label = paste0(round(Variance,1), "%")),
            vjust = -0.5, size = 10) +
  geom_text(aes(y = Cumulative, label = paste0(round(Cumulative,1), "%")),
            vjust = 1.8, hjust= 0.2,colour = "red", size = 10) +
  labs(x = "Principal Component",
       y = "Variance Explained (%)",
       title = "Scree Plot with Cumulative Variance") +
  theme_minimal(base_size = 25)
dev.off()

#### plotted PCAs sep 10 2025
# Function to get convex hull points for a cluster
get_hull <- function(df) df[chull(df$PC1, df$PC2), ]

hulls <- AA_175_WG %>%
  group_by(Cluster) %>%
  do(get_hull(.))

dev.off()
pdf(file = "SNP_GW_175samples_25cluster_pca1_2_8wild_w8_h6.pdf", width = 8, height = 6)
png(file = "SNP_GW_175samples_25cluster_pca1_2_8wild_w5000_h4100_res_600_size20.png", width=5000, height=4100, res=600)
ggplot(AA_175_WG, aes(x = PC1, y = PC2, colour = Cluster, )) +
  geom_point(size = 3) +                                   # points
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"),
       y = paste0("PC2 (", round(var_exp["PC2"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

###do the same for all the other PC combinations
png(file = "SNP_GW_175samples_25cluster_pca4_5_8wild_w5000_h4100_res_600_size20.png", width=5000, height=4100, res=600)
ggplot(AA_175_WG, aes(x = PC4, y = PC5, colour = Cluster, )) +
  geom_point(size = 3) +                                   # points
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC4 (", round(var_exp["PC4"], 1), "%)"),
       y = paste0("PC5 (", round(var_exp["PC5"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

# Compute cluster centroids for cluster labels
hull_centroids <- hulls %>%
  group_by(Cluster) %>%
  summarise(PC1 = mean(PC1), PC2 = mean(PC2))

png(file = "SNP_GW_175samples_25cluster_pca1_2_8wild_w5000_h4100_res_600_size20_cluster_names.png", width=5000, height=4100, res=600)
ggplot(AA_175_WG, aes(x = PC1, y = PC2, colour = Cluster, )) +
  geom_point(size = 3) +                                   # points
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  geom_text(data = hull_centroids,                              # cluster labels
            aes(label = Cluster, x = PC1, y = PC2, colour = Cluster),
            fontface = "bold", size = 4, show.legend = FALSE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"),
       y = paste0("PC2 (", round(var_exp["PC2"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

# Compute cluster centroids for cluster labels PC1 and PC3
hull_centroids_13 <- hulls %>% group_by(Cluster) %>% summarise(PC1 = mean(PC1), PC3 = mean(PC3))

png(file = "SNP_GW_175samples_25cluster_pca1_3_8wild_w5000_h4100_res_600_size20_cluster_names.png", width=5000, height=4100, res=600)
ggplot(AA_175_WG, aes(x = PC1, y = PC3, colour = Cluster, )) + geom_point(size = 3) +                                  
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2, colour = NA, show.legend = TRUE) +
  geom_text(data = hull_centroids_13,aes(label = Cluster, x = PC1, y = PC3, colour = Cluster), fontface = "bold", size = 4, show.legend = FALSE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"), y = paste0("PC3 (", round(var_exp["PC3"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

# Compute cluster centroids for cluster labels PC2 and PC3
hull_centroids_23 <- hulls %>% group_by(Cluster) %>% summarise(PC2 = mean(PC2), PC3 = mean(PC3))

png(file = "SNP_GW_175samples_25cluster_pca2_3_8wild_w5000_h4100_res_600_size20_cluster_names.png", width=5000, height=4100, res=600)
ggplot(AA_175_WG, aes(x = PC2, y = PC3, colour = Cluster, )) + geom_point(size = 3) +                                  
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2, colour = NA, show.legend = TRUE) +
  geom_text(data = hull_centroids_23,aes(label = Cluster, x = PC2, y = PC3, colour = Cluster), fontface = "bold", size = 4, show.legend = FALSE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC2 (", round(var_exp["PC2"], 1), "%)"), y = paste0("PC3 (", round(var_exp["PC3"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

##put figure PC figure together
p1 <-
  ggplot(AA_175_WG, aes(x = PC1, y = PC2, colour = Cluster, )) + geom_point(size = 3) + 
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2, colour = NA, show.legend = TRUE) +
  geom_text(data = hull_centroids,aes(label = Cluster, x = PC1, y = PC2, colour = Cluster), fontface = "bold", size = 5, show.legend = FALSE, hjust=0.25) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"), y = paste0("PC2 (", round(var_exp["PC2"], 1), "%)")) +
  theme(text = element_text(size=20))

  
p2 <-
  ggplot(AA_175_WG, aes(x = PC1, y = PC3, colour = Cluster)) +
  geom_point(size = 3) +                                   # points
  geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"),
       y = paste0("PC3 (", round(var_exp["PC3"], 1), "%)")) +
  theme(text = element_text(size=20), legend.position = "none")

p3 <-
  ggplot(AA_175_WG, aes(x = PC2, y = PC3, colour = Cluster)) +
    geom_point(size = 3) +                                   # points
    geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
                 colour = NA, show.legend = TRUE) +
    guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
    labs(x = paste0("PC2 (", round(var_exp["PC2"], 1), "%)"),
         y = paste0("PC3 (", round(var_exp["PC3"], 1), "%)")) +
    theme(text = element_text(size=20), legend.position = "none")
  
p4 <-
  ggplot(scree_df2, aes(x = PC)) +
    geom_col(aes(y = Variance), fill = "steelblue", alpha = 0.7) +
    geom_line(aes(y = Cumulative), colour = "red", size = 1) +
    geom_point(aes(y = Cumulative), colour = "red", size = 2) +
    geom_text(aes(y = Variance, label = paste0(round(Variance,1), "%")), vjust = -0.5, size = 5) +
    geom_text(aes(y = Cumulative, label = paste0(round(Cumulative,1), "%")), vjust = 1.8, hjust= 0.2,colour = "red", size = 5) +
    labs(x = "Principal Component", y = "Variance Explained (%)", title = "Scree Plot with Cumulative Variance") +
    theme_minimal(base_size = 15)

library(ggpubr)
bottom_row <-
 ggarrange(p2, p3, p4, ncol = 3, nrow = 1, widths = c(0.7, 0.7, 1),
                        labels = c("B", "C", "D"),   # labels for P2–P4
                        label.x = 0, label.y = 1,    # adjust label positions
                        font.label = list(size = 20, face = "bold"))

  # final_plot <-
 png(file = "PCA_SNP_GW_175samples_25cluster_pca1_2_8wild_w7200_h8000_res_600_cluster_names.png", width=7200, height=8000, res=600)
    ggarrange(p1, bottom_row, ncol = 1, nrow = 2,
    heights = c(1, 0.4),                 # control row height ratio
    labels = "A",                        # label for top plot
    label.x = 0, label.y = 1,
    font.label = list(size = 20, face = "bold"))
    dev.off()


###PCA_6 with 175 SNP NLR extracted (25 clusters (8 wild relatives) - 26 unclustered - 9 pangenome))
AA_175 <-read.csv(file.choose(),h=T)
df_175<-AA_175[2:6]

pca_res_175<-prcomp(df_175,scale. = TRUE)
autoplot(pca_res_175, x=1, y=2)

#with cluster colors
autoplot(pca_res_175, x=1, y=2, data = AA_175, colour='Cluster') + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
#with cluster shapes
autoplot(pca_res_175, x=1, y=2, data = AA_175, colour='Cluster',frame=TRUE, names=TRUE) + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))
#with cluster spheres
autoplot(pca_res_175, x=1, y=2, data = AA_175, colour='Cluster',frame=TRUE, frame.type='norm') + guides (colour=guide_legend(override.aes = list(size=2), ncol = 1))


#### ________________ Sep 2025 for thesis (25Sep )
###PCA_7, SNP NLRs extracted (25 clusters (8 wild relatives) )
# PCA matrix is called AA_175_WG
# and has columns: Sample, PC1, PC2, PC3, PC4, PC5, Cluster
library(ggfortify)
# Compute cluster centroids for clsuter labels
library(dplyr)
## normal PCA, colors by cluster polygonal, this are the ones
library(concaveman) # or grDevices::chull for convex hull

AA_175_SNPs <-read.csv(file.choose(),h=T)

# Function to get convex hull points for a cluster
get_hull <- function(df) df[chull(df$PC1, df$PC2), ]

hulls_SNP <- AA_175_SNPs %>% group_by(Cluster) %>% do(get_hull(.))

# Compute cluster centroids for cluster labels
hull_centroids_SNP <- hulls_SNP %>%  group_by(Cluster) %>% summarise(PC1 = mean(PC1), PC2 = mean(PC2))

png(file = "SNP_NLRs_175samples_25cluster_pca1_2_8wild_w5000_h4100_res_600_size20_cluster_names.png", width=5000, height=4100, res=600)
  ggplot(AA_175_SNPs, aes(x = PC1, y = PC2, colour = Cluster, )) +
  geom_point(size = 2) +                                   # points
  geom_polygon(data = hulls_SNP, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  geom_text(data = hull_centroids_SNP,                              # cluster labels
            aes(label = Cluster, x = PC1, y = PC2, colour = Cluster),
            fontface = "bold", size = 3, show.legend = FALSE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"),
       y = paste0("PC2 (", round(var_exp["PC2"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

## plot the other components combinations
png(file = "SNP_NLR_175samples_25cluster_pca2_3_8wild_w5000_h4100_res_600_size20.png", width=5000, height=4100, res=600)
ggplot(AA_175_SNPs, aes(x = PC2, y = PC3, colour = Cluster, )) +
  geom_point(size = 2) +                                   # points
  geom_polygon(data = hulls_SNP, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC2 (", round(var_exp["PC2"], 1), "%)"),
       y = paste0("PC3 (", round(var_exp["PC3"], 1), "%)")) +
  theme(text = element_text(size=20))
dev.off()

## ## calculate the variance explain for each PC
# keep only PC columns
pc_only <- AA_175_SNPs[, grep("^PC", names(AA_175_SNPs))]
# variance per PC = eigenvalues
eig_vals <- apply(pc_only, 2, var)
# % variance explained
var_exp_SNP <- eig_vals / sum(eig_vals) * 100
round(var_exp_SNP, 2)
data.frame(PC = names(var_exp_SNP),
           VarianceExplained = round(var_exp_SNP, 2))

scree_df3 <- data.frame(PC = factor(names(var_exp_SNP), levels = names(var_exp_SNP)), Variance = var_exp_SNP)
ggplot(scree_df3, aes(x = PC, y = Variance)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = paste0(round(Variance, 1), "%")),
            vjust = -0.5, size = 3.5) +
  labs(x = "Principal Component", y = "Variance Explained (%)",
       title = "Scree Plot of PCA") +
  theme_minimal()

ggplot(scree_df3, aes(x = as.numeric(PC), y = Variance)) +
  geom_line() +
  geom_point(size = 2) +
  scale_x_continuous(breaks = 1:nrow(scree_df3),
                     labels = levels(scree_df3$PC)) +
  labs(x = "Principal Component", y = "Variance Explained (%)",
       title = "Scree Plot of PCA") +
  theme_minimal()

scree_df4 <- data.frame(
  PC = 1:length(var_exp_SNP),
  Variance = var_exp_SNP,
  Cumulative = cumsum(var_exp_SNP))

dev.off()
png(file = "SNP_NLR_Explained_variance_and_cummulative_w5000_h6000_res_600_size25.png", width=5000, height=6000, res=600)
scree_variance_SNP<-
ggplot(scree_df4, aes(x = PC)) +
  # bars for variance per PC
  geom_col(aes(y = Variance), fill = "steelblue", alpha = 0.7) +
  # cumulative line
  geom_line(aes(y = Cumulative), colour = "red", size = 1) +
  geom_point(aes(y = Cumulative), colour = "red", size = 2) +
  # labels
  geom_text(aes(y = Variance, label = paste0(round(Variance,1), "%")),
            vjust = -0.5, size = 8) +
  geom_text(aes(y = Cumulative, label = paste0(round(Cumulative,1), "%")),
            vjust = 1.8, hjust= 0.2,colour = "red", size = 8) +
  labs(x = "Principal Component",
       y = "Variance Explained (%)",
       title = "Scree Plot with Cumulative Variance") +
  theme(text = element_text(size=20),
        plot.title=element_text(family='', hjust=0.5, vjust = 0.5 ,face='bold', colour='black', size=14),
        axis.title.x =element_text(color = "black", size = 12, face = "bold"),
        axis.text.x = element_text(angle = 0, hjust = 1), 
        axis.title.y =element_text(color = "black", size = 12, face = "bold"),
        axis.text.y = element_text(angle = 0, hjust = 1))

  
dev.off()

## Figure 12 three columns
p1_SNP<-
  ggplot(AA_175_SNPs, aes(x = PC1, y = PC2, colour = Cluster, )) +
  geom_point(size = 2) +                                   # points
  geom_polygon(data = hulls_SNP, aes(fill = Cluster, colour = Cluster), alpha = 0.2,
               colour = NA, show.legend = TRUE) +
  geom_text(data = subset(hull_centroids_SNP, Cluster=="25_Mas-Kirana_Pangenome"),
              aes(label = Cluster, x = PC1, y = PC2, colour = Cluster),
              fontface = "bold", size = 3, show.legend = FALSE) +
  guides(colour = guide_legend(override.aes = list(size = 2), ncol = 1)) +
  labs(x = paste0("PC1 (", round(var_exp_SNP["PC1"], 1), "%)"),
       y = paste0("PC2 (", round(var_exp_SNP["PC2"], 1), "%)")) +
  ggtitle("Diversity Panel SNP NLRs") +
  theme(text = element_text(size=20),legend.position = "none",
    plot.title=element_text(family='', hjust=0.5, vjust = 0.5 ,face='bold', colour='black', size=14),
    axis.title.x =element_text(color = "black", size = 12, face = "bold"),
    axis.text.x = element_text(angle = 0, hjust = 1),
    axis.title.y =element_text(color = "black", size = 12, face = "bold"),
    axis.text.y = element_text(angle = 0, hjust = 1))
  dev.off()
  
  p1_SNP
  p1_title <-
    ggplot(AA_175_WG, aes(x = PC1, y = PC2, colour = Cluster, )) + geom_point(size = 2) + 
    geom_polygon(data = hulls, aes(fill = Cluster, colour = Cluster), alpha = 0.2, colour = NA, show.legend = TRUE) +
    geom_text(data = hull_centroids,aes(label = Cluster, x = PC1, y = PC2, colour = Cluster), fontface = "bold", size = 5, show.legend = FALSE, hjust=0.25) +
    guides(colour = guide_legend(override.aes = list(size = 2), ncol = 2)) +
    labs(x = paste0("PC1 (", round(var_exp["PC1"], 1), "%)"), y = paste0("PC2 (", round(var_exp["PC2"], 1), "%)")) +
    ggtitle("Whole Genome SNP")+
    theme(text = element_text(size=20),
          plot.title=element_text(family='', hjust=0.5, vjust = 0.5 ,face='bold', colour='black', size=14),
          axis.title.x =element_text(color = "black", size = 12, face = "bold"),
          axis.text.x = element_text(angle = 0, hjust = 1), 
          axis.title.y =element_text(color = "black", size = 12, face = "bold"),
                                                         axis.text.y = element_text(angle = 0, hjust = 1))
  p1_title
  scree_variance_SNP

  
  library(ggpubr)
  top_row <-
    ggarrange(p1_SNP, scree_variance, ncol = 2, nrow = 1, widths = c(1, 1),
              labels = c("A", "B"),   # labels 
              label.x = 0, label.y = 1,    # adjust label positions
              font.label = list(size = 20, face = "bold"))
  
  
  ## plot K=6 ONLY Pop structure
  library(reshape) 
  library(dplyr)
  library(tidyr)
  library(lattice)
  library(gridExtra)
  library(grid)
  
  K6<- read.csv("../results_10runs_STRUCTURE_SNP_NLR_extraction_MISS50_Musa_acuminata_pahang_v4/Average_Q_6_7col.csv",header=TRUE)
  
  K6$Label <- factor(K6$Label, levels = K6$Label)
  pcaPalette <- c("lightblue","royalblue","darkorchid","forestgreen","darkred","darkorange","hotpink","plum1")
  K6rg <- gather(K6,key,value,-Label,-pops)
  
  #plot pop proportion
  cog<-ggplot(data=K6rg, aes(x=Label, y=value, fill=key)) +
    geom_bar(stat="identity")
  cog3 <- cog +theme(axis.text.x=element_text(angle = 55, hjust = 1, size=3))+ylab ("Genotype") + scale_y_continuous(expand = c(0,0)) 
  cog4 <- cog3 + scale_fill_manual(values=pcaPalette)
  
  pdf(file = "plot_NLR_SNP_aa_K6.pdf",width=10,height=4)
  cog4
  dev.off()
  
  #
  
  
  # final_plot 12 <-
  png(file = "PCA_SNP_NLR_175samples_25cluster_pca1_2_8wild_w7200_h8000_res_600_cluster_names.png", width=7200, height=8000, res=600)
  ggarrange(top_row, p1_title, cog4, ncol = 1, nrow = 3,
            heights = c(0.9, 1, 0.9),                 # control row height ratio
            labels = c("", "C","D"),                        # label for top plot
            label.x = 0, label.y = 1,
            font.label = list(size = 20, face = "bold"))
  dev.off()
  
  
  