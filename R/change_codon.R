#'@title Generates a silent mutation to a codon (equivalent substitution), or any compatible codon from a degenerated (incomplete) codon sequence.
#'@description It creates a silent mutation to a codon at the specified position, or a random mutation on a degenerated codon in an incomplete sequence.
#'@param cps Index of the codon to be replaced.
#'@param sq Original DNA sequence.
#'@param gcode The genetic code used, as \code{data.frame}. If NULL, the standard genetic code included in the BiocManager will be used (see details).
#'@param codon.length The length of a typical codon, i.e. 3 bases.
#'@param codpos Vector of codon positions. They are generated automatically from the first position in \code{sq}, which is assumed to mark the reading frame.
#'@param degenerate If TRUE, the base symbol at \code{sq} is treated as degenerated (i.e. including special characters such as B,K,S,M,V, etc.)
#'@param aa.col The name of the column in the genetic code corresponding to the aminoacid key.
#'@param codon.col The name of the column in the genetic code corresponding to the codon sequence.
#'@details The function generates a sequence based on \code{sq}, with a replaced codon at the position \code{cps} by a synonymous codon. If \code{cps} is greater than the greater possible codon index, or the coded residue has no degeneration (e.g. tryptophan), the original \code{sq} will be returned. \code{cps} values equal or lower to zero throw an error.
#' The genetic code used by default is based on the vector \code{GENETIC_CODE} accessible through the BiocManager package. A customized genetic code can be indicated instead, consisting on a data.frame with two character vectors named \code{aa} and \code{sq}. Column names can be altered to allow for other classifications to be used as criteria for the substitution (e.g. chemical family of the residue lateral chain).
#'@return A DNA sequence, corresponding to an ORF, with an alternative set of equivalent codons.
#'@author Máximo Sánchez-Aragón
#'@example examples/change_codon_example.R
change.codon <- function(cps, sq, gcode=NULL, codon.length=3, codpos=(1:nchar(sq))[(1:nchar(sq))%%codon.length == 1], degenerate=FALSE, aa.col="aa", codon.col="sq"){
  if(cps <= 0)
    stop("Max says: cps must be equal or greater than 1.")

  lsq <- nchar(sq)
  #if(cps > lsq %/% codon.length )
  #  warning("Max says: index out of bounds; no changes in sequence.")

  codon_table <- gcode
  if(is.null(codon_table)){
    gca <- GENETIC_CODE
    names(gca) <- NULL
    codon_table <- data.frame(sq=names(GENETIC_CODE), aa=gca)
    #gc[[aa.col]] <- factor(gc[[aa.col]])
  }

  if(check.degeneracy(sq) && !degenerate){
    stop("Max says: the sequence is degenerated. Set degenerate to TRUE if you still want a random codon replacement")
  }

  cdn <- substr(sq, codpos[cps],  codpos[cps]+(codon.length-1))
  t <- c()
  if(!degenerate){
    aan <- as.character(codon_table[[aa.col]][which(codon_table[[codon.col]] == cdn)])
    t <- codon_table[[codon.col]][codon_table[[aa.col]] == aan & codon_table[[codon.col]] != cdn]
  }else{
    inx <- grep(get.codon.pattern(cdn), codon_table[[codon.col]])
    t <- codon_table[[codon.col]][inx]
  }

  if(length(t) > 0){ # prevents codons unique sequences from occurring.
    ncdn <- sample(t,1)
    nsq <- paste(substr(sq, 1, codpos[cps]-1),ncdn,
                 substr(sq, codpos[cps]+codon.length, cps*lsq), sep="")
    return(nsq)
  }else{
    return(sq)
  }
}
