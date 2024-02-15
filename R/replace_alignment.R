#'@title Introduces silent mutations in the alignment regions of two sequences
#'@description It introduces silent mutations exclusively in the alignment region of two sequences, typically a cDNA sequence and a RNAi sequence. The cDNA sequence will be assumed as the longest from the input.
#'@param sqsa A vector of paths to the FASTA files containing the sequences. The length must be 2.
#'@param codon.length The length of a codon, typically 3
#'@param gcode Genetic code used. If \code{NULL}, the \code{GENETIC_CODE} object from the BiocManager package is used.
#'@param gap.opening Indel penalty for ClustalW. Keeping this parameter high is recommended to ensure global aligments with no indels.
#'@return Returns a genetic sequence with silent mutations at the alignment region.
#'@author Máximo Sánchez-Aragón.
#'@example examples/silent_codon_aligned.R
replace.alignment <- function(sqsa, gcode = NULL, codon.length = 3, gap.opening = 100){

  if(length(sqsa) != 2)
    stop("[Max says] the argument must contain strings of length 2")

  sqs <- toupper(sqsa)

  seqsal <- c()
  sq <- c()
  rq <- c()
  algpos <- c()

  #if(fls.flag){
    seqsal <- multi.alignment(c(cdna.file, rnai.file), path=getwd(), gapOpening=gap.opening)
    algpos <- make.break.list(seqsal)[[2]]
    algpos[1] <- algpos[1] +1

    # reads the sequences from files, if they are files (must be FASTA)
    sq <- scan(cdna.file,what=character())[2]
    rq <- scan(rnai.file,what=character())[2]

  #}

  # swaps by length
  if(nchar(sq) < nchar(rq)){
    sq0 <- sq
    sq <- rq
    rq <- sq0
    rm(sq0)
  }

  restricted.codons <- algpos %/% codon.length

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



