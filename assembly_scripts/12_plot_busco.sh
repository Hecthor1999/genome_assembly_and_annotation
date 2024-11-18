#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=busco
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=output_plot_busco_%j.out
#SBATCH --error=error_plot_busco_%j.err

# This script produces the busco plots for comparison between the assemblies


# set variables
ASSEMBLY_HIFIASM=/data/users/harribas/assembly_course/assembly_eval/results_busco/busco_hifiasm/short_summary.specific.brassicales_odb10.busco_hifiasm.txt
ASSEMBLY_LJA=/data/users/harribas/assembly_course/assembly_eval/results_busco/busco_LJA/short_summary.specific.brassicales_odb10.busco_lja.txt
ASSEMBLY_FLYE=/data/users/harribas/assembly_course/assembly_eval/results_busco/busco_flye/short_summary.specific.brassicales_odb10.busco_flye.txt
ASSEMBLY_TRINITY=/data/users/harribas/assembly_course/assembly_eval/results_busco/busco_trinity/short_summary.specific.brassicales_odb10.busco_trinity.txt
OUT_DIR=/data/users/harribas/assembly_course/assembly_eval/results_busco/plot
CONTAINER_SIF=/containers/apptainer/busco_5.7.1.sif

# create directory if not available
mkdir -p $OUT_DIR && cd $OUT_DIR

# copy all summaries into my output directory 
cp $ASSEMBLY_FLYE .
cp $ASSEMBLY_LJA .
cp $ASSEMBLY_HIFIASM .
cp $ASSEMBLY_TRINITY .

# generate plots
apptainer exec\
 --bind $OUT_DIR\
  $CONTAINER_SIF\
  generate_plot.py -wd $OUT_DIR
