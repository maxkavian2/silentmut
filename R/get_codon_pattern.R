# This is just an auxiliary function, to generate a pattern for grep
# based on https://iubmb.qmul.ac.uk/misc/naseq.html
get.codon.pattern <- function(codon){
  cd <- codon
  cd <- gsub("N", "[ATCG]",cd)
  cd <- gsub("B", "[TCG]", cd)
  cd <- gsub("V", "[ACG]", cd)
  cd <- gsub("D", "[ATG]", cd)
  cd <- gsub("H", "[ATC]", cd)
  cd <- gsub("R", "[AG]", cd)
  cd <- gsub("Y", "[CT]", cd)
  cd <- gsub("W", "[AT]", cd)
  cd <- gsub("S", "[CG]", cd)
  cd <- gsub("M", "[AC]", cd)
  cd <- gsub("K", "[GT]", cd)
  cd
}
