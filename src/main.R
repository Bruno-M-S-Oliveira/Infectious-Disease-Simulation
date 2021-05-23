#  __  __       _
# |  \/  | __ _(_)_ __
# | |\/| |/ _` | | '_ \
# | |  | | (_| | | | | |
# |_|  |_|\__,_|_|_| |_|
# Example simulation
if(rstudioapi::isAvailable()) 
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_GetCM.R')
source('Fun_Plots.R')
source('Fun_Sim.R')

Initial_Condition <- data.frame(Age, Def_Sv0, Def_E0, Def_Ev0, Def_I0, Def_Iv0,
                                Def_R0, Def_Rv0, Def_D0) %>%
  set_colnames(c('Age','Sv','E','Ev','I','Iv','R','Rv','D')) %>% 
  mutate(S = Def_T0 - E - I - R - D, .after = Age)


# Simulation
CM <- get_ContactMatrix(Def_Country, "Global")
uScaling <- get_u_scaling(Def_u, CM, Def_IPeriod, Def_BRN)

VaxGoalN <- Def_VaxGoal*sum(Def_T0)
VaxTimes <- seq(
  from=0, by=1,
  to=floor(Re(polyroot(c(-VaxGoalN, Def_VaxStart, Def_VaxIncrease/2)))[1])
  )

Parameters <- list(u=Def_u/uScaling, CM=CM, EPeriod=Def_EPeriod,
                   IPeriod=Def_IPeriod, RPeriod=Def_RPeriod,
                   IFR=Def_IFR, vg=VaxGoalN, ve=Def_VaxEffect, vs=Def_VaxStart, 
                   vi=Def_VaxIncrease, Priority=Def_Priority)

Group <- c(S=Initial_Condition$S, Sv=Initial_Condition$Sv,
           E=Initial_Condition$E, Ev=Initial_Condition$Ev, 
           I=Initial_Condition$I, Iv=Initial_Condition$Iv,
           R=Initial_Condition$R, Rv=Initial_Condition$Rv,
           D=Initial_Condition$D)

Result <- run_Sim(Group, Parameters, Def_Times, VaxTimes)

# AgeDist
DistData <- Initial_Condition %>% 
  pivot_longer(!Age, names_to='Group', values_to='N')
  
BAgeDist  <- plot_BeforeAgeDist2(DistData)
Model     <- plot_Model(Result)
ModelZoom <- plot_Model_Zoom(Result)
AAgeDist  <- plot_AfterAgeDist(Result)
Legend <- get_legend(BAgeDist +
                       theme(legend.position='bottom') +    
                       guides(color=guide_legend(nrow=1)))

plot_grid(nrow=2,ncol=2, align = "v", 
          BAgeDist, Model, AAgeDist, ModelZoom,
          rel_widths = c(1,1.5,1,1.5))
plot_grid(nrow=2,ncol=1,
          last_plot(), Legend, 
          rel_heights = c(15,1))
ggsave("../Fase_C/Images/Result.png", width=40, height=20)

(Result$Totalv/(Result$Totalv + Result$Total))[366]