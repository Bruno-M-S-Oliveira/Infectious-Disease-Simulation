#  _   _ ___
# | | | |_ _|
# | | | || |
# | |_| || |
#  \___/|___|
# UI for the Shiny App
rm(list=ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_GetUI.R')
source('Fun_Sim.R')
source('Fun_Plots.R')

fluidPage(
  titlePanel("Projeto de LID"),
  
  sidebarLayout(
    sidebarPanel(
      width=6,
      
      h4("Parâmetros"),
      fluidRow(align='center',
               column(3, selectInput("Country", "País:",
                                     c("Portugal" = "PRT",
                                       "Estados Unidos" = "USA",
                                       "Espanha" = "ESP"))),
               column(3, numericInput("LPeriod", "Período Latente", 
                                      min=0, value=Def_LatentPeriod, max=20)),
               column(3, numericInput("IPeriod", "Período Infeccioso",
                                      min=0, value=Def_InfectiousPeriod, max=20)),
               column(3, numericInput("BRN", "R0", #"Número Básico de Reprodução",
                                      min=0, value=Def_BRN)),
      ),
      
      fluidRow(align='center',
               column(3, numericInput("VaxGoal", "Imunidade de Rebanho (%)", 
                                      min=0, value=100*Def_VaxGoal, max=100)),
               column(3, numericInput("VaxEffect", "Eficácia da Vacina (%)", 
                                      min=0, value=100*Def_VaxEffect, max=100)),
               column(3, numericInput("VaxStart", "Número Inicial de Vacinas", 
                                      min=0, value=Def_VaxStart)),
               column(3, numericInput("VaxIncrease", "Aumento Diária de Vacinas", 
                                      min=0, value=Def_VaxIncrease)),
      ),
      
      h4(Age[1]),
      fluidRow(align='center',
        column(2, numericInput("T0_1", "Pessoas"    , min=0, value=Def_T0[1])),
        column(2, numericInput("I0_1", "Infetadas"  , min=0, value=Def_I0[1])),
        column(2, numericInput("R0_1", "Recuperadas", min=0, value=Def_R0[1])),
        column(3, numericInput("u_1", "Susceptibilidade (%)", 
                               min=0, value=100*Def_u[1], max=100)),
        column(3, numericInput("IFR_1", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[1], max=100))
      ),
      
      h4(Age[2]),
      fluidRow(align='center',
        column(2, numericInput("T0_2", "Pessoas"    , min=0, value=Def_T0[2])),
        column(2, numericInput("I0_2", "Infetadas"  , min=0, value=Def_I0[2])),
        column(2, numericInput("R0_2", "Recuperadas", min=0, value=Def_R0[2])),
        column(3, numericInput("u_2", "Susceptibilidade (%)", 
                               min=0, value=100*Def_u[2], max=1)),
        column(3, numericInput("IFR_2", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[2], max=100))
      ),
      
      h4(Age[3]),
      fluidRow(align='center',
        column(2, numericInput("T0_3", "Pessoas"    , min=0, value=Def_T0[3])),
        column(2, numericInput("I0_3", "Infetadas"  , min=0, value=Def_I0[3])),
        column(2, numericInput("R0_3", "Recuperadas", min=0, value=Def_R0[3])),
        column(3, numericInput("u_3", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[3], max=100)),
        column(3, numericInput("IFR_3", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[3], max=100))
      ),
      
      h4(Age[4]),
      fluidRow(align='center',
        column(2, numericInput("T0_4", "Pessoas"    , min=0, value=Def_T0[4])),
        column(2, numericInput("I0_4", "Infetadas"  , min=0, value=Def_I0[4])),
        column(2, numericInput("R0_4", "Recuperadas", min=0, value=Def_R0[4])),
        column(3, numericInput("u_4", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[4], max=100)),
        column(3, numericInput("IFR_4", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[4], max=100))
      ),
      
      h4(Age[5]),
      fluidRow(align='center',
        column(2, numericInput("T0_5", "Pessoas"    , min=0, value=Def_T0[5])),
        column(2, numericInput("I0_5", "Infetadas"  , min=0, value=Def_I0[5])),
        column(2, numericInput("R0_5", "Recuperadas", min=0, value=Def_R0[5])),
        column(3, numericInput("u_5", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[5], max=100)),
        column(3, numericInput("IFR_5", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[5], max=100))
      ),
      
      h4(Age[6]),
      fluidRow(align='center',
        column(2, numericInput("T0_6", "Pessoas"    , min=0, value=Def_T0[6])),
        column(2, numericInput("I0_6", "Infetadas"  , min=0, value=Def_I0[6])),
        column(2, numericInput("R0_6", "Recuperadas", min=0, value=Def_R0[6])),
        column(3, numericInput("u_6", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[6], max=100)),
        column(3, numericInput("IFR_6", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[6], max=100))
      ),
      
      h4(Age[7]),
      fluidRow(align='center',
        column(2, numericInput("T0_7", "Pessoas"    , min=0, value=Def_T0[7])),
        column(2, numericInput("I0_7", "Infetadas"  , min=0, value=Def_I0[7])),
        column(2, numericInput("R0_7", "Recuperadas", min=0, value=Def_R0[7])),
        column(3, numericInput("u_7", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[7], max=100)),
        column(3, numericInput("IFR_7", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[7], max=100))
      ),
      
      h4(Age[8]),
      fluidRow(align='center',
        column(2, numericInput("T0_8", "Pessoas"    , min=0, value=Def_T0[8])),
        column(2, numericInput("I0_8", "Infetadas"  , min=0, value=Def_I0[8])),
        column(2, numericInput("R0_8", "Recuperadas", min=0, value=Def_R0[8])),
        column(3, numericInput("u_8", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[8], max=100)),
        column(3, numericInput("IFR_8", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[8], max=100))
      ),
      
      h4(Age[9]),
      fluidRow(align='center',
        column(2, numericInput("T0_9", "Pessoas"    , min=0, value=Def_T0[9])),
        column(2, numericInput("I0_9", "Infetadas"  , min=0, value=Def_I0[9])),
        column(2, numericInput("R0_9", "Recuperadas", min=0, value=Def_R0[9])),
        column(3, numericInput("u_9", "Susceptibilidade (%)",
                               min=0, value=100*Def_u[9], max=100)),
        column(3, numericInput("IFR_9", "Mortalidade (%)",
                               min=0, value=100*Def_IFR[9], max=100))
      )),
    
  mainPanel(
    width = 6,
    plotOutput(outputId = "Plots", height='1200px')
    #plotOutput(outputId = "AgeDist"),
    #kplotOutput(outputId = "Plots"),
    #plotOutput(outputId = "Plot_Zoom")
    )
  )
)
