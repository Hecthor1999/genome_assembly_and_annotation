#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/LJA_%j.err                                                                                                        
#SBATCH --out=log/LJA_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=LJA                                                                                                              
#SBATCH --time=1-00:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs LJA  on pacBio hifi reads

# define variables
WORKDIR="/data/users/harribas/assembly_course/raw_data/Altai-5"
OUTDIR="/data/users/harribas/assembly_course/assembly"

# make log file
mkdir -p log

# make results folder
mkdir -p results_LJA

# load container
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/lja-0.2.sif \
lja -o ${OUTDIR}/results_LJA --reads ${WORKDIR}/ERR11437324.fastq.gz -t 16