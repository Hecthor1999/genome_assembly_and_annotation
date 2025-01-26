Genome assembly and annotation of Arabidopsis thaliana accession Altai-5.

This repository contains all the necessary scripts to produce three different genome assemblies and one transcriptome assemlby
The goal of these scripts is to study the genomic differences between worldwide Arabidopsis thaliana samples.
To achieve this, The genome of the specific sample with accession name Altai5 is assembled with three tools for comparison to produce the best possible assembly as well as create a transcriptome assembly.
The best Assembly will the be used to do genome annotation.

# Genome assembly
## 0. Getting started
Go to the wd 
Create a directory where we can store the data

```
cd /data/users/harribas/assembly_course
mkdir -p "raw_data"
ln -s /data/users/harribas/assembly_course/raw_data/Altai-5 ./
ln -s /data/users/harribas/assembly_course/raw_data/RNAseq_Sha ./

```
## 1. Quality check

Run 1_run_fasqc.sh file.
through job submission

```
$ sbatch 01_run_fasqc.sh
```
Inspect output.
trimming then is performed with:

```
$ sbatch 02_run_fastp.sh 
```
Here fastp is only performed on the rna seq data

## 2. kmer counting

Run 03_kmer_counting.sh
```
$ sbatch 03_kmer_counting.sh
```
Go to http://genomescope.org/genomescope2.0/
Upload the histo file and inspect the plots

## 3. Assembly

To run all three genome assemblers
```
sbatch 04_run_flye.sh
sbatch 05_run_hifiasm.sh
sbatch 06_run_LJA.sh 
```
To run the transcriptome assembly

```
07_run_trinity.sh
```
## 4. Assembly evaluation

BUSCO, Quast and Merqury were used
for evaluation and comparison.

Quast and Merqury were performed only on the genome assemblies
BUSCO was performed on both the genome and the transcriptome assembly

To run Quast with and without a reference
```
sbatch 08_run_quast.sh
```
To run Merqury
First a Meryl database needs to be created
To obtain the optimal k-mer size we have to comment out the meryl container 
Introduce the size of your genome as an argument for best_k.sh
check the logs, there you will find the k-mer size
Then you can introduce it as a parameter for meryl and remove the comment
Then run
```
sbatch 09_rep_meryl_db.sh 
```
Merqury can be run on that database 
```
sbatch 10_run_merqury.sh
```
To run BUSCO and to plot its results
```
11_run_busco.sh
12_plot_busco.sh
```
## 5. Genome comparison

Comparison to the reference TAIR10
and between different accessions.
In this case (ms-0, RRS10 and Est-0)

First run Nucmer 
to map the assembled genomes (flye, hifiasm and LJA) against the reference genome.
```
sbatch  13_run_nucmer.sh 
```
Second run mummerplot
to visualize the results as dotplots
```
sbatch 14_run_mummerplot.sh
```

If you wish to compare the accessions to Altai-5

run 
```
sbatch 15_run_accession_comparison.sh 
```
then comment out the nucmer lines and uncomment the mummerplot lines
then run it again.

----------------------------------------------------------------------
# Genome annotation

## 1. TE annotation 
### EDTA
First EDTA is run for TE annotation
```
sbatch 01_run_EDTA.sh
```
To visualize percentage identity of full length LTR
we run 
```
sbatch 02_sortTE_for_LTR_identity.sh
```

Then run in R using assembly.fasta.mod.LTR.intact.gff3 and assembly.fasta.mod.LTR.intact.raw.fa.anno.list from EDTA
```
plot_hist_clade_ltr_percentage.R
```

To visualize TE distribution across the genome we use assembly.fasta.mod.EDTA.TEanno.gff3 
run in R the first 2 parts of
```
plot_circlize.R
```
### TE classification refining
```
sbatch 03_run_tesorter.sh
```
To visualize clade abundance 
```
abundance_hist.R
```
### Dynamics of TEs, age estimation
```
sbatch  04_te_age_estimation.sh
```
To visualize results
```
age_estim.R
```
### Phylogenetic analysis
Run in order
```
sbatch 05_phylogenetic_analysis.sh
sbatch 06_phylogenetic_analysis.sh
sbatch 07_get_color_list
sbatch 08_phylogenetic_analysis.sh
```
To visualize go to https://itol.embl.de/
and upload the tree files, as well as dataset_color_strip and dataset_simplebar_template

## 2. Gene annotation
### Homology-Based Genome Annotation with MAKER
Run in order
```
sbatch 09_run_create_maker_control
sbatch 10_run_maker
sbatch 11_maker_output_format
```
### 































