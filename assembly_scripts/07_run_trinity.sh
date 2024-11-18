#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --error=log/trinity_%j.err
#SBATCH --out=log/trinity_%j.out
#SBATCH --mem=64G
#SBATCH --job-name=trinity                                                                                                          
#SBATCH --time=1-00:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs trinity on RNA reads

# define variables
WORKDIR="/data/users/harribas/assembly_course/trimming"
OUTDIR="/data/users/harribas/assembly_course/assembly"

# make log file
mkdir -p log

# make results folder
mkdir -p results_trinity

# load module
module load Trinity/2.15.1-foss-2021a

# run program
Trinity --seqType fq --left ${WORKDIR}/ERR754081_1_trimmed.fastq.gz --right ${WORKDIR}/ERR754081_2_trimmed.fastq.gz --CPU 16 --max_memory 64G --output ${OUTDIR}/results_trinity