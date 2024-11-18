#!/usr/bin/env bash                                                                                                                              
                                                                                                                                            
#SBATCH --partition=pibu_el8                                                                                                          
#SBATCH --error=log/merq_%j.err                                                                                                        
#SBATCH --out=log/merq_%j.out                                                                                                          
#SBATCH --mem=64G                                                                                                                        
#SBATCH --job-name=merqury                                                                                                              
#SBATCH --time=05:00:00                                                                                                                 
#SBATCH --mail-user=hector.arribasarias@students.unibe.ch                                             
#SBATCH --mail-type=end                                       
#SBATCH --cpus-per-task=16

# This script runs merqury on the assemblies

# define and export merqury variable
export MERQURY="/usr/local/share/merqury"

# define variables
WORKDIR="/data/users/harribas/assembly_course"
OUTDIR="${WORKDIR}/assembly_eval/results_merqury"
KMER_DB="$WORKDIR/assembly_eval/merqury/genome.meryl"  
HIFI_ASSEMBLY="$WORKDIR/assembly/results_hifiasm/ERR11437324.fa"  
FLY_ASSEMBLY="${WORKDIR}/assembly/results_fly/assembly.fasta"
LJA_ASSEMBLY="${WORKDIR}/assembly/results_LJA/assembly.fasta"
TRI_ASSEMBLY="${WORKDIR}/assembly/results_trinity/results_trinity.Trinity.fasta"

# run container with merqury
# for hifiasm
mkdir -p ${OUTDIR}/hifiasm
cd ${OUTDIR}/hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/merqury_1.3.sif \
merqury.sh $KMER_DB $HIFI_ASSEMBLY \
hifiasm

# for flye
mkdir -p ${OUTDIR}/flye
cd ${OUTDIR}/flye
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
merqury.sh $KMER_DB $FLY_ASSEMBLY \
flye

# for LJA
mkdir -p ${OUTDIR}/LJA
cd ${OUTDIR}/LJA
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
merqury.sh $KMER_DB $LJA_ASSEMBLY \
LJA

