#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/fly_%j.err                                                                                                        
#SBATCH --out=log/fly_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=fly                                                                                                              
#SBATCH --time=40:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs fly on pacBio hifi reads

# define variables
WORKDIR="/data/users/harribas/assembly_course/raw_data/Altai-5"
OUTDIR="/data/users/harribas/assembly_course/assembly"

# make log file
mkdir -p log

# make results folder
mkdir -p results_fly

# load container
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi ${WORKDIR}/ERR11437324.fastq.gz --out-dir ${OUTDIR}/results_fly
