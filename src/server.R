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
    DistData <- data.frame(Age, get_I0(input),get_R0(input),get_D0(input)) %>%
      set_colnames(c('Age','I','R','D')) %>% 
      mutate(S = get_T0(input) - I - R - D, .before=I) %>%
      pivot_longer(!Age, names_to='State', values_to='N')
    print(DistData)
    plot_AgeDist(DistData)
  })
  
  output$SIRD <- renderPlot({
    State <- get_InitialState(input)
    Parmeters <- get_Pars(input)
    
    plot_Model(run_Sim(State, Parmeters))
  })
}

