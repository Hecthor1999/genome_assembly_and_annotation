
setwd("C:/Users/hecto/OneDrive/Escritorio/Master Bioinformatics/3º semester/Organization and annotation of eukariotic genomes/day 1/exercises/result files")
# Load the circlize package
library(circlize)
library(tidyverse)
library(ComplexHeatmap)


################################################################################
#                     1º plot copia and gypsy
################################################################################

# Load the TE annotation GFF3 file
gff_file <- "assembly.fasta.mod.EDTA.TEanno.gff3"
gff_data <- read.table(gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Check the superfamilies present in the GFF3 file, and their counts
gff_data$V3 %>% table()

# Filter the GFF3 data to select one Superfamily (You need one track per Superfamily)

# custom ideogram data
## To make the ideogram data, you need to know the lengths of the scaffolds.
## There is an index file that has the lengths of the scaffolds, the `.fai` file.
## To generate this file you need to run the following command in bash:
## samtools faidx assembly.fasta
## This will generate a file named assembly.fasta.fai
## You can then read this file in R and prepare the custom ideogram data

custom_ideogram <- read.table("assembly.fasta.fai", header = FALSE, stringsAsFactors = FALSE) # I use the fly assembly
custom_ideogram$chr <- custom_ideogram$V1
custom_ideogram$start <- 1
custom_ideogram$end <- custom_ideogram$V2
custom_ideogram <- custom_ideogram[, c("chr", "start", "end")]
custom_ideogram <- custom_ideogram[order(custom_ideogram$end, decreasing = T), ]
sum(custom_ideogram$end[1:20])

# Select only the first 20 longest scaffolds, You can reduce this number if you have longer chromosome scale scaffolds
custom_ideogram <- custom_ideogram[1:20, ]
custom_ideogram$chr <- paste0("chr", custom_ideogram$chr)

gff_data$V1 <- paste0("chr", gff_data$V1)
# Function to filter GFF3 data based on Superfamily (You need one track per Superfamily)
filter_superfamily <- function(gff_data, superfamily, custom_ideogram) {
  filtered_data <- gff_data[gff_data$V3 == superfamily, ] %>%
    as.data.frame() %>%
    mutate(chrom = V1, start = V4, end = V5, strand = V6) %>%
    select(chrom, start, end, strand) %>%
    filter(chrom %in% custom_ideogram$chr)
  return(filtered_data)
}

pdf("02-TE_density.pdf", width = 10, height = 10)
gaps <- c(rep(1, length(custom_ideogram$chr) - 1), 5) # Add a gap between scaffolds, more gap for the last scaffold
circos.par(start.degree = 90, gap.after = 1, track.margin = c(0, 0), gap.degree = gaps)
# Initialize the circos plot with the custom ideogram
circos.genomicInitialize(custom_ideogram)

# Plot te density
circos.genomicDensity(filter_superfamily(gff_data, "Gypsy_LTR_retrotransposon", custom_ideogram), count_by = "number", col = "darkgreen", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_superfamily(gff_data, "Copia_LTR_retrotransposon", custom_ideogram), count_by = "number", col = "darkred", track.height = 0.07, window.size = 1e5)
circos.clear()

lgd <- Legend(
  title = "Superfamily", at = c("Gypsy_LTR_retrotransposon", "Copia_LTR_retrotransposon"),
  legend_gp = gpar(fill = c("darkgreen", "darkred"))
)
draw(lgd, x = unit(8, "cm"), y = unit(10, "cm"), just = c("center"))

dev.off()
circos.clear()

################################################################################
#                     2º plot most abundant TE superfamilies in one plot
################################################################################

# Now plot all your most abundant TE superfamilies in one plot
# Load TE annotation GFF3 file
gff_file <- "assembly.fasta.mod.EDTA.TEanno.gff3"
gff_data <- read.table(gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Count and select top superfamilies
top_superfamilies <- gff_data %>%
  filter(V3 != "LTR_retrotransposon") %>%  # Exclude unwanted superfamily
  count(V3, sort = TRUE) %>%
  slice_head(n = 5) %>%
  pull(V3) 

# Load and format custom ideogram data
custom_ideogram <- read.table("assembly.fasta.fai", header = FALSE, stringsAsFactors = FALSE)
custom_ideogram <- custom_ideogram %>%
  mutate(chr = paste0("chr", V1), start = 1, end = V2) %>%
  select(chr, start, end) %>%
  arrange(desc(end)) %>%
  slice_head(n = 20)

# Update chromosome identifiers in GFF3 data
gff_data$V1 <- paste0("chr", gff_data$V1)


# Initialize PDF output
pdf("02-TE_density_top5_superfamilies.pdf", width = 10, height = 10)

# Set up circos plot parameters
circos.par(start.degree = 90, gap.after = 1, track.margin = c(0, 0), 
           gap.degree = c(rep(1, nrow(custom_ideogram) - 1), 5))

# Initialize circos plot
circos.genomicInitialize(custom_ideogram)

# Define colors for superfamilies
colors <- c("darkgreen", "darkred", "blue", "purple", "orange")
names(colors) <- top_superfamilies

# Plot density tracks for each top superfamily with debug checks
for (i in seq_along(top_superfamilies)) {
  superfamily <- top_superfamilies[i]
  data <- filter_superfamily(gff_data, superfamily, custom_ideogram)
  
  # Debug: Check if data is a data frame and has the correct structure
  if (!is.data.frame(data) || ncol(data) != 4) {
    stop(paste("Data structure issue with superfamily:", superfamily))
  }
  
  circos.genomicDensity(
    data,
    count_by = "number",
    col = colors[superfamily],
    track.height = 0.07,
    window.size = 1e5
  )
}

# Clear circos plot parameters
circos.clear()

# Create and draw legend
lgd <- Legend(
  title = "Superfamily",
  at = top_superfamilies,
  legend_gp = gpar(fill = colors[top_superfamilies])
)
draw(lgd, x = unit(10, "cm"), y = unit(10, "cm"), just = c("center"))

# Close PDF output
dev.off()

################################################################################
#                     3º Add gene density from maker
################################################################################

# plot the gene density from maker 
# Load the TE annotation GFF3 file
te_gff_file <- "assembly.fasta.mod.EDTA.TEanno.gff3"
te_gff_data <- read.table(te_gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Load the gene annotation GFF3 file
gene_gff_file <- "filtered.genes.renamed.final.gff3"
gene_gff_data <- read.table(gene_gff_file, header = FALSE, sep = "\t", stringsAsFactors = FALSE)

# Custom ideogram data
custom_ideogram <- read.table("assembly.fasta.fai", header = FALSE, stringsAsFactors = FALSE)
custom_ideogram$chr <- custom_ideogram$V1
custom_ideogram$start <- 1
custom_ideogram$end <- custom_ideogram$V2
custom_ideogram <- custom_ideogram[, c("chr", "start", "end")]
custom_ideogram <- custom_ideogram[order(custom_ideogram$end, decreasing = T), ]
custom_ideogram <- custom_ideogram[1:20, ] # Select top 20 scaffolds
custom_ideogram$chr <- paste0("chr", custom_ideogram$chr)

# Update TE and gene data chromosome names
te_gff_data$V1 <- paste0("chr", te_gff_data$V1)
gene_gff_data$V1 <- paste0("chr", gene_gff_data$V1)

# Filter function for GFF3 data
filter_data <- function(gff_data, feature_type, custom_ideogram) {
  filtered_data <- gff_data[gff_data$V3 == feature_type, ] %>%
    as.data.frame() %>%
    mutate(chrom = V1, start = V4, end = V5, strand = V7) %>%
    select(chrom, start, end, strand) %>%
    filter(chrom %in% custom_ideogram$chr)
  return(filtered_data)
}

# PDF output
pdf("03-TE_and_gene_density.pdf", width = 10, height = 10)

# Setup circos plot
gaps <- c(rep(1, length(custom_ideogram$chr) - 1), 5) # Add gaps
circos.par(start.degree = 90, gap.after = gaps, track.margin = c(0, 0))
circos.genomicInitialize(custom_ideogram)

# Plot TE density for Gypsy and Copia
circos.genomicDensity(filter_data(te_gff_data, "Gypsy_LTR_retrotransposon", custom_ideogram), 
                      count_by = "number", col = "darkgreen", track.height = 0.07, window.size = 1e5)
circos.genomicDensity(filter_data(te_gff_data, "Copia_LTR_retrotransposon", custom_ideogram), 
                      count_by = "number", col = "darkred", track.height = 0.07, window.size = 1e5)

# Plot gene density
circos.genomicDensity(filter_data(gene_gff_data, "gene", custom_ideogram), 
                      count_by = "number", col = "blue", track.height = 0.07, window.size = 1e5)

# Add legend
lgd <- Legend(
  title = "Features", at = c("Gypsy_LTR_retrotransposon", "Copia_LTR_retrotransposon", "Genes"),
  legend_gp = gpar(fill = c("darkgreen", "darkred", "blue"))
)
draw(lgd, x = unit(8, "cm"), y = unit(10, "cm"), just = c("center"))

# Close PDF
dev.off()
circos.clear()








