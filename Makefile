.PHONY: clean

objects :=\
	data/h5/expectedCounts.h5\
	data/h5/expectedCounts.rds

all: $(objects)

clean:
	rm -rf $(objects)

## Rule pattern necessary for this version of make
data/h5/%Counts.h5\
data/h5/%Counts.rds:\
	data/raw/LIMA_binnedEPCounts.rda\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0000_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0000_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0030_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0030_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0060_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0060_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0090_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0090_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0120_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0120_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0240_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0240_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_0360_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_0360_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_1440_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_1440_S_0.0.0_megaMap_inter.hic\
	/proj/phanstiel_lab/Data/processed/LIMA/hic/LIMA_THP1_WT_LPIF_CMB_S_0.0.0_megaMap/aligned/LIMA_THP1_WT_LPIF_CMB_S_0.0.0_omegaMap_inter_withNorms.hic\
	scripts/pullExpectedPixels.R 
		mkdir -p data/h5
		sbatch -J "pullExpectedPixels" -p general --mem=64G -t 1440 -n 1 -N 1 --wrap="R CMD BATCH scripts/pullExpectedPixels.R"
