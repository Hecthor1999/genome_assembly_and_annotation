#!/usr/bin/env bash

#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/te_age_%j.err                                                                                                        
#SBATCH --out=log/te_age_%j.out                                                                                                          
#SBATCH --mem=50G                                                                                                                        
#SBATCH --job-name=te_age_estimate                                                                                                              
#SBATCH --time=20:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                  
#SBATCH --cpus-per-task=20

# this script uses the given perl script to to process the raw alignment outputs from RepeatMasker.
# This script calculates the corrected percentage of divergence of each TE copy from its consensus
# sequence. It accounts for the extremely high mutation rate at CpG sites, providing a more accurate estimate of divergence. 

# variables
WORKDIR="/data/users/harribas/assembly_course/annotation/output/EDTA_annotation/assembly.fasta.mod.EDTA.anno"
SCRIPT="/data/users/harribas/assembly_course/annotation/scripts"
genome="assembly.fasta"

# load the perl module
module add BioPerl/1.7.8-GCCcore-10.3.0

# run the script
perl $SCRIPT/05-parseRM.pl -i $WORKDIR/$genome.mod.out -l 50,1 -v


