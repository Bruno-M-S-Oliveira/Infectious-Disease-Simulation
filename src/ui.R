#  _   _ ___
# | | | |_ _|
# | | | || |
# | |_| || |
#  \___/|___|
# UI for the Shiny App
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_GetUI.R')
source('Fun_Sim.R')
source('Fun_Plots.R')

fluidPage(
  titlePanel("Projeto de LID"),
  
  sidebarLayout(
    sidebarPanel(
      width=7,
      
      h4("Parâmetros"),
      fluidRow(align='center',
               column(4, selectInput("Country", "País:",
                                     c("Portugal"       = "PRT",
                                       "Espanha"        = "ESP",
                                       "Estados Unidos" = "USA"))),
               column(4, selectInput("Area", "Área:",
                                     c("Global" = 0,
                                       "Rural"  = 1,
                                       "Urbana" = 2))),
               column(4, numericInput("BRN", "R0",
                                      min=0, value=Def_BRN)),
      ),
      
      fluidRow(align='center',
               column(4, numericInput("EPeriod", "Período Latente", 
                                      min=1, value=Def_EPeriod, max=24)),
               column(4, numericInput("IPeriod", "Período Infeccioso",
                                      min=1, value=Def_IPeriod, max=24)),
               column(4, numericInput("RPeriod", "Período de Imunidade",
                                      min=1, value=Def_RPeriod, max=1000)),
      ),
      
      fluidRow(align='center',
               column(3, numericInput("VaxGoal", "Imunidade de Rebanho (%)", 
                                      min=0, value=100*Def_VaxGoal, max=100)),
               column(3, numericInput("VaxEffect", "Eficácia das Vacinas (%)", 
                                      min=0, value=100*Def_VaxEffect, max=100)),
               column(3, numericInput("VaxStart", "Número Inicial de Vacinas", 
                                      min=0, value=Def_VaxStart)),
               column(3, numericInput("VaxIncrease", "Aumento Diário de Vacinas", 
                                      min=0, value=Def_VaxIncrease)),
      ),
      
      h4(Age[1]),
      fluidRow(align='center',
        column(2, numericInput("T0_1", "Pessoas"    , min=0, value=Def_T0[1])),
        column(2, numericInput("I0_1", "Infetadas"  , min=0, value=Def_I0[1])),
        column(2, numericInput("R0_1", "Recuperadas", min=0, value=Def_R0[1])),
        column(2, numericInput("u_1",  "Susceptibilidade", 
                               min=0, value=100*Def_u[1], max=100)),
        column(2, numericInput("IFR_1", "Mortalidade",
                               min=0, value=100*Def_IFR[1], max=100)),
        column(2, checkboxInput("Priority1", label="Prioridade", 
                                value=Def_Priority[1]))
      ),
      
      h4(Age[2]),
      fluidRow(align='center',
        column(2, numericInput("T0_2", "Pessoas"    , min=0, value=Def_T0[2])),
        column(2, numericInput("I0_2", "Infetadas"  , min=0, value=Def_I0[2])),
        column(2, numericInput("R0_2", "Recuperadas", min=0, value=Def_R0[2])),
        column(2, numericInput("u_2", "Susceptibilidade", 
                               min=0, value=100*Def_u[2], max=100)),
        column(2, numericInput("IFR_2", "Mortalidade",
                               min=0, value=100*Def_IFR[2], max=100)),
        column(2, checkboxInput("Priority2", label="Prioridade", 
                                value=Def_Priority[2]))
      ),
      
      h4(Age[3]),
      fluidRow(align='center',
        column(2, numericInput("T0_3", "Pessoas"    , min=0, value=Def_T0[3])),
        column(2, numericInput("I0_3", "Infetadas"  , min=0, value=Def_I0[3])),
        column(2, numericInput("R0_3", "Recuperadas", min=0, value=Def_R0[3])),
        column(2, numericInput("u_3", "Susceptibilidade",
                               min=0, value=100*Def_u[3], max=100)),
        column(2, numericInput("IFR_3", "Mortalidade",
                               min=0, value=100*Def_IFR[3], max=100)),
        column(2, checkboxInput("Priority3", label="Prioridade", 
                                value=Def_Priority[3]))
      ),
      
      h4(Age[4]),
      fluidRow(align='center',
        column(2, numericInput("T0_4", "Pessoas"    , min=0, value=Def_T0[4])),
        column(2, numericInput("I0_4", "Infetadas"  , min=0, value=Def_I0[4])),
        column(2, numericInput("R0_4", "Recuperadas", min=0, value=Def_R0[4])),
        column(2, numericInput("u_4", "Susceptibilidade",
                               min=0, value=100*Def_u[4], max=100)),
        column(2, numericInput("IFR_4", "Mortalidade",
                               min=0, value=100*Def_IFR[4], max=100)),
        column(2, checkboxInput("Priority4", label="Prioridade", 
                                value=Def_Priority[4]))
      ),
      
      h4(Age[5]),
      fluidRow(align='center',
        column(2, numericInput("T0_5", "Pessoas"    , min=0, value=Def_T0[5])),
        column(2, numericInput("I0_5", "Infetadas"  , min=0, value=Def_I0[5])),
        column(2, numericInput("R0_5", "Recuperadas", min=0, value=Def_R0[5])),
        column(2, numericInput("u_5", "Susceptibilidade",
                               min=0, value=100*Def_u[5], max=100)),
        column(2, numericInput("IFR_5", "Mortalidade",
                               min=0, value=100*Def_IFR[5], max=100)),
        column(2, checkboxInput("Priority5", label="Prioridade", 
                                value=Def_Priority[5]))
      ),
      
      h4(Age[6]),
      fluidRow(align='center',
        column(2, numericInput("T0_6", "Pessoas"    , min=0, value=Def_T0[6])),
        column(2, numericInput("I0_6", "Infetadas"  , min=0, value=Def_I0[6])),
        column(2, numericInput("R0_6", "Recuperadas", min=0, value=Def_R0[6])),
        column(2, numericInput("u_6", "Susceptibilidade",
                               min=0, value=100*Def_u[6], max=100)),
        column(2, numericInput("IFR_6", "Mortalidade",
                               min=0, value=100*Def_IFR[6], max=100)),
        column(2, checkboxInput("Priority6", label="Prioridade", 
                                value=Def_Priority[6]))
      ),
      
      h4(Age[7]),
      fluidRow(align='center',
        column(2, numericInput("T0_7", "Pessoas"    , min=0, value=Def_T0[7])),
        column(2, numericInput("I0_7", "Infetadas"  , min=0, value=Def_I0[7])),
        column(2, numericInput("R0_7", "Recuperadas", min=0, value=Def_R0[7])),
        column(2, numericInput("u_7", "Susceptibilidade",
                               min=0, value=100*Def_u[7], max=100)),
        column(2, numericInput("IFR_7", "Mortalidade",
                               min=0, value=100*Def_IFR[7], max=100)),
        column(2, checkboxInput("Priority7", label="Prioridade", 
                                value=Def_Priority[7]))
      ),
      
      h4(Age[8]),
      fluidRow(align='center',
        column(2, numericInput("T0_8", "Pessoas"    , min=0, value=Def_T0[8])),
        column(2, numericInput("I0_8", "Infetadas"  , min=0, value=Def_I0[8])),
        column(2, numericInput("R0_8", "Recuperadas", min=0, value=Def_R0[8])),
        column(2, numericInput("u_8", "Susceptibilidade",
                               min=0, value=100*Def_u[8], max=100)),
        column(2, numericInput("IFR_8", "Mortalidade",
                               min=0, value=100*Def_IFR[8], max=100)),
        column(2, checkboxInput("Priority8", label="Prioridade", 
                                value=Def_Priority[8]))
      ),
      
      h4(Age[9]),
      fluidRow(align='center',
        column(2, numericInput("T0_9", "Pessoas"    , min=0, value=Def_T0[9])),
        column(2, numericInput("I0_9", "Infetadas"  , min=0, value=Def_I0[9])),
        column(2, numericInput("R0_9", "Recuperadas", min=0, value=Def_R0[9])),
        column(2, numericInput("u_9", "Susceptibilidade",
                               min=0, value=100*Def_u[9], max=100)),
        column(2, numericInput("IFR_9", "Mortalidade",
                               min=0, value=100*Def_IFR[9], max=100)),
        column(2, checkboxInput("Priority9", label="Prioridade", 
                                value=Def_Priority[9]))
      )),
    
  mainPanel(
    width = 5,
    plotOutput(outputId = "Plots", height='1600px')
    )
  )
)