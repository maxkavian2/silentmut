# This is just an auxiliary function.
# returns TRUE if the sq is degenerated.
check.degeneracy <- function(sq, rgx="^[ATCG]*$"){
  r <- grep(rgx, sq)
  if(length(r) > 0)
    return(FALSE)
  else
    return(TRUE)
}
