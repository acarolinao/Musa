#!/bin/bash
#SBATCH -p ei-long #ei-long
#SBATCH -c 1 --mem 100G
#SBATCH -J STRUCTURE
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address
#SBATCH --array=0-9
 
#1> tells the computer to kindly pipe the standard output into whatever file you tell it.
#changes done from kates email ()
samplename=$1
cd ${samplename} 

source Structure-2.3.5

K=(2 3 4 5 6 7 8 9 10)
 
for ((i=1; i<=20; i++))
do
echo Beginning loop K=${K[${SLURM_ARRAY_TASK_ID}]}_${i}
structure -K ${K[${SLURM_ARRAY_TASK_ID}]} -o results/K${K[${SLURM_ARRAY_TASK_ID}]}_R${i} 1> ${K[${SLURM_ARRAY_TASK_ID}]}_${i}_structure.log
done