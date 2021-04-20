#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

SIR_Model <- function(t, y, parms) {
  with(as.list(c(y, parms)), {
    S=y[1]
    I=y[2]
    R=y[3]
    D=y[4]
    
    N <- S+I+R
      
    dS <- -(beta * I * S)/N
    dI <- (beta * I * S)/N - gamma*I - mu*I
    dR <- gamma*I
    dD <- mu*I
    
    list(c(dS, dI, dR, dD))
  })
}