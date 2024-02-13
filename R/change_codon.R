#'@title Generates a silent mutation to a codon.
#'@description It creates a silent mutation to a codon at the specified position.
#'@param cps Index of the codon to be replaced.
#'@param sq Original DNA sequence.
#'@param gc The genetic code used, as \code{data.frame}.
#'@param codon.length The length of a typical codon, i.e. 3 bases.
#'@param codpos Vector of codon positions. They are generated automatically from the first position in \code{sq}, which is assumed to mark the reading frame.
#'@details The function generates a sequence based on \code{sq}, with a replaced codon at the position \code{cps} by a synonymous codon. If \code{cps} is greater than the greater possible codon index, or the coded residue has no degeneration (e.g. tryptophan), the original \code{sq} will be returned. \code{cps} values equal or lower to zero throw an error.
#'@return A DNA sequence, corresponding to an ORF, with an alternative set of equivalent codons.
#'@author Máximo Sánchez-Aragón
#'@example examples/change_codon_example.R
change.codon <- function(cps, sq, gc=NULL, codon.length=3, codpos=(1:nchar(sq))[(1:nchar(sq))%%codon.length == 1]){
  if(cps <= 0)
    stop["Max says: cps must be equal or greater that 1."]
  lsq <- nchar(sq)
  cdn <- substr(sq, codpos[cps],  codpos[cps]+(codon.length-1))
  aan <- as.character(gc$aa[which(codon_table$sq == cdn)])
  t <- codon_table$sq[gc$aa == aan & codon_table$sq != cdn]
  if(length(t) > 0){ # prevents codons unique sequences from occurring.
    ncdn <- sample(t,1)
    nsq <- paste(substr(sq, 1, codpos[cps]-1),ncdn,
                 substr(sq, codpos[cps]+codon.length, cps*lsq), sep="")
    return(nsq)
  }else{
    return(sq)
  }
}
