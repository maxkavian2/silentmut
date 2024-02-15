#'@title Changes all codons in a sequence to equivalent codons, or generates a random sequence from a degenerated sequence.
#'@description It creates a full random replacement of the codons for equivalent codons (i.e. translated into the same residues). If the sequence is degenerated (i.e. including symbols such as B,V,S,K, etc.) and the \code{degenerate} flag is \code{TRUE}, codons are replaced randomly according to the symbol translation. However this option does not guarantee the same translation.
#'@param codpos Integer indicating the codon positions that will be replaced (index).
#'@param sq The original sequence, written in standard genetic code.
#'@param ... Arguments passed to \code{change.codon}.
#'@return A character vector expressing an alternative sequence of codons.
#'@author Máximo Sánchez-Aragón.
change.all.codons <- function(codpos, sq, ...){
  nsq <- sq
  if(nchar(nsq) %% 3 != 0)
    warning("[Max says] the sequence does not contain an exact number of codons, i.e. incomplete ORF")

  for(i in 1:length(codpos)) nsq <- change.codon(i, nsq, codpos=codpos, ...)
  nsq
}
