## Set i as 1:9
i = 1

## Load required packages
library(mariner)
library(GenomeInfoDb)

## Load raw data
load("data/raw/LIMA_binnedEPCounts.rda")

## LIMA .hic files are big so define
## the path to them here (backup hard-drive)
## Timepoint files
timepoints <- 
  list.files(path="/Volumes/LIMA_Processed_Data/hg19/hic/timepoints/",
             pattern="inter.hic$",
             recursive=TRUE,
             full.names=TRUE)

## Omega file
omega <- 
  list.files(path="/Volumes/LIMA_Processed_Data/hg19/hic/omega/",
             pattern="inter_withNorms.hic$",
             recursive=TRUE,
             full.names=TRUE)

hicFiles <- c(timepoints, omega)


## Reformat loops to remove 'chr' prefix
seqlevelsStyle(epCounts) <- 'ENSEMBL'


## Remove chromosomes from epCounts
## that are not in the hicFiles...
chromsInLoops <- seqnames(seqinfo(epCounts))
chromsInHic <- strawr::readHicChroms(hicFiles[9])$name
keep <- chromsInLoops %in% chromsInHic
chromsToKeep <- chromsInLoops[keep]
seqlevels(epCounts) <- seqlevels(seqinfo(epCounts)[chromsToKeep])

system.time({
  res <-
    pullHicPixels(x=epCounts[1:100000],
                  binSize=10e03,
                  files=hicFiles[i],
                  norm='KR',
                  matrix='expected',
                  blockSize=1e06)
})

## Save this path
fp <- path(mariner::counts(res))
fn <- file.path("data/h5", gsub(".hic$", ".h5", basename(hicFiles[i])))
file.rename(from=fp, to=fn)
path(SummarizedExperiment::assay(res)) <- fn

## Save this object
saveRDS(object=res, file=gsub(".h5$", ".rds", fn))
