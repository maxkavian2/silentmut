
multi.alignment <- function(fls, path="", simple.sequence=FALSE, ...){
  seqs.set <- readDNAStringSet(paste(path, fls,sep="/"), format="fasta")
  seqs.align <- c()
  if(!simple.sequence){
    seqs.align <- msa(seqs.set, ...)
    seqsal<- as.character(seqs.align) 
  }else{
    seqsal<- as.character(seqs.set) 
  }
  
  seqsal
}

find.alg.breaks <- function(seq){
  rsq <- grep("[ATCG-]*",seq, value=T)
  brks <- c()
  
  if(substr(rsq,1,1) != "-")
    brks <-c(brks,1);
  
  for(j in 1:(nchar(rsq)-1)){
    if(substr(rsq,j,j) == "-" && substr(rsq,j+1,j+1) != "-")
      brks <- c(brks,j)
    if(substr(rsq,j,j) != "-" && substr(rsq,j+1,j+1) == "-")
      brks <- c(brks,j)
  }
  
  if(length(brks)==1 && brks[1]==1)
    brks <- c(brks,nchar(rsq))
  
  names(brks)<- NULL
  brks
}

make.break.list <- function(seqsal){
  brk.list <- list()
  for(s in 1:length(seqsal))
    brk.list[[s]] <- find.alg.breaks(seqsal[s])
  
  names(brk.list) <- names(seqsal)
  ml <- nchar(seqsal[1])
  names(ml) <- NULL
  attr(brk.list,"max length") <- ml
  
  brk.list
}

