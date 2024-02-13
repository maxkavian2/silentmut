
change.codon <- function(cps, codpos, sq){
  cdn <- substr(sq, codpos[cps],  codpos[cps]+(codon.length-1))
  aan <- as.character(codon_table$aa[which(codon_table$sq == cdn)])
  t <- codon_table$sq[codon_table$aa == aan & codon_table$sq != cdn]
  if(length(t) > 0){ # prevents codons unique sequences from occurring.
    ncdn <- sample(t,1)
    nsq <- paste(substr(sq, 1, codpos[cps]-1),ncdn,
                 substr(sq, codpos[cps]+codon.length, cps*lsq), sep="")
    return(nsq)
  }else{
    return(sq)
  }
}