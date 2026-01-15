#!/bin/bash
#SBATCH --mem 50G -c 8
region=$1
source bcftools-1.12

bcftools mpileup --threads 8 -f Musa_acuminata_pahang_v4.fasta -r ${region} -a AD,DP -b list_bams.txt -Ou | \
bcftools call --threads 8 -a GQ,GP --ploidy 2 -mv -Ou | \
bcftools view --threads 8 -i '%QUAL>=30' -Oz -o calls_${region}.vcf.gz

