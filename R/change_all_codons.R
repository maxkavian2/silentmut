

change.all.codons <- function(codpos, sq){
  nsq <- sq
  for(i in 1:length(codpos)) nsq <- change.codon(i, codpos, nsq)
  nsq
}