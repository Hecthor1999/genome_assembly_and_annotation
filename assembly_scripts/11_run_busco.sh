#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/busco_%j.err                                                                                                        
#SBATCH --out=log/busco_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=busco                                                                                                              
#SBATCH --time=10:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs busco on the assemblies

# define variables
WORKDIR="/data/users/harribas/assembly_course"
OUTDIR="${WORKDIR}/assembly_eval/results_busco"
DATASET_DIR="${OUTDIR}/dataset"

# make log file
mkdir -p log

# make results file
mkdir -p results_busco

# load module 
module load BUSCO/5.4.2-foss-2021a

# run busco on the genomic data
mkdir -p ${OUTDIR}/busco_flye
busco -i "${WORKDIR}/assembly/results_fly/assembly.fasta" --out "results_busco/busco_flye" --mode genome --download_path ${OUTDIR}/busco_downloads --lineage brassicales_odb10 --cpu 16 --force

mkdir -p ${OUTDIR}/busco_hifiasm
busco -i "${WORKDIR}/assembly/results_hifiasm/ERR11437324.fa" --out "results_busco/busco_hifiasm" --mode genome --download_path ${OUTDIR}/busco_downloads --lineage brassicales_odb10 --cpu 16 --force

mkdir -p ${OUTDIR}/busco_LJA
busco -i "${WORKDIR}/assembly/results_LJA/assembly.fasta" --out "results_busco/busco_LJA" --mode genome --download_path ${OUTDIR}/busco_downloads --lineage brassicales_odb10 --cpu 16 --force

# run busco on the transcriptomic data
mkdir -p ${OUTDIR}/busco_trinity
busco -i "${WORKDIR}/assembly/results_trinity/results_trinity.Trinity.fasta" --out "${OUTDIR}/busco_trinity" --mode transcriptome --download_path ${OUTDIR}/busco_downloads --lineage brassicales_odb10 --cpu 16 --force