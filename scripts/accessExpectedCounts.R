## Load libraries for accessing counts
library(DelayedArray)
library(SummarizedExperiment)

## Load expectedCounts
expectedCounts <- readRDS("data/h5/expectedCounts.rds")

## Update path to count data
path(assay(expectedCounts)) <- "data/h5/expectedCounts.h5"

## Access count data
assay(expectedCounts, "counts")
