#!/bin/bash
#SBATCH -p ei-long #ei-long
#SBATCH -c 4 --mem 100G
#SBATCH -J GATK
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constrain=intel # to avoid problematic nodes

mychr=$1

source jre-8u144
source gatk-4.2.0.0

cd SNP_calling_all/bam_sort_dedu

gatk --java-options "-Xmx50G" HaplotypeCaller -L ${mychr} -ploidy 3 --output ../gatk_by_chr_ploidy3/AA_pangenome_reads_ploidy3_${mychr}.vcf --reference ../Musa_acuminata_pahang_v4.fasta \
--input 01Lidi_SRR15675956_sorted.bam_mdup.bam \
--input 02Jaran_SRR15675957_sorted.bam_mdup.bam \
--input 03Calcutta4_SRR15675958_sorted.bam_mdup.bam \
--input 04Muli_SRR15675959_sorted.bam_mdup.bam \
--input 05Tongkat_SRR15675960_sorted.bam_mdup.bam \
--input 06BSK-30_SRR15675961_sorted.bam_mdup.bam \
--input 07FHIA25_SRR15675962_sorted.bam_mdup.bam \
--input 08Kole_SRR15675963_sorted.bam_mdup.bam \
--input 09Manis-Kerinci_SRR15675964_sorted.bam_mdup.bam \
--input 10Mas-Kirana_SRR15675965_sorted.bam_mdup.bam \
--input 11Mas-Kirana_SRR15675966_sorted.bam_mdup.bam \
--input 12Tanduk_SRR15675967_sorted.bam_mdup.bam \
--input 13Bile_SRR15675968_sorted.bam_mdup.bam
