#!/bin/bash
#SBATCH --mem 100G -c 4
source bcftools-1.15.1_CBG
#for i in *vcf; do bgzip -@ 4 -i ${i}; done

#on scratch those jobs were sent

#sbatch --mem 100G --wrap="bcftools concat -Oz -o concat_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN10.vcf calls_*_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN10.vcf.gz"


#sbatch --mem 100G --wrap="bcftools concat -Oz -o concat_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01.vcf.gz calls_*_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01.vcf.gz"


#sbatch --mem 100G --wrap="bcftools concat -Oz -o concat_QUAL100_DP10-300_MISS3_BIALLELICSNPS.vcf.gz calls_*_QUAL100_DP10-300_MISS3_BIALLELICSNPS.vcf.gz"


#sbatch --mem 100G --wrap="bcftools concat -Oz -o concat_QUAL100_DP10-300_MISS3.vcf.gz calls_*_QUAL100_DP10-300_MISS3.vcf.gz"


#sbatch --mem 100G --wrap="bcftools concat -Oz -o concat_QUAL100_DP10-300.vcf.gz calls_*_QUAL100.vcf.gz


#sbatch --mem 100G --wrap="bcftools concat -Oz -o concat_QUAL100.vcf.gz calls_*_QUAL100.vcf.gz
