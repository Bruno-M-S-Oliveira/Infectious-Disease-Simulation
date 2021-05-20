#  ____
# / ___|  ___ _ ____   _____ _ __
# \___ \ / _ \ '__\ \ / / _ \ '__|
#  ___) |  __/ |   \ V /  __/ |
# |____/ \___|_|    \_/ \___|_|
# Server for the Shiny App
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_GetUI.R')
source('Fun_Sim.R')
source('Fun_Plots.R')

function(input, output) {
  output$Plots <- renderPlot({
    DistData <- data.frame(Age, get_I0(input),get_R0(input),get_D0(input)) %>%
      set_colnames(c('Age','I','R','D')) %>% 
      mutate(S = get_T0(input) - I - R - D, .before=I) %>%
      pivot_longer(!Age, names_to='State', values_to='N')
    
    State <- get_InitialState(input)
    Parameters <- get_Parameters(input)
    Result <- run_Sim(State, Parameters, get_Times(input), get_VaxTimes(input))
    plot_grid(ncol=1, align = "v", plot_BeforeAgeDist(DistData), 
              plot_Model(Result), plot_Model_Zoom(Result), 
              plot_AfterAgeDist(Result))
  })
}

