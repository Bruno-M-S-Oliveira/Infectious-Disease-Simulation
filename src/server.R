#  ____
# / ___|  ___ _ ____   _____ _ __
# \___ \ / _ \ '__\ \ / / _ \ '__|
#  ___) |  __/ |   \ V /  __/ |
# |____/ \___|_|    \_/ \___|_|
# Server for the Shiny App
if(rstudioapi::isAvailable()) 
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_GetUI.R')
source('Fun_Sim.R')
source('Fun_Plots.R')

function(input, output) {
  getDistData <- reactive({ 
    data.frame(Age, get_I0(input),get_R0(input),get_D0(input)) %>%
      set_colnames(c('Age','I','R','D')) %>% 
      mutate(S = get_T0(input) - I - R - D, .before=I) %>%
      pivot_longer(!Age, names_to='Group', values_to='N')
  })
  
  getResult <- reactive({
    Group <- get_InitialState(input)
    Parameters <- get_Parameters(input)
    run_Sim(Group, Parameters, get_Times(input), get_VaxTimes(input))
  })
    
  output$Plots <- renderPlot({
    DistData <- getDistData()
    Result <- getResult()
    
    plot_grid(ncol=1, align = "v", plot_BeforeAgeDist(DistData), 
              plot_Model(Result), plot_Model_Zoom(Result), 
              plot_AfterAgeDist(Result))
  })
  
  output$Infections <- renderText({ 
    Beg <- getResult()[1,]
    End <- getResult()[nrow(getResult()),]
    
    paste("Ocorreram ", floor(
      (End$Rv + End$R + End$Rv + End$I + End$Iv + End$D)
      - (Beg$Rv + Beg$R + Beg$Rv + Beg$I + Beg$Iv + Beg$D)), 
      " novas infeções.")
  })
  
  output$Deaths <- renderText({
    End <- getResult()[nrow(getResult()),]
    paste("Morreram ", floor(End$D), 
          " pessoas.")
  })
  
  output$YLL <- renderText({ 
    End <- getResult()[nrow(getResult()),]
    LifeExp <- get_LifeExp(input)
    
    paste("Perderam-se ", floor(
      sum(LifeExp*c(End$D1, End$D2, End$D3, End$D4, End$D5,
                    End$D6, End$D7, End$D8, End$D9))),
      " anos de vida.")
  })
}

