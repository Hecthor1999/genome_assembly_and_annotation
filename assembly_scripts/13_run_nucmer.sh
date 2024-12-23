#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/mum_%j.err                                                                                                        
#SBATCH --out=log/mum_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=mummer                                                                                                              
#SBATCH --time=40:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs nucmer to compare the assembled genomes hifiasm and LJA against the Arabidopsis thaliana reference and against each other.

# go to the correct directory and create the working directory
WORKDIR="/data/users/harribas/assembly_course"
cd $WORKDIR
mkdir -p genome_comparison
cd genome_comparison

# create a log directory
mkdir -p ${WORKDIR}/genome_comparison/log

# Define variables
REFERENCE="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
HIFI_ASSEMBLY="$WORKDIR/assembly/results_hifiasm/ERR11437324.fa"  
FLYE_ASSEMBLY="${WORKDIR}/assembly/results_fly/assembly.fasta"
LJA_ASSEMBLY="${WORKDIR}/assembly/results_LJA/assembly.fasta"

# run the container and run nucmer on the hifiasm assembly
apptainer exec \
--bind ${WORKDIR}/genome_comparison \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer  -p hifiasm -b 1000 -c 1000 $REFERENCE  $HIFI_ASSEMBLY

# run the container and run nucmer on the hifiasm assembly
apptainer exec \
--bind ${WORKDIR}/genome_comparison \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer  -p flye -b 1000 -c 1000 $REFERENCE  $FLYE_ASSEMBLY

# run the container and run nucmer on the hifiasm assembly
apptainer exec \
--bind ${WORKDIR}/genome_comparison \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer  -p LJA  -b 1000 -c 1000 $REFERENCE  $LJA_ASSEMBLY

