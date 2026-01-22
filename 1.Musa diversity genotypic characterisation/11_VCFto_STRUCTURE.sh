#!/bin/bash -e
#SBATCH -p ei-medium #ei-medium
#SBATCH -c 1 --mem 50G
#SBATCH -J VCFtoSTRUCTURE
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address

#at the folder where the SNP call is, the sbatch entry is the name of the folder where STRUCTURE will be run
samplename=$1

cd ${samplename}/

# convert to structure format less than 30000 SNPs
source jre-7.11

#29 march 2023 change output file name end from DP10-300.txt to DP10_300.txt (bebore it was looking it was not recognice one file but maybe two-different format)

java -Xmx16g -Xms16g -jar /tgac/software/testing/pgdspider/2.1.1.2/x86_64/bin/PGDSpider2-cli.jar \
-inputfile concat_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN50.vcf.gz \
-outputfile STRUCTURE_SNP_WG_concat_QUAL100_DP10_300_MISS3_BIALLELICSNPS_MAF01_THIN50.txt \
-spid vcfTOstructure.spid

mv STRUCTURE_SNP_WG_concat_QUAL100_DP10_300_MISS3_BIALLELICSNPS_MAF01_THIN50.txt STRUCTURE_WG_QUAL100_DP10-300_MISS3_BIALLELICSNPS_MAF01_THIN50/.