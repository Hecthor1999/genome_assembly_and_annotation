#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --error=log/fastqc_%j.err
#SBATCH --out=log/fastqc_%j.out
#SBATCH --mem=20G
#SBATCH --job-name=fastqc
#SBATCH --time=01:00:00
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --cpus-per-task=2

# This script run the tool fastQC to obtain the quality summary of the data we are working with
WORKDIR="/data/users/harribas/assembly_course"
mkdir -p ${WORKDIR}/fastQC

# variables
HIFI_PATH="/data/courses/assembly-annotation-course/raw_data/Altai-5/ERR11437324.fastq.gz"
RNA_PATH="/data/users/harribas/assembly_course/raw_data/RNAseq_Sha"
OUTPUT_PATH="/data/users/harribas/assembly_course/fastQC/"

# create a log directory
mkdir -p /data/users/harribas/assembly_course/fastQC/log

# load fastqc
module load FastQC/0.11.9-Java-11

# run the program for pacbio
fastqc --extract ${HIFI_PATH} -o ${OUTPUT_PATH}

#run the program for RNAseq
fastqc --extract "${RNA_PATH}/ERR754081_1.fastq.gz" "${RNA_PATH}/ERR754081_2.fastq.gz" -o ${OUTPUT_PATH}
