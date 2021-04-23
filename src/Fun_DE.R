#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

SIRD_Model <- function(t, y, parms) {
  with(as.list(c(y, parms)), {
    S <- y[1:9]
    I <- y[10:18]
    R <- y[19:27]
    D <- y[28:36]
    
    T <- S + I + R
    
    dS <- -u*sum(CM%*%(I/T))*S
    dI <- u*sum(CM%*%(I/T))*S - (gamma+mu)*I
    dR <- gamma*I
    dD <- mu*I
    
    list(c(dS, dI, dR, dD))
  })
}

Run_Sim <- function(State, Parameters) {
  as.data.frame(ode(y=State, times=Def_Times, func=SIRD_Model, parms=Parameters)) %>% 
    mutate(S=S1+S2+S3+S4+S5+S6+S7+S8+S9) %>% 
    mutate(I=I1+I2+I3+I4+I5+I6+I7+I8+I9) %>% 
    mutate(R=R1+R2+R3+R4+R5+R6+R7+R8+R9) %>% 
    mutate(D=D1+D2+D3+D4+D5+D6+D7+D8+D9) %>% 
    select(time, S, I, R, D) %>% 
    pivot_longer(!time, names_to='State', values_to='N')
}
