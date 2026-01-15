#!/bin/bash -e
#SBATCH -p ei-medium 
#SBATCH -c 8 --mem 100G 
#SBATCH -J trim_galore
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constraint=intel # to avoid problematic nodes

samplename=$1
source fastqc-0.11.9
source trim_galore-0.5.0

cd ${samplename}
mkdir -p ${samplename}_trimmedcut
trim_galore --paired --fastqc -q 20 --clip_R1 5 --clip_R2 5 \
--three_prime_clip_R1 5 --three_prime_clip_R2 5 \
--gzip -o ${samplename}_trimmedcut/ ${samplename}_1.fastq ${samplename}_2.fastq
