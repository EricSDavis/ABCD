## Load required packages
library(mariner)
library(GenomeInfoDb)

## Load raw data
load("data/raw/LIMA_binnedEPCounts.rda")

## LIMA .hic files are big so define
## the path to them here (backup hard-drive)
## Timepoint files
timepoints <- c("/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0000_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0000_S_0.0.0_megaMap_inter.hic",
                "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0030_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0030_S_0.0.0_megaMap_inter.hic",
		            "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0060_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0060_S_0.0.0_megaMap_inter.hic",
		            "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0090_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0090_S_0.0.0_megaMap_inter.hic",
		            "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0120_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0120_S_0.0.0_megaMap_inter.hic",
		            "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0240_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0240_S_0.0.0_megaMap_inter.hic",
		            "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0360_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0360_S_0.0.0_megaMap_inter.hic",
		            "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_1440_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_1440_S_0.0.0_megaMap_inter.hic")
## Omega file
omega <- "/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_CMB_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_CMB_S_0.0.0_omegaMap_inter_withNorms.hic"
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

## Define hdf5 and rds filenames
fn <- "data/h5/expectedCounts.h5"
rn <- gsub(".h5$", ".rds", fn)

system.time({
  res <-
    pullHicPixels(x=epCounts,
                  binSize=10e03,
                  files=hicFiles,
                  h5File=fn,
                  norm='KR',
                  matrix='expected',
                  blockSize=6e06)
})

## Save this object
saveRDS(object=res, file=rn)
