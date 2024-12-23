#!/usr/bin/env bash

#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/EDTA_%j.err                                                                                                        
#SBATCH --out=log/EDTA_%j.out                                                                                                          
#SBATCH --mem=50G                                                                                                                        
#SBATCH --job-name=edta                                                                                                              
#SBATCH --time=20:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=20

# This is a script to run EDTA
# EDTA (Extensive de novo TE Annotator) is a pipeline designed for the annotation of both structurally
# intact and fragmented transposable elements (TEs). It generates a non-redundant TE library, classifies the
# elements into superfamilies, and outputs detailed annotations for whole-genome TE studies.

# create  and go to working directory
WORKDIR=/data/users/harribas/assembly_course/annotation
mkdir -p $WORKDIR/output/EDTA_annotation
cd $WORKDIR/output/EDTA_annotation

# Use singularity container to run EDTA
apptainer exec -C -H $WORKDIR -H ${pwd}:/work \
--writable-tmpfs -u /data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome "/data/users/harribas/assembly_course/assembly/results_fly/assembly.fasta" --species others --step all --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" --anno 1 --threads 20 

# EDTA parameters 

# --genome /data/users/harribas/assembly_course/assembly/results_fly/assembly.fasta \ # The genome FASTA file
# --species others \ # Specify 'others' for non Rice or Maize genomes
# --step all \ # Run all steps of TE annotation
# --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \ # CDS file for gene masking
# --anno 1 \ # Perform whole-genome TE annotation
# --threads 20 # Number of threads for multi-core processing (default: 4)


# use this command on the gff3 file to obtain the clades and the percent identity of the LTRs, finally download and plot histograms in R
#  awk -F ';' '/ltr_identity=/ {print $4  $6}'  assembly.fasta.mod.LTR.intact.gff3 | grep 'Classification' | sed 's/Classification=/ /' | sed 's/ltr_identity=/ /' >> clade_indentityPercentage.txt

