
# this script produces the input necessary to run omark

filtered_prots <- read.table("assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer", fill = TRUE)

names_sequences <- filtered_prots$V1

names <- names_sequences[grep("^>", names_sequences)]


# Extract the numeric part (after 'anz' and before the suffix)
library(dplyr)

# Create a data frame to hold the original input and extracted numeric parts
data <- data.frame(name = names)

# Extract the numeric part (after 'altai5') and create a grouping key
data$group <- sub("^>altai5([0-9]+)-.*$", "\\1", data$name)

# Group by the numeric part and create a semicolon-separated list of names for each group
grouped_data <- data %>%
  group_by(group) %>%
  summarise(names = paste(sub("^>", "", name), collapse = ";")) %>%
  pull(names)

# Write the output to a file
writeLines(grouped_data, "omark_input.txt")

