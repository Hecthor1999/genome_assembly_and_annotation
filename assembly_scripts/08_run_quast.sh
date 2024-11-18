#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --error=log/quast_%j.err
#SBATCH --out=log/quast_%j.out
#SBATCH --mem=64G
#SBATCH --job-name=quast
#SBATCH --time=10:00:00
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --cpus-per-task=16

# This script runs quast on the assemblies to assess their quality 

# create necessary directories
mkdir -p log
mkdir -p results_quast

# define variables
WORKDIR="/data/users/harribas/assembly_course"
OUTDIR="${WORKDIR}/assembly_eval/results_quast"
REFERENCE="/data/courses/assembly-annotation-course/references"

# load and execute container, running quast with and without the reference
apptainer exec \
  --bind /data \
  /containers/apptainer/quast_5.2.0.sif \
  bash -c "
    # run quast with the reference
    quast $WORKDIR/assembly/results_fly/assembly.fasta \
    $WORKDIR/assembly/results_hifiasm/ERR11437324.fa \
    $WORKDIR/assembly/results_LJA/assembly.fasta \
    -o $OUTDIR/results_quast_reference \
    -r $REFERENCE/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
    -g $REFERENCE/TAIR10_GFF3_genes.gff \
    -t 16 -e --labels 'flye_r, hifiasm_r, LJA_r' "

apptainer exec \
  --bind /data \
  /containers/apptainer/quast_5.2.0.sif \
  bash -c "
    # run quast without the reference
    quast $WORKDIR/assembly/results_fly/assembly.fasta \
    $WORKDIR/assembly/results_hifiasm/ERR11437324.fa \
    $WORKDIR/assembly/results_LJA/assembly.fasta \
    -o $OUTDIR/results_quast_noreference \
    -t 16 -e --labels 'flye_nr, hifiasm_nr, LJA_nr' "
  



