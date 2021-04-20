#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

Get_T0 <- function(input) {
  c(input$T0_1,input$T0_2,input$T0_3,input$T0_4,input$T0_5,
    input$T0_6,input$T0_7,input$T0_8,input$T0_9)
}

Get_I0 <- function(input) {
  c(input$I0_1,input$I0_2,input$I0_3,input$I0_4,input$I0_5,
    input$I0_6,input$I0_7,input$I0_8,input$I0_9)
}

Get_R0 <- function(input) {
  c(input$R0_1,input$R0_2,input$R0_3,input$R0_4,input$R0_5,
    input$R0_6,input$R0_7,input$R0_8,input$R0_9)
}

Get_D0 <- function(input) {
  return(Def_D0)
}

Get_InitialState<- function(input) {
  T0 <- Get_T0(input)
  I0 <- Get_I0(input)
  R0 <- Get_R0(input)
  D0 <- Get_D0(input)
  S0 <- T0 - I0 - R0 - D0
  
  c(S=S0, I=Def_I0, R=Def_R0, D=Def_D0)
}

Get_mu <- function(input) {
  c(input$mu_1,input$mu_2,input$mu_3,input$mu_4,input$mu_5,
    input$mu_6,input$mu_7,input$mu_8,input$mu_9)
}

Get_Pars<- function(input) {
  list(beta=Def_b, gamma=Def_g, mu=Def_mu)
}