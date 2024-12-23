#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=TEsorter
#SBATCH --partition=pibu_el8

# This script runs TEsorter
# to classify transposable elements (TEs) based on their protein domains.
# The goal of this script is to obtain the file assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv
# which is required to extract the LTR identity percentage 

# variables
WORKDIR=/data/users/harribas/assembly_course/annotation/output/EDTA_annotation
CONTAINER_DIR=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif

# got to wd
cd $WORKDIR

# run container with TEsorter
apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
--writable-tmpfs -u $CONTAINER_DIR TEsorter /data/users/harribas/assembly_course/annotation/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.intact.fa \
-db rexdb-plant
