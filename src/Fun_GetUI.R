#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code
source('Fun_GetCM.R')

# ------Initial State------
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

get_InitialState<- function(input) {
  Sv0 <- get_Sv0(input)
  E0  <- get_E0(input)
  Ev0 <- get_Ev0(input)
  I0  <- get_I0(input)
  Iv0 <- get_Iv0(input)
  R0  <- get_R0(input)
  Rv0 <- get_Rv0(input)
  D0  <- get_D0(input)
  S0  <- get_T0(input) - Sv0 - E0 - Ev0 - I0 - Iv0 - R0 - Rv0 - D0
  
  c(S=S0, Sv=Sv0, E=E0, Ev=Ev0, I=I0, Iv=Iv0, R=R0, Rv=Rv0, D=D0)
}

# ------Parameters------
get_u <- function(input) {
  c(input$u_1,input$u_2,input$u_3,input$u_4,input$u_5,
    input$u_6,input$u_7,input$u_8,input$u_9)/100
}

get_Country <- function(input) {
  input$Country
}

get_Area <- function(input) {
  input$Area
}

get_LifeExp <- function(input) {
  c(input$LE_1,input$LE_2,input$LE_3,input$LE_4,input$LE_5,
    input$LE_6,input$LE_7,input$LE_8,input$LE_9)
}

get_BRN <- function(input) {
  input$BRN
}

get_LatentPeriod <- function(input) {
  input$EPeriod
}

get_InfectiousPeriod <- function(input) {
  input$IPeriod
}

get_ImmunityPeriod <- function(input) {
  input$RPeriod
}

get_IFR <- function(input) {
  c(input$IFR_1,input$IFR_2,input$IFR_3,input$IFR_4,input$IFR_5,
    input$IFR_6,input$IFR_7,input$IFR_8,input$IFR_9)/100
}

get_VaxGoal <- function(input) {
  input$VaxGoal/100
}

get_VaxEffect <- function(input) {
  input$VaxEffect/100
}

get_VaxStart <- function(input) {
  input$VaxStart
}

get_VaxIncrease <- function(input) {
  input$VaxIncrease
}

get_Priority <- function(input) {
  c(input$Priority1,input$Priority2,input$Priority3,input$Priority4,
    input$Priority5,input$Priority6,input$Priority7,input$Priority8,
    input$Priority9)
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

# ------Other------
get_Times <- function(input) {
  Def_Times
}

get_VaxTimes <- function(input) {
  VaxGoalN <- get_VaxGoal(input) * sum(get_T0(input))
  seq(
    from=0, by=1,
    to=floor(Re(polyroot(
      c(-VaxGoalN, get_VaxStart(input), get_VaxIncrease(input)/2)
      ))[1])
  )
}