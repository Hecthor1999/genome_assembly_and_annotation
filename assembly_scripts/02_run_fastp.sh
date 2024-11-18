#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --error=log/fastp_%j.err
#SBATCH --out=log/fastp_%j.out
#SBATCH --mem=20G
#SBATCH --job-name=fastp
#SBATCH --time=01:00:00
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --cpus-per-task=2

# This script runs fastp which trims the low quality reads from the data

# load module
module load fastp/0.23.4-GCC-10.3.0

#variables
HIFI_INPUT="/data/courses/assembly-annotation-course/raw_data/Altai-5/ERR11437324.fastq.gz"
RNA_INPUT="/data/users/harribas/assembly_course/raw_data/RNAseq_Sha"
OUTPUT="/data/users/harribas/assembly_course/trimming"

# make a log directory

mkdir -p "/data/users/harribas/assembly_course/trimming/log"

# run fastp on pacbio hifi reads without trimming anything to obtain the total number of bases
# fastp -i $HIFI_INPUT -o $OUTPUT 

# run fastp on rnaseq data
fastp -q 20 -i "${RNA_INPUT}/ERR754081_1.fastq.gz" -I "${RNA_INPUT}/ERR754081_2.fastq.gz" -o "${OUTPUT}/ERR754081_1_trimmed.fastq.gz" -O "${OUTPUT}/ERR754081_2_trimmed.fastq.gz"

