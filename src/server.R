#  ____
# / ___|  ___ _ ____   _____ _ __
# \___ \ / _ \ '__\ \ / / _ \ '__|
#  ___) |  __/ |   \ V /  __/ |
# |____/ \___|_|    \_/ \___|_|
# Server for the Shiny App
rm(list=ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_Plots.R')
source('Fun_UIGets.R')
source('Fun_DE.R')

function(input, output) {
  output$AgeDist <- renderPlot({
    DistData <- data.frame(Age, Get_I0(input),Get_R0(input),Get_D0(input)) %>%
      set_colnames(c('Age','I','R','D')) %>% 
      mutate(S = Get_T0(input) - I - R - D, .before=I) %>%
      pivot_longer(!Age, names_to='State', values_to='N')
    print(DistData)
    Plot_AgeDist(DistData)
  })
  
  output$SIR <- renderPlot({
    State <- Get_InitialState(input)
    Parms <- Get_Pars(input)
    
    Result <- as.data.frame(
      ode(y=State, times=Def_Times, func=SIR_Model, parms=Parms)) %>% 
      mutate(S=S1+S2+S3+S4+S5+S6+S7+S8+S9) %>% 
      mutate(I=I1+I2+I3+I4+I5+I6+I7+I8+I9) %>% 
      mutate(R=R1+R2+R3+R4+R5+R6+R7+R8+R9) %>% 
      mutate(D=D1+D2+D3+D4+D5+D6+D7+D8+D9) %>% 
      mutate(N=S+I+R)
    
    Plot_Model(Result)
  })
}

