#!/bin/bash
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 4 --mem 50G
#SBATCH -J index_GATK
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constrain=intel # to avoid problematic nodes

cd SNP_calling_all/

#Index reference genome used in the aligment with bwa
source samtools-1.7
samtools dict Musa_acuminata_pahang_v4.fasta > Musa_acuminata_pahang_v4.dict
samtools faidx Musa_acuminata_pahang_v4.fasta  #generates a file name.fasta.fai
