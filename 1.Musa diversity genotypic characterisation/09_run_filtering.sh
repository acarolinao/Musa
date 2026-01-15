#!/bin/bash -e
#SBATCH -p ei-long
#SBATCH -J filter
#SBATCH -N 1 # number of nodes
#SBATCH -c 1 # number of tasks
#SBATCH --mem 20G # memory pool for all cores

myvcf=$1

source bcftools-1.10.2

#bcftools stats ${myvcf} > ${myvcf}_stats.txt

#bcftools filter -Ov -i 'QUAL>100' ${myvcf} > ${myvcf}_QUAL100.vcf

#bcftools stats ${myvcf}_QUAL100.vcf > ${myvcf}_QUAL100_stats.txt

#bcftools filter -e "FMT/DP<10" -S "." ${myvcf}_QUAL100.vcf | bcftools filter -Ov -e "FMT/DP>300" -S "." > ${myvcf}_QUAL100_DP10-300.vcf

#bcftools stats ${myvcf}_QUAL100_DP10-300.vcf > ${myvcf}_QUAL100_DP10-300_stats.txt


source gatk-4.2.0.0
#gatk SelectVariants --max-nocall-fraction 0.3 -R Musa_acuminata_pahang_v4.fasta -V ${myvcf}_QUAL100_DP10-300.vcf -O ${myvcf}_QUAL100_DP10-300_MISS3.vcf

#bcftools stats ${myvcf}_QUAL100_DP10-300_MISS3.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_stats.txt


#bcftools view -m2 -M2 -v snps ${myvcf}_QUAL100_DP10-300_MISS3.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS.vcf

#bcftools stats ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_stats.txt


#bcftools view -q 0.01:minor ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01.vcf

#bcftools stats ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_stats.txt



#bcftools +prune -w 10 -n 1 ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN10.vcf

#bcftools stats ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN10.vcf > ${myvcf}_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN10_stats.txt
