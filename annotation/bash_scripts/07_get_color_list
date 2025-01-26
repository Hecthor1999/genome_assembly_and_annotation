#!/usr/bin/env bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --time=2:00:00
#SBATCH --job-name=get_colors
#SBATCH --output=log/output_colors2_%j.o
#SBATCH --error=log/error_colors2_%j.e
#SBATCH --partition=pibu_el8

TE_DIR=/data/users/harribas/assembly_course/annotation/output/te_sorter
OUTDIR1=/data/users/harribas/assembly_course/annotation/output/phylo_analysis/gypsy_colors
OUTDIR2=/data/users/harribas/assembly_course/annotation/output/phylo_analysis/copia_colors

GYPSY=/data/users/harribas/assembly_course/annotation/output/phylo_analysis/Gypsy_Brassicaceae.fa.rexdb-plant.cls.tsv
COPIA=/data/users/harribas/assembly_course/annotation/output/phylo_analysis/Copia_Brassicaceae.fa.rexdb-plant.cls.tsv
GYPSY_ARAB=$TE_DIR/Gypsy_sequences.fa.rexdb-plant.cls.tsv
COPIA_ARAB=$TE_DIR/Copia_sequences.fa.rexdb-plant.cls.tsv



mkdir -p $OUTDIR1
mkdir -p $OUTDIR2


cd $OUTDIR1

# gypsy clades
# for brassicacea family
grep -e "Retand" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF0000 Retand/' > Retand_ID.txt 
grep -e "Athila" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Athila/' > Athila_ID.txt 
grep -e "CRM" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF CRM/' > CRM_ID.txt 
grep -e "Reina" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Reina/' > Reina_ID.txt 
grep -e "Tekay" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Tekay/' > Tekay_ID.txt 
grep -e "Galadriel" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #008080 Galadriel/' > Galadriel_ID.txt 
grep -e "unknown" $GYPSY | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 unknown/' > unknown_ID.txt 

# for arabidopsis
grep -e "Retand" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF0000 Retand/' >> Retand_ID.txt 
grep -e "Athila" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Athila/' >> Athila_ID.txt 
grep -e "CRM" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF CRM/' >> CRM_ID.txt 
grep -e "Reina" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Reina/' >> Reina_ID.txt 
grep -e "Tekay" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Tekay/' >> Tekay_ID.txt 
grep -e "Galadriel" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #008080 Galadriel/' >> Galadriel_ID.txt 
grep -e "unknown" $GYPSY_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 unknown/' >> unknown_ID.txt 


cd $OUTDIR2

# copia clades
# for brassicacea family
grep -e "Ale" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF6347 Ale/' > Ale_ID.txt 
grep -e "Alesia" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Alesia/' > Alesia_ID.txt 
grep -e "Angela" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF Angela/' > Angela_ID.txt 
grep -e "Bianca" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Bianca/' > Bianca_ID.txt 
grep -e "Ikeros" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Ikeros/' > Ikeros_ID.txt 
grep -e "Ivana" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 Ivana/' > Ivana_ID.txt 
grep -e "SIRE" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFD700 SIRE/' > SIRE_ID.txt 
grep -e "TAR" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00CED1 TAR/' > TAR_ID.txt 
grep -e "Tork" $COPIA | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF1493 Tork/' > Tork_ID.txt

# for arabidopsis
grep -e "Ale" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF6347 Ale/' >> Ale_ID.txt 
grep -e "Alesia" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00FF00 Alesia/' >> Alesia_ID.txt 
grep -e "Angela" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #0000FF Angela/' >> Angela_ID.txt 
grep -e "Bianca" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFA500 Bianca/' >> Bianca_ID.txt 
grep -e "Ikeros" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #800080 Ikeros/' >> Ikeros_ID.txt 
grep -e "Ivana" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #808080 Ivana/' >> Ivana_ID.txt 
grep -e "SIRE" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FFD700 SIRE/' >> SIRE_ID.txt 
grep -e "TAR" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #00CED1 TAR/' >> TAR_ID.txt 
grep -e "Tork" $COPIA_ARAB | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed 's/$/ #FF1493 Tork/' >> Tork_ID.txt
