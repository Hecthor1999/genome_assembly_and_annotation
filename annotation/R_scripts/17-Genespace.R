library(GENESPACE)
args <- commandArgs(trailingOnly = TRUE)
# get the folder where the genespace files are
wd <- args[1]
gpar <- init_genespace(wd = "/data/users/harribas/assembly_course/annotation/scripts/genespace", path2mcscanx = "/usr/local/bin", nCores = 20, verbose = TRUE)
out <- run_genespace(gpar, overwrite = TRUE)
