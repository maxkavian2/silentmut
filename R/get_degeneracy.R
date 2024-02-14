# This is just an auxiliary function.
# returns TRUE if the sq is degenerated.
check.degeneracy <- function(sq){
  r <- grep("^[ATCG]*$", sq)
  if(length(r) > 0)
    return(FALSE)
  else
    return(TRUE)
}
