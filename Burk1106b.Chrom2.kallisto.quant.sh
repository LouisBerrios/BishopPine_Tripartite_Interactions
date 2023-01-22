#!/bin/bash

#This script performs pseudoalignment quantification with Kallisto
#Uses Kallisto which can be installed with conda <conda -install kallisto>
## https://pachterlab.github.io/kallisto/
## useful tutorial on kallisto @ https://github.com/griffithlab/rnaseq_tutorial/wiki/Kallisto

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#This script assumes your trimmed, demultiplexed input files are in subdirectry of the project folder, results_trimmed

#make directory for kallisto results

mkdir -p Burk1106b.Chrom2.results/kallisto/

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#run kallisto
 
#####
#if you haven't made an index uncomment the following script
#######

kallisto index -i BurkholderiaChrom2_index.idx burk1106b.chrom2.cds.fasta


#######
#once index is build next
#quantify reads using pseudoalignment
###

for FWD in $( find results_trimmed -name "*R1_trimmed.fastq.gz" )

do

REV=`echo $FWD | sed 's/R1_trimmed.fastq.gz/R2_trimmed.fastq.gz/'`    	

name=$(basename ${FWD} | sed 's/.R1_trimmed.fastq.gz//')
		
kallisto quant --index=BurkholderiaChrom2_index.idx --output-dir=Burk1106b.Chrom2.results/kallisto/${name} -b 100 --threads=4 $FWD $REV

done
