
gca <- GENETIC_CODE
names(gca) <- NULL
gc <- data.frame(sq=names(GENETIC_CODE), aa=gca)
gc$aa <- factor(gc$aa)



#sq <- "TNT"
#indexes <- grep(get.codon.pattern(sq), codon_table$sq)
deps <- c("BiocManager")

for(a in deps)
  if(length(which( installed.packages() == a)) <= 0)
    install.packages(a)
rm(a,deps)

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("msa")

require(msa)
