#!/bin/bash
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 1 --mem 50G
#SBATCH -J SNP_NLRextraction
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constraint=intel # to avoid problematic nodes

samplename=$1

mkdir SNP_NLR_extraction_${samplename}
cd SNP_NLR_extraction_${samplename}

## comments
## create bed4 file from the bed file of the NLR annotator that it's in data folder
## /ei/projects/d/d2ae02c8-84dc-443f-bd66-ff84969a0ed7/data/results/NLR_annotation_all/${samplename}/${samplename}.fasta.chop.xml.nlr.bed

ln -s /ei/projects/d/d2ae02c8-84dc-443f-bd66-ff84969a0ed7/data/results/NLR_annotation_all/${samplename}/${samplename}.fasta.chop.xml.nlr.bed

cat ${samplename}.fasta.chop.xml.nlr.bed | grep 'chr' | tr ';' '\t'  | cut -f1,2,3,4 > ${samplename}.nlr.bed4

source bcftools-1.12
 
bcftools view -T ${samplename}.nlr.bed4 ../concat_QUAL100_DP10-300.vcf.gz > SNP_NLR_extraction_${samplename}_QUAL100_DP10_300.vcf
 
bcftools stats -s - SNP_NLR_extraction_${samplename}_QUAL100_DP10-300.vcf > SNP_NLR_extraction_${samplename}_QUAL100_DP10_300.stats.txt