library(tidyverse)
library(ggplot2)

pca <- read_table("./pca.eigenvec", col_names = FALSE)
eigenval <- scan("pca.eigenval")
pca <- pca[,-1]
print(pca)

#prep table to name your individuals
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))

#create a vector to group individuals (e.g. by population)
names(pca)[1] <- "ind"
spp<- rep (NA, length(pca$ind))

spp[grep("S", pca$ind)] <- "S"
spp[grep("NS", pca$ind)] <- "NS"

pva <- as_tibble(data.frame(pca,spp))
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
#new_order <- c("BBH", "BBC", "SBH", "OA", "CH", "CV", "CC", "PM", "CAF", "CSI", "CRS",  "DDE", "GR", "VG", "LF", "EX", "FAL","IC", "BO", "SW", "GK", "GA", "FIN")
#spp <- factor(as.character(spp), levels=new_order)
#spp <- spp[order(spp$pop),]


cumsum(pve$pve)

# plot pca
# Create the ggplot
# plot pca
pdf("kiel_pc12.pdf", width = 8, height = 6)
#custom_blue <- "#1F78B4" # A lighter shade of dark blue

ggplot(pca, aes(PC1, PC2, col= spp, label = spp)) +  
  # Add horizontal and vertical lines with dotted line type
  geom_hline(yintercept = 0, linetype = "dotted") + 
  geom_vline(xintercept = 0, linetype = "dotted") + 
  # Set the theme to a clean black and white theme
  theme_bw() +
  # Add points with size 4
  geom_point(size = 5) + 
  # Set the limits for x and y axes
  xlim(-0.10, 0.7) + ylim(-0.5, 0.5) + 
  # Ensure equal aspect ratio
  coord_equal() +  
  # Add custom x and y axis labels with percentage explained variance
  xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + 
  ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)")) +
  # Customize the color scale with dark blue and orange, and change legend labels
  scale_color_manual(
    values = c("#1F78B4", "orange"),
    labels = c("NS", "S")
  ) +
  # Remove labels from the points
  guides(label = "none", col = guide_legend(title = "cohort")) +
  # Customize the text size for axis titles, axis labels, and legend title
  theme(
    axis.title = element_text(size = 20, face="bold"),
    axis.text = element_text(size = 16),
    legend.title = element_text(size = 20, face="bold"),
    legend.text = element_text(size = 16),
    panel.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

dev.off()

# plot pca pc1 and 3
#pdf("kielpc13.pdf", width = 15, height = 10)
#ggplot(pca, aes(PC1, PC3, col= spp, label = spp)) +  geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + geom_point(size = 3) + xlim(-0.10,0.8) + ylim(-0.6,0.6) + coord_equal() +  geom_text(aes(label=spp), hjust=0, vjust=0) +  theme_bw() + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC3 (", signif(pve$pve[3], 3), "%)"))
#dev.off()

# plot pca pc1 and 3
#pdf("kielpc23.pdf", width = 15, height = 10)
#ggplot(pca, aes(PC2, PC3, col= spp, label = spp)) +  geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + geom_point(size = 3) + xlim(-0.30,0.8) + ylim(-0.7,0.7) + coord_equal() +  geom_text(aes(label=spp), hjust=0, vjust=0) +  theme_bw() + xlab(paste0("PC2 (", signif(pve$pve[2], 3), "%)")) + ylab(paste0("PC3 (", signif(pve$pve[3], 3), "%)"))
#dev.off()


