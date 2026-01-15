#!/bin/bash
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 4 --mem 50G
#SBATCH -J index_GATK
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constrain=intel # to avoid problematic nodes

cd SNP_calling_all/

#Index the banana samples of the pangenome
Bananasample=$1
source bamtools-2.4.0
bamtools index -in bam_sort_dedu/${Bananasample}_sorted.bam_mdup.bam
