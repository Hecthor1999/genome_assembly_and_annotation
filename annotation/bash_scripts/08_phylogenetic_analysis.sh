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

# before running this script, first get_color_list has to be run and the templates from https://itol.embl.de/help/dataset_color_strip_template.txt and https://itol.embl.de/help/dataset_simplebar_template.txt
# need to be downloaded and placed in the outdir.

TE_DIR="/data/users/harribas/assembly_course/annotation/output/te_sorter"
OUTDIR="/data/users/harribas/assembly_course/annotation/output/phylo_analysis"
DB_DIR="/data/courses/assembly-annotation-course/CDS_annotation/data"

cd $OUTDIR

# load module
module load SeqKit/2.6.1


grep Ty1-RT $OUTDIR/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa > $OUTDIR/copia_brass_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/copia_brass_list.txt #remove ">" from the header 
sed -i 's/ .\+//' $OUTDIR/copia_brass_list.txt #remove all characters following "empty space" from the header 
seqkit grep -f $OUTDIR/copia_brass_list.txt $OUTDIR/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa -o Copia_brassica_RT.fasta

grep Ty3-RT $OUTDIR/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa > $OUTDIR/gypsy_brass_list.txt #make a list of RT proteins to extract 
sed -i 's/>//' $OUTDIR/gypsy_brass_list.txt #remove ">" from the header 
sed -i 's/ .\+//' $OUTDIR/gypsy_brass_list.txt #remove all characters following "empty space" from the header 
seqkit grep -f $OUTDIR/gypsy_brass_list.txt $OUTDIR/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa -o Gypsy_brassica_RT.fasta

module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0

# Concatenate brasicaceae and arabidopsis
cat $OUTDIR/Copia_RT.fasta $OUTDIR/Copia_brassica_RT.fasta > $OUTDIR/Concat_Copia_RT.fasta
cat $OUTDIR/Gypsy_RT.fasta $OUTDIR/Gypsy_brassica_RT.fasta > $OUTDIR/Concat_Gypsy_RT.fasta

# Shorten identifiers
sed -i 's/#.\+//' $OUTDIR/Concat_Copia_RT.fasta 
sed -i 's/:/_/g' $OUTDIR/Concat_Copia_RT.fasta 

sed -i 's/#.\+//' $OUTDIR/Concat_Gypsy_RT.fasta 
sed -i 's/:/_/g' $OUTDIR/Concat_Gypsy_RT.fasta 

# Target headers that have complex annotations and remove everything after the first space
sed -i '/^>/ s/[ |;].*//' $OUTDIR/Concat_Copia_RT.fasta
sed -i '/^>/ s/[ |;].*//' $OUTDIR/Concat_Gypsy_RT.fasta

clustalo -i $OUTDIR/Concat_Copia_RT.fasta -o $OUTDIR/Copia_RT_aligned.fasta --outfmt=fasta --force
clustalo -i $OUTDIR/Concat_Gypsy_RT.fasta -o $OUTDIR/Gypsy_RT_aligned.fasta --outfmt=fasta --force

# FastTree to build phylogenetic trees
FastTree -out $OUTDIR/Copia_RT_tree $OUTDIR/Copia_RT_aligned.fasta
FastTree -out $OUTDIR/Gypsy_RT_tree $OUTDIR/Gypsy_RT_aligned.fasta

# annotate the tree
# download the templates from https://itol.embl.de/help/dataset_color_strip_template.txt and https://itol.embl.de/help/dataset_simplebar_template.txt
# create two copies of the templates
cp dataset_color_strip_template.txt ./dataset_color_strip_gypsy.txt
mv dataset_color_strip_template.txt ./dataset_color_strip_copia.txt

# by using the 10_get_color_list script and appending the data to the downloaded dataset_color_strip_template.txt for gypsy
for file in $OUTDIR/copia_colors/*; 
do cat $file >> dataset_color_strip_copia.txt;
done

for file in $OUTDIR/gypsy_colors/*; 
do cat $file >> dataset_color_strip_gypsy.txt;
done

# append the data extracted from $genome.mod.EDTA.TEanno.sum for gypsy and copia
grep "TE"  assembly.fasta.mod.EDTA.TEanno.sum | tail -n+2 | tr -d '"' |  awk '{print $1","$2}' >> $OUTDIR/dataset_simplebar_template.txt 




