#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
# Extra functions to avoid cluttering up the code

SEIRDS_Model <- function(t, y, parms) {
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
  alpha <- 1/parms$EPeriod
  gamma <- (1-parms$IFR)/parms$IPeriod
  omega <- 1/parms$RPeriod
  mu    <- parms$IFR/parms$IPeriod
  ve    <- parms$ve

  dS  <- - (CM%*%(((I+(1-ve)*Iv)/Total))*u)*S  + omega*R
  dSv <- - (CM%*%(((I+(1-ve)*Iv)/Total))*u)*Sv + omega*Rv

  dE  <- + (CM%*%(((I+(1-ve)*Iv)/Total))*u)*S  - alpha*E
  dEv <- + (CM%*%(((I+(1-ve)*Iv)/Total))*u)*Sv - alpha*Ev

  dI  <- alpha*E  - (gamma+mu)*I
  dIv <- alpha*Ev - (gamma+mu)*Iv

  dR  <- gamma*I             - omega*R
  dRv <- gamma*Iv + ve*mu*Iv - omega*Rv

  dD  <- mu*(I+(1-ve)*Iv)

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

  S  <- S  - dSv
  Sv <- Sv + dSv

  E  <- E  - dEv
  Ev <- Ev + dEv

  c(S, Sv, E, Ev, I, Iv, R, Rv, D)
}

run_Sim <- function(Group, Parameters, Times, VaxTimes) {
  as.data.frame(lsoda(
    y=Group, times=Def_Times, parms=Parameters,
    func=SEIRDS_Model, events=list(func=vax_Event, time=VaxTimes))) %>%
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
