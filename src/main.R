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
source('Fun_GetCM.R')
source('Fun_DE.R')

Initial_Condition <- data.frame(Age, Def_E0, Def_I0, Def_R0, Def_D0) %>%
  set_colnames(c('Age','E','I','R','D')) %>% 
  mutate(AgeDist = (E+I+R+D)/sum(E+I+R+D), .after = Age) %>% 
  mutate(S = Def_T0 - E - I - R - D, .before = I)

# AgeDist
plot_AgeDist(Initial_Condition %>% select(Age, S, E, I, R, D) %>% 
               pivot_longer(!Age, names_to='State', values_to='N'))

# Simulation
Parameters <- list(u=Def_u, CM=get_ContactMatrix(Def_Country),
                   alpha=1/Def_LatentPeriod,
                   gamma=(1-Def_IFR)/Def_InfectiousPeriod,
                   mu=Def_IFR/Def_InfectiousPeriod)

State <- c(S=Initial_Condition$S, E=Initial_Condition$E, I=Initial_Condition$I,
           R=Initial_Condition$R, D=Initial_Condition$D)

Result <- run_Sim(State, Parameters)

plot_Model(Result)
