# EXAMPLE 1
# It changes the third codon of a non-degenerated sequence.
change.codon(3,"AAATTTCCCGGG",gcode=NULL)

# EXAMPLE 2
# It changes the third codon of a degenerated sequence.
# The third codon changes randomly in every position, but excludes A
# in the second position
change.codon(3,"AAATTTNBNGGG",gcode=NULL, degenerate = TRUE)

# EXAMPLE 3
# throws an error (it does not work with degenerated sequences)
# change.codon(3,sq,gc=NULL, degenerate = FALSE)

# EXAMPLE 4
# Includes a list of polar and apolar residues in the Genetic Code
# and substitutes the third codon by another codon from the same polarity group.
# loads the codon table from the data folder
package.name <- "silentmut"
indexes <- which(dir.exists(paste(.libPaths(),"/",package.name,sep="")))
load(paste(.libPaths()[indexes[1]],"/",package.name,"/data/DROME_gencode",sep=""))

# Includes a polarity list of residues to the genetic code
polar.aa <- c("R","S","K","N","Q","H","W","C","Y","G","E","D")
apolar.aa<- c("T", "M", "I", "P", "L","V","F","A")
v <- rep(NA, times=nrow(codon_table))
v[!is.na(match(codon_table$aa, polar.aa))] <- "P"
v[!is.na(match(codon_table$aa, apolar.aa))] <- "AP"
codon_table <- data.frame(codon_table, polarity=v)

change.codon(3,"AAATTTCCCGGG", gcode=codon_table, aa.col = "polarity")



