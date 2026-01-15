#!/bin/bash -e
#SBATCH -p ei-largemem #ei-largemem
#SBATCH -c 64 --mem 1T  #before c 64 1T 
#SBATCH -J masurca
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH -t 6-00:00 # time (D-HH:MM) #time limit added for hpc works

samplename=$1
cd ${samplename}
mkdir -p ${samplename}_masurca_largemem_singularity 
cd ${samplename}_masurca_largemem_singularity 

#run by steps: It seems that the different memory requirements was making the script to fail
#1. generate a single file and unzip -> unzip needed for the correction step

#zcat ../R0069*val_1.fq.gz > tmp_1.fq
#zcat ../R0069*val_2.fq.gz > tmp_2.fq 

#2.create a input
#echo "tmp_1.fq" > input.txt
#echo "tmp_2.fq" >> input.txt

#2. soap correction
#source soap_corrector-1.0
#KmerFreq_AR -t 32 input.txt
#Corrector_AR -t 32 -l 10 output.freq.cz output.freq.cz.len input.txt > corr.log 2> corr.err

#3. run masurca
source masurca-4.1.0_CBG
masurca -t 64 -i tmp_1.fq.cor.pair_1.fq.gz,tmp_2.fq.cor.pair_2.fq.gz

#3.1- 2 august 2023: the above command is with an error if image location, use the singularity of masurca bellow
#singularity exec /ei/software/testing/masurca/4.1.0/masurca-4.1.0.img masurca -t 64 -i tmp_1.fq.cor.pair_1.fq.gz,tmp_2.fq.cor.pair_2.fq.gz
#if masurca stays running several days (more than 2 weeks) check if the error is in the gap closing, if is there open read and execute masurca_restart.sh