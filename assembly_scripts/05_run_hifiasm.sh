#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/hifiasm_%j.err                                                                                                        
#SBATCH --out=log/hifiasm_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=hifiasm                                                                                                              
#SBATCH --time=1-00:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs hifiasm  on pacBio hifi reads

# define variables
WORKDIR="/data/users/harribas/assembly_course/raw_data/Altai-5"
OUTDIR="/data/users/harribas/assembly_course/assembly"

# make log file
mkdir -p log

# make results folder
mkdir -p results_hifiasm

# load container
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/hifiasm_0.19.8.sif \
hifiasm -o ERR11437324.gfa -t 64 ${WORKDIR}/ERR11437324.fastq.gz

# convert to fasta file
awk '/^S/{print ">"$2;print $3}' ERR11437324.gfa.bp.p_ctg.gfa > ERR11437324.fa
