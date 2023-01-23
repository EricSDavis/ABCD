## Load libraries for accessing counts
library(DelayedArray)
library(SummarizedExperiment)

## Load expectedCounts
expectedCounts <- readRDS("data/h5/expectedCounts.rds")

## Update path to count data
## Not recommended, but the only way to update
## paths once the object data has been broken
expectedCounts@assays@data@listData$counts@seed@filepath <- "data/h5/expectedCounts.h5"

## Access count data
assay(expectedCounts, "counts")
