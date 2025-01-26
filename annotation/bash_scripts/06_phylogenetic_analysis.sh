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

cd $OUTDIR

# load module
module load SeqKit/2.6.1


# Obtain copia and gypsy for brasicacea
# seqkit grep -n -r -p "Copia" $DB_DIR/Brassicaceae_repbase_all_march2019.fasta > $OUTDIR/Copia_Brassicaceae.fa
# seqkit grep -n -r -p "Gypsy" $DB_DIR/Brassicaceae_repbase_all_march2019.fasta > $OUTDIR/Gypsy_Brassicaceae.fa

# repeat tesorter for brassicacea
apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
TEsorter $DB_DIR/Brassicaceae_repbase_all_march2019.fasta -db rexdb-plant 

