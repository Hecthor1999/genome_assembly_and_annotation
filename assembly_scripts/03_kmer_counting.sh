#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --error=log/jelly_%j.err
#SBATCH --out=log/jelly_%j.out
#SBATCH --mem=20G
#SBATCH --job-name=kmer_count
#SBATCH --time=10:00:00
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --cpus-per-task=1

# This script runs jellyfish for kmer counting

# load module
module load Jellyfish/2.3.0-GCC-10.3.0

# variables
HIFI_INPUT="/data/courses/assembly-annotation-course/raw_data/Altai-5/ERR11437324.fastq.gz"
RNA_INPUT="/data/users/harribas/assembly_course/raw_data/RNAseq_Sha"
OUTPUT="/data/users/harribas/assembly_course/kmer_counting"

# make log file
mkdir -p "./log"

# Run program on hifi reads
jellyfish count -C -m 21 -s 1G -t 4 -o "${OUTPUT}/hifi_reads.jf" <(zcat ${HIFI_INPUT})
jellyfish histo -t 10 hifi_reads.jf > hifi_reads.histo


# Run program on RNA seq reads
jellyfish count -C -m 21 -s 1G -t 4 -o  "${OUTPUT}/RNA_reads.jf" \
 <(zcat "${RNA_INPUT}/ERR754081_1.fastq.gz")\
 <(zcat "${RNA_INPUT}/ERR754081_2.fastq.gz") 
jellyfish histo -t 10 RNA_reads.jf > rna_reads.histo 
