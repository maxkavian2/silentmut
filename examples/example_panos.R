
# -------------
# MAX 1:0 CHAT-GPT (LOL)
# -------------

#PARAMS -------
wd <- "/home/maxkavian"
rnai.file <- "inst/extdata/panos_rnai"
cdna.file <- "inst/extdata/panos_cdna"


codon.length <- 3
gap.opening <- 100 # penalty gap opening in ClustalW, keep it high to avoid gaps!
deps <- c("BiocManager")

# LOAD essential tables ---------------
load("inst/extdata/DROME_gencode")




# EXECUTION --------------
setwd(wd)

for(a in deps)
  if(length(which( installed.packages() == a)) <= 0)
    install.packages(a)
rm(a,deps)

if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("msa")

require(msa)

seqsal <- multi.alignment(c(cdna.file, rnai.file), path=getwd(), gapOpening=gap.opening)
algpos <- make.break.list(seqsal)[[2]]
algpos[1] <- algpos[1] +1

restricted.codons <- algpos %/% codon.length




# reads the sequences
sq <- scan(cdna.file,what=character())[2]
rq <- scan(rnai.file,what=character())[2]

codon_table$aa <- factor(codon_table$aa)

lsq <- nchar(sq)
codpos <- (1:lsq)[1:lsq %% codon.length == 1]
codpos <- codpos[restricted.codons[1]:restricted.codons[2]]

sq <- change.all.codons(codpos, sq)

print(sq)










