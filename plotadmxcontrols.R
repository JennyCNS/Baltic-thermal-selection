library(tidyverse)
library(dplyr)

tbl1=read.table("kielmaf001pruned.3.Q")
tbl2=read.table("kielmaf001.list")

tbl3 <- cbind(tbl1,tbl2)
names(tbl3)[4] <- "ind"

pop <- rep (NA, length(tbl3$ind))
pop[grep("S", tbl3$ind)] <- "Selected"
pop[grep("NS", tbl3$ind)] <- "N_Selected"
pop[grep("GK", tbl3$ind)] <- "Kiel"
pop[grep("GA", tbl3$ind)] <- "Ahrenshoop"
pop[grep("FIN", tbl3$ind)] <- "Finland"
pop[grep("BUDL", tbl3$ind)] <- "Budleigh"
pop[grep("BUDE", tbl3$ind)] <- "Bude"

k3 <- as_tibble(data.frame(tbl3,pop))
k3 = k3 %>% arrange(pop,V1)



#pal <- colorRampPalette(colors = c("lightblue", "blue"))(3)
#pdf("k4-maf001.pdf", width=10)
#barplot(t(as.matrix(k3)), col=pal, width=0.1, space=0.2, las=2, xlab="Populations", ylab="Ancestry", border=NA, names.arg=(k3$pop))
#dev.off()


pdf("k3-kielmaf001pruned.pdf", width=22, height=12)
barplot(t(as.matrix(k3)), col=c("#0073C2FF","#71D0F5FF", "#FED439FF"), width=0.1, space=0.2, las=2, xlab="Populations", ylab="Ancestry", border=NA, names.arg=(k3$pop))
dev.off()

#####
#k3

tbl1=read.table("kielmaf001pruned.4.Q")
tbl2=read.table("kielmaf001.list")

tbl3 <- cbind(tbl1,tbl2)
names(tbl3)[5] <- "ind"


pop <- rep (NA, length(tbl3$ind))
pop[grep("S", tbl3$ind)] <- "Selected"
pop[grep("NS", tbl3$ind)] <- "N_Selected"
pop[grep("GK", tbl3$ind)] <- "Kiel"
pop[grep("GA", tbl3$ind)] <- "Ahrenshoop"
pop[grep("FIN", tbl3$ind)] <- "Finland"
pop[grep("BUDL", tbl3$ind)] <- "Budleigh"
pop[grep("BUDE", tbl3$ind)] <- "Bude"

k3 <- as_tibble(data.frame(tbl3,pop))
k3 = k3 %>% arrange(pop,V1)


k3 <- as_tibble(data.frame(tbl3,pop))
k3 = k3 %>% arrange(pop,V3,V2)


pdf("k4-kielmaf001pruned.pdf", width=22, height=12)
barplot(t(as.matrix(k3)), col=c( "#71D0F5FF", "#FED439FF", "#0073C2FF", "#F05C3BFF"), width=0.1, space=0.2, las=2, xlab="Populations", ylab="Ancestry", border=NA, names.arg=(k3$pop))
dev.off()

#"#F05C3BFF"
