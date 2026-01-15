#!/bin/bash
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 4 --mem 100G
#SBATCH -J VCFmerge
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constrain=intel # to avoid problematic nodes


cd SNP_calling_all/AA_pangenomeACO_JH_Haplotypecaller_ploidy3

source jre-8u92
source gatk-3.6.0
java -jar /ei/software/testing/gatk/3.6.0/x86_64/bin/GenomeAnalysisTK.jar \
-T CombineVariants -genotypeMergeOptions REQUIRE_UNIQUE \
-R ../Musa_acuminata_pahang_v4.fasta \
-o AA_panel_ACO_JH_Haplotypecaller_ploidy3_dbsnpJH.vcf.gz \
--variant AA_pangenomeACO_Haplotypecaller_ploidy3_dbsnpJH.vcf \
--variant 188sam_musa_acumv4_Haplotypecaller_ploidy3.vcf
