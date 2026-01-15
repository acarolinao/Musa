# Musa
This repository contains the scripts in bash and R used in chapters 2 and 3 of the thesis: Species-wide diversity of Musa spp. NLR genes and their distinct response to Fusarium TR4 infection submited the 30th of September of 2025

## 🗂️ Table of Contents
- [Musa diversity genotypic characterization](#1-musa-diversity-genotypic-characterization)
- [Extraction of SNP NLRs](#2-Extraction-of-SNP-NLRs)
- [De Novo Assemblies](#3-De-Novo-Assemblies)
- [Annotation Pipeline](#4-Annotation-Pipeline)
- [NLR Ortholog clustering and NLR arquictecture](#5-NLR-Ortholog-clustering-and-NLR-arquictecture)
- [Musa NLRome Characterization](#6-Musa-NLRome-Characterization)

***
# 1. Musa diversity genotypic characterization  

A diversity panel of 201 accesions was genotyped with a SNP-based variant calling used for principal component anaylsis (pca), phylogeny and population structure. The reference genome of Musa acuminata spp malaccensis (DH-Pahang) v4 (AA_v4) published in 2021 (https://www.nature.com/articles/s42003-021-02559-3) was used to align the reads of the accesions in the panel for the variant calling.

Raw reads of were trimmed with Trim Galore v0.5 to remove the adaptors and bases with quality <20. Fastqc v0.11.9 was sourced inside Trim galore to clip 5 bp on the 5’ and 3’ ends after review of the read quality (0_trimgalore.sh). The resulting read files in FASTQ format were aligned to the indexed AA_v4 (2_run_bwa_trimed.sh). 

```
# Index of reference genome: run in the console of shell 
source bwa-0.7.13
sbatch --wrap="bwa index ../genome_AA_v4/Musa_acuminata_pahang_v4.fasta"

# run run_bwa_trimed.sh
```

The resulGng BAM files were generated with BWA MEM v0.7.13 with the options -M and -R to be compaGble with GATK and BCFtools, defining read groups for the variant calling. SorGng and duplicated reads idenGficaGon was performed with Samtools sort v1.7 with the -b -S -h opGons and Picard tools v2.1.1 MarkDuplicates. The M. acuminata cv. Pahang v4 (AA_v4) reference was indexed with samtools dict and faidx. All sorted bam files were indexed with Bamtools v2.4.0.

# 2. Extraction of SNP NLRs  

# 3. De Novo Assemblies  

# 4. Annotation Pipeline

<img width="4927" height="2429" alt="image" src="https://github.com/user-attachments/assets/5901f554-9c72-4f78-a98c-365e6e405478" />


# 5. NLR Ortholog clustering and NLR arquictecture 

# 6. Musa NLRome Characterization 


