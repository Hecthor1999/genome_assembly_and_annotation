#!/usr/bin/env bash                                                                                                                              

#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/meryl_%j.err                                                                                                        
#SBATCH --out=log/meryl_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=merqury                                                                                                              
#SBATCH --time=05:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs merquery to find the best kmer size and to build kmer dbs with meryl

mkdir -p log

# define variables
WORKDIR="/data/users/harribas/assembly_course"
MERQURY="/usr/local/share/merqury"

# create directory for merqury
mkdir -p merqury

# run container with merqury
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
sh $MERQURY/best_k.sh 137720847

# best kmer size is 18.5008 ~ 19
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
meryl k=19 count $WORKDIR/raw_data/ERR11437324.fastq.gz output $WORKDIR/assembly_eval/merqury/genome.meryl \
memory=64g
