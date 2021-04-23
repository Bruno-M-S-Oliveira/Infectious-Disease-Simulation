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
  
  output$SIRD <- renderPlot({
    State <- Get_InitialState(input)
    Parms <- Get_Pars(input)
    
    Plot_Model(Run_Sim(State, Parms))
  })
}

