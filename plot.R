library(data.table)
library(magrittr)
library(ggpubr)
library(maxstat)
library(officer)
library(rvg)


# load data
setwd("~/ShinyApps/kangnam_hallym/bgoat/Microbiome_upperairway")
# a <- fread("taxa_abund344_genus HC3.csv", select = c("pathogenic", "chao1", "shannon"))
a <- fread("cilia_simple2.csv", select = c("pathogenic", "chao1", "shannon"))


# change all data to numeric type
a$chao1 <- as.numeric(a$chao1)
sapply(a, class)


# get cutoff
cut_chao1 <- maxstat::maxstat.test(a$chao1 ~ a$pathogenic, data = a)
cut_shannon <- maxstat::maxstat.test(a$shannon ~ a$pathogenic, data = a)

cat("=== chao1 cutoff ===\n")
cut_chao1$estimate
cat("=== shannon cutoff ===\n")
cut_shannon$estimate


# plot graph
# ggscatter(a, x = "pathogenic", y = "shannon") + 
#   geom_vline(xintercept = cut_chao1$estimate, linetype = "dashed", color = "red")

p1 <- ggline(data.frame(cuts = cut_chao1$cuts, stats = cut_chao1$stats),
             x = "cuts", y = "stats", numeric.x.axis = T, plot_type = "l") +
  labs(x = "Cutpoint", y = "Standardized Wilcoxon statistic", title = "Chao1") +
  geom_vline(xintercept = cut_chao1$cuts[which.max(cut_chao1$stats)], linetype = "dashed", color = "red")

p2 <- ggline(data.frame(cuts = cut_shannon$cuts, stats = cut_shannon$stats),
             x = "cuts", y = "stats", numeric.x.axis = T, plot_type = "l") +
  labs(x = "Cutpoint", y = "Standardized Wilcoxon statistic", title = "Shannon") +
  geom_vline(xintercept = cut_shannon$cuts[which.max(cut_shannon$stats)], linetype = "dashed", color = "red")


# save plot to ppt
ppt <- read_pptx()

ppt <- read_pptx() %>%
  add_slide() %>%
  ph_with(dml(ggobj = p1), location = ph_location_fullsize()) %>%
  add_slide() %>%
  ph_with(dml(ggobj = p2), location = ph_location_fullsize())

print(ppt, target = "scatter2.pptx")
