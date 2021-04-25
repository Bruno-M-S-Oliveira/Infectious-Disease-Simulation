#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

SIRD_Model <- function(t, y, parms) {
  S  <- y[1:9]
  Sv <- y[10:18]
  E  <- y[19:27]
  Ev <- y[28:36]
  I  <- y[37:45]
  Iv <- y[46:54]
  R  <- y[55:63]
  Rv <- y[64:72]
  D  <- y[73:81]
  
  Total <- S+Sv + E+Ev + I+Iv + R+Rv
  
  u     <- parms$u
  CM    <- parms$CM
  alpha <- 1/parms$LPeriod
  gamma <- (1-parms$IFR)/parms$IPeriod
  mu    <- parms$IFR/parms$IPeriod
  ve    <- parms$ve
  
  t
  dS  <- - (CM%*%(((I+Iv)/Total))*u)*S
  dSv <- - (CM%*%(((I+Iv)/Total))*u)*Sv
  
  dE  <- + (CM%*%(((I+Iv)/Total))*u)*S  - alpha*E
  dEv <- + (CM%*%(((I+Iv)/Total))*u)*Sv - alpha*Ev
  
  dI  <-        alpha*E  - (gamma+mu)*I
  dIv <- (1-ve)*alpha*Ev - (gamma+mu)*Iv
  
  dR  <-               gamma*I
  dRv <- ve*alpha*Ev + gamma*Iv
  
  dD  <- mu*(I+Iv)
  
  list(c(dS, dSv, dE, dEv, dI, dIv, dR, dRv, dD))
}

vax_Event <- function(t, y, parms) {
  S  <- y[1:9]
  Sv <- y[10:18]
  E  <- y[19:27]
  Ev <- y[28:36]
  I  <- y[37:45]
  Iv <- y[46:54]
  R  <- y[55:63]
  Rv <- y[64:72]
  D  <- y[73:81]
  
  vg <- parms$vg
  vs <- parms$vs
  vi <- parms$vi
  Priority <- parms$Priority
  
  ToVax <- sum(Priority*(S+E))
  VaxToday <- vs + vi*t
  
  if(ToVax != 0) {
    if(ToVax > VaxToday) {
      dSv <- Priority*VaxToday*S/ToVax
      dEv <- Priority*VaxToday*E/ToVax
    } else {
      dSv <- Priority*S + (1-Priority)*VaxToday*S/ToVax
      dEv <- Priority*E + (1-Priority)*VaxToday*E/ToVax
    }
  } else {
    ToVax <- sum(Priority*(S+E))
    if(ToVax > VaxToday) {
      dSv <- VaxToday*S/ToVax
      dEv <- VaxToday*E/ToVax
    } else {
      dSv <- S
      dEv <- E
    }
  }
  
  S  <- S  - dSv 
  Sv <- Sv + dSv 
  
  E  <- E  - dEv 
  Ev <- Ev + dEv 
  
  c(S, Sv, E, Ev, I, Iv, R, Rv, D)
}

run_Sim <- function(State, Parameters, Times, VaxTimes) {
  as.data.frame(lsoda(
    y=State, times=Def_Times, parms=Parameters, 
    func=SIRD_Model, events=list(func=vax_Event, time=VaxTimes))) %>% 
    mutate(S=S1+S2+S3+S4+S5+S6+S7+S8+S9) %>% 
    mutate(Sv=Sv1+Sv2+Sv3+Sv4+Sv5+Sv6+Sv7+Sv8+Sv9) %>% 
    mutate(E=E1+E2+E3+E4+E5+E6+E7+E8+E9) %>% 
    mutate(Ev=Ev1+Ev2+Ev3+Ev4+Ev5+Ev6+Ev7+Ev8+Ev9) %>% 
    mutate(I=I1+I2+I3+I4+I5+I6+I7+I8+I9) %>% 
    mutate(Iv=Iv1+Iv2+Iv3+Iv4+Iv5+Iv6+Iv7+Iv8+Iv9) %>% 
    mutate(R=R1+R2+R3+R4+R5+R6+R7+R8+R9) %>% 
    mutate(Rv=Rv1+Rv2+Rv3+Rv4+Rv5+Rv6+Rv7+Rv8+Rv9) %>% 
    mutate(D=D1+D2+D3+D4+D5+D6+D7+D8+D9) %>% 
    mutate(Total=S+E+I+R) %>% 
    mutate(Totalv=Sv+Ev+Iv+Rv) 
}
