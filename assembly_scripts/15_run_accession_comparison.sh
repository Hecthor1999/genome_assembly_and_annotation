#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=genome_comp
#SBATCH --output=log/output_genome_comp_%j.o
#SBATCH --error=log/error_genome_comp_%j.e
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=16

cpus=16

WORKDIR=/data/users/harribas/assembly_course

my_assembly=$WORKDIR/assembly/results_fly/assembly.fasta
RESULTDIR=$WORKDIR/genome_comparison/accession_comparison

julian_flye=/data/users/tschiller/assembly_course/eval/genomes_comparison/genome_julian/flye.fasta
laura_flye=/data/users/tschiller/assembly_course/eval/genomes_comparison/genome_laura/flye.fasta
thomas_lja=/data/users/tschiller/assembly_course/assemblies/LJA/assembly.fasta

mkdir -p $RESULTDIR
cd $RESULTDIR

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix julian --breaklen 1000 --mincluster 1000 --threads $cpus $my_assembly $julian_flye 
#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix laura --breaklen 1000 --mincluster 1000 --threads $cpus $my_assembly $laura_flye 
#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix thomas --breaklen 1000 --mincluster 1000 --threads $cpus $my_assembly $thomas_lja 

#mummer

apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $my_assembly -Q $julian_flye -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/julian  julian.delta
apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $my_assembly -Q $laura_flye -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/laura  laura.delta
apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $my_assembly -Q $thomas_lja -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/thomas  thomas.delta
