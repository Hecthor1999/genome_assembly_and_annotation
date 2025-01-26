# Introduce data
aed_values <- read.table("assembly.all.maker.renamed.gff.AED.txt", header=T)

plot(aed_values$AED, aed_values$assembly.all.maker.noseq.gff.renamed.gff, type = "l", ylab = "frequency", xlab = "AED values (Annotation Edit Distance)", lwd=3, cex.lab=1.7)
grid()

# Plot a histogram of AED values
hist(aed_values$AED, 
     breaks = 15,                      
     col = "skyblue",                  
     border = "black",                 
     main = "Histogram of AED Values", 
     xlab = "AED",                     
     ylab = "Frequency")              

# Add a grid for clarity
grid()
