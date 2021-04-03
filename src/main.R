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

Data <- data.frame(
  Age,
  Default_N0,
  Default_I0,
  Default_R0
  ) %>% 
  set_colnames(c('Age','N0','I0','R0'))

# AgeDist
Plot_AgeDist(Data)
  
# SickDist
Plot_SickDist(Data)

# SIR Model
Parameters <- c(b = 0.01, g = 0.001)
State <- c(S=sum(Data$N0)-sum(Data$I0), I=sum(Data$I0), R=0)
times <- seq(0, 365, by=1)

Result <- as.data.frame(ode(y=State, times=times, func=SIR_Model, parms=SIR_Param))

ggplot(Result, aes(x=time)) +
  geom_point(aes(y=S, color='S')) +
  geom_point(aes(y=I, color='I')) +
  geom_point(aes(y=R, color='R'))
