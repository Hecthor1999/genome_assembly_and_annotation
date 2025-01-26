#!/usr/bin/env bash

#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/phylo_%j.err                                                                                                        
#SBATCH --out=log/phylo_%j.out                                                                                                          
#SBATCH --mem=50G                                                                                                                        
#SBATCH --job-name=phylo                                                                                                              
#SBATCH --time=20:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                  
#SBATCH --cpus-per-task=20

TE_DIR="/data/users/harribas/assembly_course/annotation/output/te_sorter"
OUTDIR="/data/users/harribas/assembly_course/annotation/output/phylo_analysis"
DB_DIR="/data/courses/assembly-annotation-course/CDS_annotation/data"

mkdir -p $OUTDIR

cd $OUTDIR

# load module
module load SeqKit/2.6.1

# for copia
grep Ty1-RT "$TE_DIR/Copia_sequences.fa.rexdb-plant.dom.faa" > $TE_DIR/copia_protein_list.txt #make a list of RT proteins to extract
sed -i 's/>//' $TE_DIR/copia_protein_list.txt #remove ">" from the header
sed -i 's/ .\+//' $TE_DIR/copia_protein_list.txt #remove all characters following "empty space" from the header
seqkit grep -f $TE_DIR/copia_protein_list.txt "$TE_DIR/Copia_sequences.fa.rexdb-plant.dom.faa" -o $OUTDIR/Copia_RT.fasta

# for gypsy
grep Ty3-RT "$TE_DIR/Gypsy_sequences.fa.rexdb-plant.dom.faa" > $TE_DIR/gypsy_protein_list.txt #make a list of RT proteins to extract
sed -i 's/>//' $TE_DIR/gypsy_protein_list.txt #remove ">" from the header
sed -i 's/ .\+//' $TE_DIR/gypsy_protein_list.txt #remove all characters following "empty space" from the header
seqkit grep -f $TE_DIR/gypsy_protein_list.txt "$TE_DIR/Gypsy_sequences.fa.rexdb-plant.dom.faa" -o $OUTDIR/Gypsy_RT.fasta
