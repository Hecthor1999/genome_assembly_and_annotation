#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/mummer_%j.err                                                                                                        
#SBATCH --out=log/mummer_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=mummer                                                                                                              
#SBATCH --time=40:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs mummerplot to obtain the dotplots from the assembled hifiasm,LJA and flye genomes against the Arabidopsis thaliana reference and against each other.

# go to the correct working directory
WORKDIR="/data/users/harribas/assembly_course"
cd $WORKDIR

# define paths
REFERENCE="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
HIFI_ASSEMBLY="$WORKDIR/assembly/results_hifiasm/ERR11437324.fa"  
FLYE_ASSEMBLY="${WORKDIR}/assembly/results_fly/assembly.fasta"
LJA_ASSEMBLY="${WORKDIR}/assembly/results_LJA/assembly.fasta"

# run the container and run mummerplot on the hifiasm nucmer output
apptainer exec \
--bind ${WORKDIR}/genome_comparison \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REFERENCE -Q $HIFI_ASSEMBLY --filter ${WORKDIR}/genome_comparison/hifiasm.delta -t png --large --layout --fat -p ${WORKDIR}/genome_comparison/hifiasm_plot


# run the container and run mummerplot on the flye nucmer output
apptainer exec \
--bind ${WORKDIR}/genome_comparison \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REFERENCE -Q $FLYE_ASSEMBLY --filter ${WORKDIR}/genome_comparison/flye.delta -t png --large --layout --fat -p ${WORKDIR}/genome_comparison/flye_plot

# run the container and run mummerplot on the LJA nucmer output
apptainer exec \
--bind ${WORKDIR}/genome_comparison \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REFERENCE -Q $LJA_ASSEMBLY --filter ${WORKDIR}/genome_comparison/LJA.delta -t png --large --layout --fat -p ${WORKDIR}/genome_comparison/LJA_plot

