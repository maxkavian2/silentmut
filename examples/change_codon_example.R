# It changes the third codon of the sequence
sq <- "AAATTTCCCGGG"
load("inst/extdata/DROME_gencode")
change.codon(3,sq,gc=codon_table)
