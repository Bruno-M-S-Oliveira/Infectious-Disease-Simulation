#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

SIR_Model <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    N <- S+I+R
      
    dS <- -(b * I * S)/N
    dI <- (b * I * S)/N - g*I
    dR <- g*I
    list(c(dS, dI, dR))
  })
}