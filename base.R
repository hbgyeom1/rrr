library(data.table)

getwd()
setwd("data")

dt <- fread("example_g1e.csv")

fwrite(dt, "aa.csv")
