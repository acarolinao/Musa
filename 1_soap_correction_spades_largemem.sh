#!/bin/bash
#SBATCH -p ei-largemem #ei-largemem
#SBATCH -c 16 --mem 1300G
#SBATCH -J SPAdes_asssembly
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --constraint=intel # to avoid problematic nodes


#1. move soap correction tmp_* files from masurca folder or create them
#2. move to soapcorrect_spades folder

samplename=$1
lines=$2
cd ${samplename}/${samplename}_${lines}_soapcorrect_spades_out_mem1200

source spades-3.15.3

spades.py -t 16 -m 1200 --isolate \
-1 tmp_1.fq.cor.pair_1.fq.gz \
-2 tmp_2.fq.cor.pair_2.fq.gz \
-o ${samplename}_${lines}_soapcorrect_spades_out_mem1200