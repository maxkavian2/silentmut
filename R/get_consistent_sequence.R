
get.consistent.sequence <- function(sq){
  r <- grep("^[ATCGNBVDHRYWSMK]*$", sq)
  if(length(r) > 0)
    return(FALSE)
  else
    return(TRUE)
}
