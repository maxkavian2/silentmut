# It changes the third codon of the sequence
sq <- "AAATTTCCCGGG"
change.codon(3,sq,gc=NULL)

# The third codon changes randomly in every position, but excludes A
# in the second position
sq <- "AAATTTNBNGGG"
change.codon(3,sq,gc=NULL, degenerate = TRUE)

# throws an error (it does not work with degenerated sequences)
change.codon(3,sq,gc=NULL, degenerate = FALSE)

