#!/bin/bash
#SBATCH --time=1-0
#SBATCH --mem=64G
#SBATCH -p pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=Omark
#Sbatch --output=/data/users/harribas/assembly_course/annotation/scripts/log/OMArk_%j.out
#Sbatch --error=/data/users/harribas/assembly_course/annotation/scripts/log/OMArk_%j.err

module load SeqKit/2.6.1

WORKDIR="/data/users/harribas/assembly_course/annotation/scripts"
MINIPROTDIR="/data/users/harribas/assembly_course/annotation/output"

# Download the Orthologs of fragmented and missing genes from OMArk database
# conda activate OMArk in an interactive job


python omark_contextualize.py fragment -m $WORKDIR/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer -o omark_output -f fragment_HOGs
python omark_contextualize.py missing -m $WORKDIR/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer -o omark_output -f missing_HOGs 

cd $MINIPROTDIR

GENOME="/data/users/harribas/assembly_course/assembly/results_fly/assembly.fasta"
SEQ_FASTA="/data/users/harribas/assembly_course/annotation/scripts/fragment_HOGs"
MINIPROT_OUT="miniprot_out.gff"

$MINIPROTDIR/miniprot -I --gff --outs=0.95 $GENOME $SEQ_FASTA > $MINIPROT_OUT





