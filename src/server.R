#  ____
# / ___|  ___ _ ____   _____ _ __
# \___ \ / _ \ '__\ \ / / _ \ '__|
#  ___) |  __/ |   \ V /  __/ |
# |____/ \___|_|    \_/ \___|_|
# Server for the Shiny App
source('Init.R')
source('Fun_Plots.R')
source('Fun_UIGets.R')
source('Fun_DE.R')

function(input, output) {
  output$AgeDist <- renderPlot({
    N0 <- Get_N0Dist(input)
    AgeDistData <- data.frame(Age, N0)
    Plot_AgeDist(AgeDistData)
  })
  
  output$SickDist <- renderPlot({
    N0 <- Get_N0Dist(input)
    I0 <- Get_I0Dist(input)
    SickDistData <- data.frame(Age, N0, I0)
    Plot_SickDist(SickDistData)
  })
  
  output$SIR <- renderPlot({
    State <- Get_InitialState(input)
    times <- seq(0, 365, by=1)

    Result <- as.data.frame(ode(y=State, times=times, func=SIR_Model, parms=SIR_Param))
    
    ggplot(Result, aes(x=time)) +
      geom_point(aes(y=S, color='S')) +
      geom_point(aes(y=I, color='I')) +
      geom_point(aes(y=R, color='R'))
  })
}