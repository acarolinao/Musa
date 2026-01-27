#!/bin/bash -e
#SBATCH -p ei-short -c 1 --mem 50G -J NLR-chopping
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address

genome=$1
source jre-8u241
source NLR_annotator-20200428

cd ${genome}/

## chopping

 mkdir -p _NLR_annotator/NLR_annotator_spades/
 java -jar /ei/software/testing/NLR_annotator/20200428/x86_64/bin/ChopSequence.jar \
 -i _assemblies/${genome}_spades_out*/scaffolds.fa* -o _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop

___________________________________
#!/bin/bash -e
#SBATCH -p ei-medium -c 2 --mem 100G -J NLR-parser
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address

## parser
# for spades chopped reads
java -jar /ei/software/testing/NLR_annotator/20200428/x86_64/bin/NLR-Parser3.jar \
-t 16 -y /ei/software/testing/meme/5.0.1/x86_64/bin/mast \
-x /ei/software/testing/NLR_annotator/20200428/x86_64/bin/meme.xml \
-i _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop -c _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml

___________________________________
#!/bin/bash -e
#SBATCH -p ei-medium -c 2 --mem 50G -J NLR-annotator
#SBATCH --mail-type=ALL # notifications for job done & fail
#SBATCH --mail-user=carolina.olave-achury@earlham.ac.uk # send-to address

## NLR-annotator

# for spades aligment
java -jar /ei/software/testing/NLR_annotator/20200428/x86_64/bin/NLR-Annotator.jar \
-i _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml -o _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml.nlr.txt \
-g _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml.nlr.gff -b _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml.nlr.bed \
-m _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml.nlr.motifs.bed \
-a _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml.nlr.output.nbarkMotifAlignment.fasta \
-f _assemblies/${genome}_spades_out*/scaffolds.fa* _NLR_annotator/NLR_annotator_spades/${genome}_spades.fasta.chop.xml.nlr.fasta_flanking 5000 flanking
