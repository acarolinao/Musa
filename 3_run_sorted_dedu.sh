#!/bin/bash
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 1 --mem 100G
#SBATCH -J sam_to_bam
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constrain=intel # to avoid problematic nodes

Bananasample=$1
source samtools-1.7
cd SNP_calling_all/bam_sort_dedu/
samtools view -b -S -h ../samfiles/${Bananasample}_newheader.sam\
 | samtools sort -T ${Bananasample}_temporal\
 > ${Bananasample}_sorted.bam

#source jre-8u144
#source picardtools-2.1.1
#java -jar /tgac/software/testing/picardtools/2.1.1/x86_64/bin/picard.jar \
#MarkDuplicates INPUT=${Bananasample}_sorted.bam OUTPUT=${Bananasample}_sorted.bam_mdup.bam M=${Bananasample}_mdup.txt
