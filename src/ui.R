#  _   _ ___
# | | | |_ _|
# | | | || |
# | |_| || |
#  \___/|___|
# UI for the Shiny App
if(rstudioapi::isAvailable()) 
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source('Init.R')
source('Fun_GetUI.R')
source('Fun_Sim.R')
source('Fun_Plots.R')

fluidPage(align='center',
  titlePanel("Projeto de LID"),
  
  sidebarLayout(
    sidebarPanel(align='center',
      width=6,
      
      h3("Ao Longo da Simulação"),
      textOutput("Infections"),
      textOutput("Deaths"),
      textOutput("YLL"),
      
      h3("Parâmetros"),
      h4("Matriz de Contactos"),
      fluidRow(align='center',
               column(4, selectInput("Country", "País",
                                     c("Portugal"       = "PRT",
                                       "Espanha"        = "ESP",
                                       "Estados Unidos" = "USA"))),
               column(4, selectInput("Area", "Região",
                                     c("Global" = 0,
                                       "Rural"  = 1,
                                       "Urbana" = 2))),
               column(4, numericInput("BRN", "R0",
                                      min=0, value=Def_BRN)),
      ),
      
      h4("Doença"),
      fluidRow(align='center',
               column(4, numericInput("EPeriod", "Período Latente", 
                                      min=1, value=Def_EPeriod, max=24)),
               column(4, numericInput("IPeriod", "Período Infeccioso",
                                      min=1, value=Def_IPeriod, max=24)),
               column(4, numericInput("RPeriod", "Período de Imunidade",
                                      min=1, value=Def_RPeriod, max=1000)),
      ),
      
      h4("Vacinação"),
      fluidRow(align='center',
               column(3, numericInput("VaxGoal", "População a Vacinar (%)", 
                                      min=0, value=100*Def_VaxGoal, max=100)),
               column(3, numericInput("VaxStart", "Número Inicial de Doses", 
                                      min=0, value=Def_VaxStart)),
               column(3, numericInput("VaxIncrease", "Aumento Diário de Doses", 
                                      min=0, value=Def_VaxIncrease)),
               column(3, numericInput("VaxEffect", "Eficácia (%)", 
                                      min=0, value=100*Def_VaxEffect, max=100)),
      ),
      
      h5("Grupos Prioritários"),
      fluidRow(align='center',
        column(4, checkboxInput("Priority1", label=Age[1], value=Def_Priority[1])),
        column(4, checkboxInput("Priority2", label=Age[2], value=Def_Priority[2])),
        column(4, checkboxInput("Priority3", label=Age[3], value=Def_Priority[3])),
      ),
      fluidRow(align='center',
        column(4, checkboxInput("Priority4", label=Age[4], value=Def_Priority[4])),
        column(4, checkboxInput("Priority5", label=Age[5], value=Def_Priority[5])),
        column(4, checkboxInput("Priority6", label=Age[6], value=Def_Priority[6])),
      ),
      fluidRow(align='center',
        column(4, checkboxInput("Priority7", label=Age[7], value=Def_Priority[7])),
        column(4, checkboxInput("Priority8", label=Age[8], value=Def_Priority[8])),
        column(4, checkboxInput("Priority9", label=Age[9], value=Def_Priority[9])),
      ),
      
      h4("Por Faixa Etária"),
      h5("Dos 0 aos 9 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_1", "Pessoas"    , min=0, value=Def_T0[1])),
        column(2, numericInput("I0_1", "Infetadas"  , min=0, value=Def_I0[1])),
        column(2, numericInput("R0_1", "Recuperadas", min=0, value=Def_R0[1])),
        column(2, numericInput("u_1",  "Susceptibilidade", 
                               min=0, value=100*Def_u[1], max=100)),
        column(2, numericInput("IFR_1", "Mortalidade",
                               min=0, value=100*Def_IFR[1], max=100)),
        column(2, numericInput("LE_1", "EMV",
                               min=0, value=Def_LifeExp[1], max=100))
      ),
      
      h5("Dos 10 aos 19 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_2", "Pessoas"    , min=0, value=Def_T0[2])),
        column(2, numericInput("I0_2", "Infetadas"  , min=0, value=Def_I0[2])),
        column(2, numericInput("R0_2", "Recuperadas", min=0, value=Def_R0[2])),
        column(2, numericInput("u_2", "Susceptibilidade", 
                               min=0, value=100*Def_u[2], max=100)),
        column(2, numericInput("IFR_2", "Mortalidade",
                               min=0, value=100*Def_IFR[2], max=100)),
        column(2, numericInput("LE_2", "EMV",
                               min=0, value=Def_LifeExp[2], max=100))
      ),
      
      h5("Dos 20 aos 29 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_3", "Pessoas"    , min=0, value=Def_T0[3])),
        column(2, numericInput("I0_3", "Infetadas"  , min=0, value=Def_I0[3])),
        column(2, numericInput("R0_3", "Recuperadas", min=0, value=Def_R0[3])),
        column(2, numericInput("u_3", "Susceptibilidade",
                               min=0, value=100*Def_u[3], max=100)),
        column(2, numericInput("IFR_3", "Mortalidade",
                               min=0, value=100*Def_IFR[3], max=100)),
        column(2, numericInput("LE_3", "EMV",
                               min=0, value=Def_LifeExp[3], max=100))
      ),
      
      h5("Dos 30 aos 39 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_4", "Pessoas"    , min=0, value=Def_T0[4])),
        column(2, numericInput("I0_4", "Infetadas"  , min=0, value=Def_I0[4])),
        column(2, numericInput("R0_4", "Recuperadas", min=0, value=Def_R0[4])),
        column(2, numericInput("u_4", "Susceptibilidade",
                               min=0, value=100*Def_u[4], max=100)),
        column(2, numericInput("IFR_4", "Mortalidade",
                               min=0, value=100*Def_IFR[4], max=100)),
        column(2, numericInput("LE_4", "EMV",
                               min=0, value=Def_LifeExp[4], max=100))
      ),
      
      h5("Dos 40 aos 49 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_5", "Pessoas"    , min=0, value=Def_T0[5])),
        column(2, numericInput("I0_5", "Infetadas"  , min=0, value=Def_I0[5])),
        column(2, numericInput("R0_5", "Recuperadas", min=0, value=Def_R0[5])),
        column(2, numericInput("u_5", "Susceptibilidade",
                               min=0, value=100*Def_u[5], max=100)),
        column(2, numericInput("IFR_5", "Mortalidade",
                               min=0, value=100*Def_IFR[5], max=100)),
        column(2, numericInput("LE_5", "EMV",
                               min=0, value=Def_LifeExp[5], max=100))
      ),
      
      h5("Dos 50 aos 59 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_6", "Pessoas"    , min=0, value=Def_T0[6])),
        column(2, numericInput("I0_6", "Infetadas"  , min=0, value=Def_I0[6])),
        column(2, numericInput("R0_6", "Recuperadas", min=0, value=Def_R0[6])),
        column(2, numericInput("u_6", "Susceptibilidade",
                               min=0, value=100*Def_u[6], max=100)),
        column(2, numericInput("IFR_6", "Mortalidade",
                               min=0, value=100*Def_IFR[6], max=100)),
        column(2, numericInput("LE_6", "EMV",
                               min=0, value=Def_LifeExp[6], max=100))
      ),
      
      h5("Dos 60 aos 69 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_7", "Pessoas"    , min=0, value=Def_T0[7])),
        column(2, numericInput("I0_7", "Infetadas"  , min=0, value=Def_I0[7])),
        column(2, numericInput("R0_7", "Recuperadas", min=0, value=Def_R0[7])),
        column(2, numericInput("u_7", "Susceptibilidade",
                               min=0, value=100*Def_u[7], max=100)),
        column(2, numericInput("IFR_7", "Mortalidade",
                               min=0, value=100*Def_IFR[7], max=100)),
        column(2, numericInput("LE_7", "EMV",
                               min=0, value=Def_LifeExp[7], max=100))
      ),
      
      h5("Dos 70 aos 79 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_8", "Pessoas"    , min=0, value=Def_T0[8])),
        column(2, numericInput("I0_8", "Infetadas"  , min=0, value=Def_I0[8])),
        column(2, numericInput("R0_8", "Recuperadas", min=0, value=Def_R0[8])),
        column(2, numericInput("u_8", "Susceptibilidade",
                               min=0, value=100*Def_u[8], max=100)),
        column(2, numericInput("IFR_8", "Mortalidade",
                               min=0, value=100*Def_IFR[8], max=100)),
        column(2, numericInput("LE_8", "EMV",
                               min=0, value=Def_LifeExp[8], max=100))
      ),
      
      h5("Mais de 80 anos"),
      fluidRow(align='center',
        column(2, numericInput("T0_9", "Pessoas"    , min=0, value=Def_T0[9])),
        column(2, numericInput("I0_9", "Infetadas"  , min=0, value=Def_I0[9])),
        column(2, numericInput("R0_9", "Recuperadas", min=0, value=Def_R0[9])),
        column(2, numericInput("u_9", "Susceptibilidade",
                               min=0, value=100*Def_u[9], max=100)),
        column(2, numericInput("IFR_9", "Mortalidade",
                               min=0, value=100*Def_IFR[9], max=100)),
        column(2, numericInput("LE_9", "EMV",
                               min=0, value=Def_LifeExp[9], max=100))
      )),
    
  mainPanel(width = 6,
            plotOutput(outputId = "Plot_Legend", height='70px'),
            plotOutput(outputId = "Plot_AgeDist", heigh='400px'),
            plotOutput(outputId = "Plot_Model", height='800px'),
    )
  )
)