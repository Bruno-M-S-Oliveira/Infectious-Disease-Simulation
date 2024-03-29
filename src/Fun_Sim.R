#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
# Extra functions to avoid cluttering up the code

SEIRDS_Model <- function(t, y, parms) {
  Sv <- y[1:9]
  S  <- y[10:18]
  Sx <- y[19:27]
  Ev <- y[28:36]
  E  <- y[37:45]
  Ex <- y[46:54]
  Iv <- y[55:63]
  I  <- y[64:72]
  Ix <- y[73:81]
  Rv <- y[82:90]
  R  <- y[91:99]
  Rx <- y[100:108]
  D  <- y[109:117]
  TI <- y[118:126]

  Total <- S+Sx+Sv + E+Ex+Ev + I+Ix+Iv + R+Rx+Rv

  u     <- parms$u
  CM    <- parms$CM
  alpha <- 1/parms$EPeriod
  gamma <- (1-parms$IFR)/parms$IPeriod
  omega <- 1/parms$RPeriod
  mu    <- parms$IFR/parms$IPeriod
  ve    <- parms$ve

  dSv <- - (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*Sv + omega*Rv
  dS  <- - (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*S  + omega*R
  dSx <- - (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*Sx + omega*Rx

  dEv <- + (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*Sv - alpha*Ev
  dE  <- + (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*S  - alpha*E
  dEx <- + (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*Sx - alpha*Ex

  dIv <- alpha*Ev - (gamma+mu)*Iv
  dI  <- alpha*E  - (gamma+mu)*I
  dIx <- alpha*Ex - (gamma+mu)*Ix

  dRv <- gamma*Iv + ve*mu*Iv - omega*Rv
  dR  <- gamma*I             - omega*R
  dRx <- gamma*Ix            - omega*Rx

  dD  <- mu*(I+Ix+(1-ve)*Iv)
  
  dTI <- (CM%*%(((I+Ix+(1-ve)*Iv)/Total))*u)*(S + Sv + Sx)
 
  list(c(dSv, dS, dSx, dEv, dE, dEx, dIv, dI, dIx, dRv, dR, dRx, dD, dTI))
}

vax_Event <- function(t, y, parms) {
  Sv <- y[1:9]
  S  <- y[10:18]
  Sx <- y[19:27]
  Ev <- y[28:36]
  E  <- y[37:45]
  Ex <- y[46:54]
  Iv <- y[55:63]
  I  <- y[64:72]
  Ix <- y[73:81]
  Rv <- y[82:90]
  R  <- y[91:99]
  Rx <- y[100:108]
  D  <- y[109:117]
  TI <- y[118:126]

  vg <- parms$vg
  vs <- parms$vs
  vi <- parms$vi
  Priority <- parms$Priority

  ToVax <- sum(Priority*(S+E))
  VaxToday <- vs + vi*t

  if(ToVax > VaxToday) {
    dSv <- Priority*VaxToday*S/ToVax
    dEv <- Priority*VaxToday*E/ToVax
  } else {
    dSv <- Priority*S
    dEv <- Priority*E

    ToVax <- sum((1-Priority)*(S+E))
    VaxToday <- VaxToday - sum(dSv + dEv)

    if(ToVax > VaxToday) {
      dSv <- dSv + VaxToday*((1-Priority)*S)/ToVax
      dEv <- dEv + VaxToday*((1-Priority)*E)/ToVax
    } else {
      dSv <- dSv + (1-Priority)*S
      dEv <- dEv + (1-Priority)*E
    }
  }

  Sv <- Sv + dSv
  S  <- S  - dSv

  Ev <- Ev + dEv
  E  <- E  - dEv

  c(Sv, S, Sx, Ev, E, Ex, Iv, I, Ix, Rv, R, Rx, D, TI)
}

run_Sim <- function(Group, Parameters, Times, VaxTimes) {
  as.data.frame(lsoda(
    y=Group, times=Def_Times, parms=Parameters,
    func=SEIRDS_Model, events=list(func=vax_Event, time=VaxTimes))) %>%
    mutate(Sv=Sv1+Sv2+Sv3+Sv4+Sv5+Sv6+Sv7+Sv8+Sv9) %>%
    mutate(S =S1 +S2 +S3 +S4 +S5 +S6 +S7 +S8 +S9 ) %>%
    mutate(Sx=Sx1+Sx2+Sx3+Sx4+Sx5+Sx6+Sx7+Sx8+Sx9) %>%
    mutate(Ev=Ev1+Ev2+Ev3+Ev4+Ev5+Ev6+Ev7+Ev8+Ev9) %>%
    mutate(E =E1 +E2 +E3 +E4 +E5 +E6 +E7 +E8 +E9 ) %>%
    mutate(Ex=Ex1+Ex2+Ex3+Ex4+Ex5+Ex6+Ex7+Ex8+Ex9) %>%
    mutate(Iv=Iv1+Iv2+Iv3+Iv4+Iv5+Iv6+Iv7+Iv8+Iv9) %>%
    mutate(I =I1 +I2 +I3 +I4 +I5 +I6 +I7 +I8 +I9 ) %>%
    mutate(Ix=Ix1+Ix2+Ix3+Ix4+Ix5+Ix6+Ix7+Ix8+Ix9) %>%
    mutate(Rv=Rv1+Rv2+Rv3+Rv4+Rv5+Rv6+Rv7+Rv8+Rv9) %>%
    mutate(R =R1 +R2 +R3 +R4 +R5 +R6 +R7 +R8 +R9 ) %>%
    mutate(Rx=Rx1+Rx2+Rx3+Rx4+Rx5+Rx6+Rx7+Rx8+Rx9) %>%
    mutate(D =D1 +D2 +D3 +D4 +D5 +D6 +D7 +D8 +D9 ) %>%
    mutate(TI=TI1+TI2+TI3+TI4+TI5+TI6+TI7+TI8+TI9) %>%
    mutate(Total     =S      +E      +I      +R        ) %>%
    mutate(Totalx    =  Sx      +Ex    +Ix     +Rx     ) %>% 
    mutate(Totalv    =     Sv     +Ev     +Iv     +Rv  ) %>% 
    mutate(TotalAlive=S+Sx+Sv+E+Ex+Ev+I+Ix+Iv+R+Rx+Rv  ) %>%
    mutate(TotalAll  =S+Sx+Sv+E+Ex+Ev+I+Ix+Iv+R+Rx+Rv+D)
}
