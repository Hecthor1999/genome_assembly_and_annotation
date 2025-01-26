#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=blast
#Sbatch --output=log/blast_%j.out
#Sbatch --error=log/blast_%j.err

# load modules
module load BLAST+/2.15.0-gompi-2021a

# set variables
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/harribas/assembly_course/annotation/output/final"
protein="assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
gff="filtered.genes.renamed.gff3"
MAKERBIN="/data/courses/assembly-annotation-course/CDS_annotation/softwares/Maker_v3.01.03/src/bin/"
uniprot_fasta="/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa"

# Go to working directory
cd $WORKDIR

# Sequence homology to functionally validated proteins (UniProt database)
# first step is already done
# makeblastb -in <uniprot_fasta> -dbtype prot # this step is already done
# https://www.homd.org/help/help-page?pagecode=blast/advanced for all blastp options
blastp -query $protein -db $uniprot_fasta -num_threads 10 -outfmt 6 -evalue 1e-10 -out blastp_output.txt

# Map the protein putative functions to the MAKER produced GFF3 and FASTA files
cp $protein $protein.Uniprot
cp $gff $gff.Uniprot

$MAKERBIN/maker_functional_fasta $uniprot_fasta blastp_output.txt $protein > $protein.Uniprot
$MAKERBIN/maker_functional_gff $uniprot_fasta blastp_output.txt $gff > $gff.Uniprot.gff3

