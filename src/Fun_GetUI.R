#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
# Extra functions to avoid cluttering up the code
source('Fun_GetCM.R')

# ------Contact Matrix------
get_Country <- function(input) {
  input$Country
}

get_Area <- function(input) {
  input$Area
}

get_BRN <- function(input) {
  input$BRN
}

# ------Disease------
get_LatentPeriod <- function(input) {
  input$EPeriod
}

get_InfectiousPeriod <- function(input) {
  input$IPeriod
}

get_ImmunityPeriod <- function(input) {
  input$RPeriod
}

# ------Vaccination------
get_VaxGoal <- function(input) {
  input$VaxGoal/100
}

get_VaxStart <- function(input) {
  input$VaxStart
}

get_VaxIncrease <- function(input) {
  input$VaxIncrease
}

get_VaxEffect <- function(input) {
  input$VaxEffect/100
}

get_Priority <- function(input) {
  c(input$Priority1,input$Priority2,input$Priority3,input$Priority4,
    input$Priority5,input$Priority6,input$Priority7,input$Priority8,
    input$Priority9)
}

# ------Age Specific------
# Group Size
get_T0 <- function(input) {
  c(input$T0_1,input$T0_2,input$T0_3,input$T0_4,input$T0_5,
    input$T0_6,input$T0_7,input$T0_8,input$T0_9)
}

get_Sv0 <- function(input) {
  return(Def_Sv0)
}

get_E0 <- function(input) {
  get_LatentPeriod(input)/get_InfectiousPeriod(input) * get_I0(input)
}

get_Ev0 <- function(input) {
  return(Def_Ev0)
}

get_I0 <- function(input) {
  c(input$I0_1,input$I0_2,input$I0_3,input$I0_4,input$I0_5,
    input$I0_6,input$I0_7,input$I0_8,input$I0_9)
}

get_Iv0 <- function(input) {
  return(Def_Iv0)
}

get_R0 <- function(input) {
  c(input$R0_1,input$R0_2,input$R0_3,input$R0_4,input$R0_5,
    input$R0_6,input$R0_7,input$R0_8,input$R0_9)
}

get_Rv0 <- function(input) {
  return(Def_Rv0)
}

get_D0 <- function(input) {
  return(Def_D0)
}

# Other
get_u <- function(input) {
  c(input$u_1,input$u_2,input$u_3,input$u_4,input$u_5,
    input$u_6,input$u_7,input$u_8,input$u_9)/100
}

get_IFR <- function(input) {
  c(input$IFR_1,input$IFR_2,input$IFR_3,input$IFR_4,input$IFR_5,
    input$IFR_6,input$IFR_7,input$IFR_8,input$IFR_9)/100
}

get_NVax <- function(input) {
  c(input$NVax_1,input$NVax_2,input$NVax_3,input$NVax_4,input$NVax_5,
    input$NVax_6,input$NVax_7,input$NVax_8,input$NVax_9)/100
}

get_LifeExp <- function(input) {
  c(input$LE_1,input$LE_2,input$LE_3,input$LE_4,input$LE_5,
    input$LE_6,input$LE_7,input$LE_8,input$LE_9)
}

# ------Simulation------
get_InitialState<- function(input) {
  NVax <- get_NVax(input)
  
  Sv0 <- get_Sv0(input)
  Ev0 <- get_Ev0(input)
  E0  <- get_E0(input)  * (1-NVax)
  Ex0 <- get_E0(input)  * NVax
  Iv0 <- get_Iv0(input)
  I0  <- get_I0(input)  * (1-NVax)
  Ix0 <- get_I0(input)  * NVax
  Rv0 <- get_Rv0(input)
  R0  <- get_R0(input)  * (1-NVax)
  Rx0 <- get_R0(input)  * NVax
  D0  <- get_D0(input)
  S0  <- (get_T0(input) -Sv0 -E0-Ex0-Ev0 -I0-Ix0-Iv0 -R0-Rx0-Rv0 -D0) * (1-NVax)
  Sx0 <- (get_T0(input) -Sv0 -E0-Ex0-Ev0 -I0-Ix0-Iv0 -R0-Rx0-Rv0 -D0) * NVax
  TI0 <- rep(0,9)

  c(Sv=Sv0, S=S0, Sx=Sx0, Ev=Ev0, E=E0, Ex=Ex0, 
    Iv=Iv0, I=I0, Ix=Ix0, Rv=Rv0, R=R0, Rx=Rx0, D=D0, TI=TI0)
}

get_Parameters<- function(input) {
  u        <- get_u(input)
  CM       <- get_ContactMatrix(get_Country(input), get_Area(input))
  EPeriod  <- get_LatentPeriod(input)
  IPeriod  <- get_InfectiousPeriod(input)
  RPeriod  <- get_ImmunityPeriod(input)
  IFR      <- get_IFR(input)
  vg       <- get_VaxGoal(input) * sum(get_T0(input))
  ve       <- get_VaxEffect(input)
  vs       <- get_VaxStart(input)
  vi       <- get_VaxIncrease(input)
  Priority <- get_Priority(input)

  uScaling <- get_u_scaling(u, CM, IPeriod, get_BRN(input))

  list(u=u/uScaling, CM=CM, EPeriod=EPeriod, IPeriod=IPeriod, RPeriod=RPeriod,
       IFR=IFR, vg=vg, ve=ve, vs=vs, vi=vi, Priority=Priority)
}

get_Times <- function(input) {
  Def_Times
}

get_VaxTimes <- function(input) {
  VaxGoal <- get_VaxGoal(input)
  if(VaxGoal > 0 && VaxGoal < 1) {
  VaxGoalN <- VaxGoal * sum(get_T0(input))
  
    seq(
      from=0, by=1,
      to=floor(Re(polyroot(
        c(-VaxGoalN, get_VaxStart(input), get_VaxIncrease(input)/2)
        ))[1])
    )
  } else {
    0
  }
}