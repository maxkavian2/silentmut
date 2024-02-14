#'@title Introduces silent mutation in the alignment regions of two sequences
#'@description It introduces silent mutations exclusively in the alignment region of two sequences, typically a cDNA sequence and a RNAi sequence.
#'@param cdna.file FASTA file containing the cDNA sequence (larger sequence).
#'@param rnai.file FASTA file containing the RNAi sequence (shorter sequence).
#'@param codon.length The length of a codon, typically 3
#'@param gcode Genetic code used. If \code{NULL}, the \code{GENETIC_CODE} object from the BiocManager package is used.
#'@param gap.opening Indel penalty for ClustalW.
#'@return Returns a genetic sequence with silent mutations at the alignment region.
#'@author Máximo Sánchez-Aragón.
#'@example examples/silent_codon_aligned.R
replace.alignment <- function(cdna.file, rnai.file, gcode = NULL, codon.length = 3, gap.opening = 100){
  seqsal <- multi.alignment(c(cdna.file, rnai.file), path=getwd(), gapOpening=gap.opening)
  algpos <- make.break.list(seqsal)[[2]]
  algpos[1] <- algpos[1] +1

  restricted.codons <- algpos %/% codon.length

  # reads the sequences
  sq <- scan(cdna.file,what=character())[2]
  rq <- scan(rnai.file,what=character())[2]

  codon_table <- gcode
  if(is.null(codon_table)){
    gca <- GENETIC_CODE
    names(gca) <- NULL
    codon_table <- data.frame(sq=names(GENETIC_CODE), aa=gca)
    #gc[[aa.col]] <- factor(gc[[aa.col]])
  }

  #codon_table$aa <- factor(codon_table$aa)

  lsq <- nchar(sq)
  codpos <- (1:lsq)[1:lsq %% codon.length == 1]
  codpos <- codpos[restricted.codons[1]:restricted.codons[2]]

  sq <- change.all.codons(codpos, sq, gcode=codon_table,
                          codon.length=codon.length, degenerate=FALSE,aa.col="aa",
                          codon.col="sq")
  sq
}



