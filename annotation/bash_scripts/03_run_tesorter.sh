#!/usr/bin/env bash

#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/tesorter_%j.err                                                                                                        
#SBATCH --out=log/tesorter_%j.out                                                                                                          
#SBATCH --mem=50G                                                                                                                        
#SBATCH --job-name=te_sorter                                                                                                              
#SBATCH --time=20:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=20

# This is a script to run TE_Sorter

# go to correct directory
cd /data/users/harribas/assembly_course/annotation/output

# mkae workind directory
mkdir -p te_sorter

WORKDIR=/data/users/harribas/assembly_course/annotation/output/te_sorter
DATADIR=/data/users/harribas/assembly_course/annotation/output/EDTA_annotation/assembly.fasta.mod.EDTA.final

# load module
module load SeqKit/2.6.1

# Extract Copia sequences
seqkit grep -r -p "Copia" $DATADIR/assembly.fasta.mod.EDTA.TElib.fa > $WORKDIR/Copia_sequences.fa
# Extract Gypsy sequences
seqkit grep -r -p "Gypsy" $DATADIR/assembly.fasta.mod.EDTA.TElib.fa >  $WORKDIR/Gypsy_sequences.fa

#run the container
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $WORKDIR/Copia_sequences.fa -db rexdb-plant
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $WORKDIR/Gypsy_sequences.fa -db rexdb-plant

#move the files into the te_sorter directory
mv Copia* ./te_sorter
mv Gypsy* ./te_sorter