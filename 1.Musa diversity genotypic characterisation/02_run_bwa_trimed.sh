#!/bin/bash
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 4 --mem 50G
#SBATCH -J trim_sam
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address

Bananasample=$1
source bwa-0.7.13
cd ${Bananasample}/

echo ${Bananasample}

bwa mem -M -R "@RG\tID:${Bananasample}\tSM:${Bananasample}\tPL:ILLUMINA\tPI:EI" \
../SNP_calling_all/Musa_acuminata_pahang_v4.fasta ${Bananasample}_1_val_1.fq \
${Bananasample}_2_val_2.fq > ../SNP_calling_all/samfiles/${Bananasample}.sam


# -M for GATK compatibility -R is for the missing line in the bam files previous the VCF process

# for the pangenome samples change tPL:ILLUMINA\tPI:EI for: tPL:ILLUMINA\tPI:300, if sam files has alredy ran just change it using -> sed 's/EI/300/g' ${sample}.sam > ${sample}_newheader.sam before the sorting