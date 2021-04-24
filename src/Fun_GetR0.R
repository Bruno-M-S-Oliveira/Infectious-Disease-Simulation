#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

get_R0 <- function(u, CM, InfectiousPeriod) {
  Du <- diag(u, 9)
  Dy <- diag(InfectiousPeriod, 9)
  
  NGM <- Du %*% CM %*% Dy
  R0  <- abs(eigen(NGM)$values[1])
}

get_u_scaling <- function(u, CM, InfectiousPeriod, ExpectedR0) {
  MaxScale <- 10
  MinScale <- 100
  MaxR0 <- get_R0(u/MaxScale, CM, InfectiousPeriod)
  MinR0 <- get_R0(u/MinScale, CM, InfectiousPeriod)
  
  if (MaxR0 < ExpectedR0 || MinR0 > ExpectedR0){
    print(paste0("Error: Expected R0 (", ExpectedR0, 
                 ") is not in the original range of R0 values ([",
                 MinR0, ", ", MaxR0, "]).", sep=''))
    stop()
  }
  
  while(TRUE) {
    CurrentScale <- (MaxScale + MinScale)/2
    CurrentR0 <- get_R0(u/CurrentScale, CM, InfectiousPeriod)
    
    if (CurrentR0 > ExpectedR0){
      MaxScale <- CurrentScale
    } else {
      MinScale <- CurrentScale
    }
    
    if (abs(CurrentR0 - ExpectedR0) < 1e-4){
      return(CurrentScale)
    }
  }
}