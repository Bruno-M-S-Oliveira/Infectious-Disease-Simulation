#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

source('Fun_GetCM.R')

get_Country <- function(input) {
  input$Country
}

get_LatentPeriod <- function(input) {
  input$LatentPeriod
}

get_InfectiousPeriod <- function(input) {
  input$InfectiousPeriod
}

get_T0 <- function(input) {
  c(input$T0_1,input$T0_2,input$T0_3,input$T0_4,input$T0_5,
    input$T0_6,input$T0_7,input$T0_8,input$T0_9)
}

get_E0 <- function(input) {
  return(Def_E0)
}

get_I0 <- function(input) {
  c(input$I0_1,input$I0_2,input$I0_3,input$I0_4,input$I0_5,
    input$I0_6,input$I0_7,input$I0_8,input$I0_9)
}

get_R0 <- function(input) {
  c(input$R0_1,input$R0_2,input$R0_3,input$R0_4,input$R0_5,
    input$R0_6,input$R0_7,input$R0_8,input$R0_9)
}

get_D0 <- function(input) {
  return(Def_D0)
}

get_InitialState<- function(input) {
  E0 <- get_E0(input)
  I0 <- get_I0(input)
  R0 <- get_R0(input)
  D0 <- get_D0(input)
  S0 <- get_T0(input) - I0 - R0 - D0
  
  c(S=S0, E=E0, I=I0, R=R0, D=D0)
}

get_u <- function(input) {
  c(input$u_1,input$u_2,input$u_3,input$u_4,input$u_5,
    input$u_6,input$u_7,input$u_8,input$u_9)
}

get_IFR <- function(input) {
  c(input$IFR_1,input$IFR_2,input$IFR_3,input$IFR_4,input$IFR_5,
    input$IFR_6,input$IFR_7,input$IFR_8,input$IFR_9)
}

get_Parameters<- function(input) {
  IFR <- get_IFR(input)
  
  list(u=get_u(input), CM=get_ContactMatrix(get_Country(input)),
       alpha=1/get_LatentPeriod(input),
       gamma=(1-Def_IFR)/get_InfectiousPeriod(input),
       mu=Def_IFR/get_InfectiousPeriod(input))
}