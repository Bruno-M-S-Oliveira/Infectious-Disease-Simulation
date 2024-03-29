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
  titlePanel("Infectious Disease Simulation"),
  h4("Defaults to Covid-19 Values for Portugal"),

  sidebarLayout(
    sidebarPanel(align='center',
      width=6,

      h3("During the Simulation"),
      textOutput("Infections"),
      textOutput("Deaths"),
      textOutput("YLL"),

      h3("Parameters"),
      h4(HTML("<strong>Contact Matrix</strong>")),
      fluidRow(align='center',
               column(4, selectInput("Country", "País",
                                     c("Portugal"                 = "PRT",
                                       "Spain"                    = "ESP",
                                       "France"                   = "FRA",
                                       "United Kingdom"           = "GBR",
                                       "Brazil"                   = "BRA",
                                       "United States of America" = "USA",
                                       "India"                    = "IND",
                                       "Hong Kong"                = "HKG",
                                       "China"                    = "CHN"))),
               column(4, selectInput("Area", "Região",
                                     c("Global" = 0,
                                       "Rural"  = 1,
                                       "Urbana" = 2))),
               column(4, numericInput("BRN", "R0",
                                      min=0, max=10, step=.1, value=Def_BRN)),
      ),

      h4(HTML("<strong>Disease</strong>")),
      fluidRow(align='center',
               column(4, numericInput("EPeriod", "Latent Period",
                                      min=1, value=Def_EPeriod, max=24)),
               column(4, numericInput("IPeriod", "Infectious Period",
                                      min=1, value=Def_IPeriod, max=24)),
               column(4, numericInput("RPeriod", "Immunity Period",
                                      min=1, value=Def_RPeriod, max=1000)),
      ),

      h4(HTML("<strong>Vaccination</strong>")),
      fluidRow(align='center',
               column(3, numericInput("VaxGoal", "Population to Vaccinate (%)",
                                      min=0, value=100*Def_VaxGoal, max=100)),
               column(3, numericInput("VaxStart", "Initial Number of Doses",
                                      min=0, value=Def_VaxStart)),
               column(3, numericInput("VaxIncrease", "Daily Increase of Doses",
                                      min=0, value=Def_VaxIncrease)),
               column(3, numericInput("VaxEffect", "Efficacy (%)",
                                      min=0, value=100*Def_VaxEffect, max=100)),
      ),

      h5("Prioritary Groups"),
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

      h4(HTML("<strong>From 0 to 9</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_1", "Population" , min=0, value=Def_T0[1],
                               step=100)),
        column(4, numericInput("I0_1", "Infected"   , min=0, value=Def_I0[1],
                               step=100)),
        column(4, numericInput("R0_1", "Recovered"  , min=0, value=Def_R0[1],
                               step=100)),
        column(3, numericInput("u_1",  "Susceptibility",
                               min=0, value=100*Def_u[1], max=100)),
        column(3, numericInput("IFR_1", "Mortality",
                               min=0, value=100*Def_IFR[1], max=100)),
        column(3, numericInput("NVax_1", "Antivaxx",
                               min=0, value=100*Def_NVax[1], max=100)),
        column(3, numericInput("LE_1", "Life Expectancy",
                               min=0, value=Def_LifeExp[1], max=100)),
      ),

      h4(HTML("<strong>From 10 to 19</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_2", "Population" , min=0, value=Def_T0[2],
                               step=100)),
        column(4, numericInput("I0_2", "Infected"   , min=0, value=Def_I0[2],
                               step=100)),
        column(4, numericInput("R0_2", "Recovered"  , min=0, value=Def_R0[2],
                               step=100)),
        column(3, numericInput("u_2", "Susceptibility",
                               min=0, value=100*Def_u[2], max=100)),
        column(3, numericInput("IFR_2", "Mortality",
                               min=0, value=100*Def_IFR[2], max=100)),
        column(3, numericInput("NVax_2", "Antivaxx",
                               min=0, value=100*Def_NVax[2], max=100)),
        column(3, numericInput("LE_2", "Life Expectancy",
                               min=0, value=Def_LifeExp[2], max=100)),
      ),

      h4(HTML("<strong>From 20 to 29</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_3", "Population" , min=0, value=Def_T0[3],
                               step=100)),
        column(4, numericInput("I0_3", "Infected"   , min=0, value=Def_I0[3],
                               step=100)),
        column(4, numericInput("R0_3", "Recovered"  , min=0, value=Def_R0[3],
                               step=100)),
        column(3, numericInput("u_3", "Susceptibility",
                               min=0, value=100*Def_u[3], max=100)),
        column(3, numericInput("IFR_3", "Mortality",
                               min=0, value=100*Def_IFR[3], max=100)),
        column(3, numericInput("NVax_3", "Antivaxx",
                               min=0, value=100*Def_NVax[3], max=100)),
        column(3, numericInput("LE_3", "Life Expectancy",
                               min=0, value=Def_LifeExp[3], max=100)),
      ),

      h4(HTML("<strong>From 30 to 39</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_4", "Population" , min=0, value=Def_T0[4],
                               step=100)),
        column(4, numericInput("I0_4", "Infected"   , min=0, value=Def_I0[4],
                               step=100)),
        column(4, numericInput("R0_4", "Recovered"  , min=0, value=Def_R0[4],
                               step=100)),
        column(3, numericInput("u_4", "Susceptibility",
                               min=0, value=100*Def_u[4], max=100)),
        column(3, numericInput("IFR_4", "Mortality",
                               min=0, value=100*Def_IFR[4], max=100)),
        column(3, numericInput("NVax_4", "Antivaxx",
                               min=0, value=100*Def_NVax[4], max=100)),
        column(3, numericInput("LE_4", "Life Expectancy",
                               min=0, value=Def_LifeExp[4], max=100)),
      ),

      h4(HTML("<strong>From 40 to 49</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_5", "Population" , min=0, value=Def_T0[5],
                               step=100)),
        column(4, numericInput("I0_5", "Infected"   , min=0, value=Def_I0[5],
                               step=100)),
        column(4, numericInput("R0_5", "Recovered"  , min=0, value=Def_R0[5],
                               step=100)),
        column(3, numericInput("u_5", "Susceptibility",
                               min=0, value=100*Def_u[5], max=100)),
        column(3, numericInput("IFR_5", "Mortality",
                               min=0, value=100*Def_IFR[5], max=100)),
        column(3, numericInput("NVax_5", "Antivaxx",
                               min=0, value=100*Def_NVax[5], max=100)),
        column(3, numericInput("LE_5", "Life Expectancy",
                               min=0, value=Def_LifeExp[5], max=100)),
      ),

      h4(HTML("<strong>From 50 to 59</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_6", "Population" , min=0, value=Def_T0[6],
                               step=100)),
        column(4, numericInput("I0_6", "Infected"   , min=0, value=Def_I0[6],
                               step=100)),
        column(4, numericInput("R0_6", "Recovered"  , min=0, value=Def_R0[6],
                               step=100)),
        column(3, numericInput("u_6", "Susceptibility",
                               min=0, value=100*Def_u[6], max=100)),
        column(3, numericInput("IFR_6", "Mortality",
                               min=0, value=100*Def_IFR[6], max=100)),
        column(3, numericInput("NVax_6", "Antivaxx",
                               min=0, value=100*Def_NVax[6], max=100)),
        column(3, numericInput("LE_6", "Life Expectancy",
                               min=0, value=Def_LifeExp[6], max=100)),
      ),

      h4(HTML("<strong>From 60 to 69</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_7", "Population" , min=0, value=Def_T0[7],
                               step=100)),
        column(4, numericInput("I0_7", "Infected"   , min=0, value=Def_I0[7],
                               step=100)),
        column(4, numericInput("R0_7", "Recovered"  , min=0, value=Def_R0[7],
                               step=100)),
        column(3, numericInput("u_7", "Susceptibility",
                               min=0, value=100*Def_u[7], max=100)),
        column(3, numericInput("IFR_7", "Mortality",
                               min=0, value=100*Def_IFR[7], max=100)),
        column(3, numericInput("NVax_7", "Antivaxx",
                               min=0, value=100*Def_NVax[7], max=100)),
        column(3, numericInput("LE_7", "Life Expectancy",
                               min=0, value=Def_LifeExp[7], max=100)),
      ),

      h4(HTML("<strong>From 70 to 79</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_8", "Population" , min=0, value=Def_T0[8],
                               step=100)),
        column(4, numericInput("I0_8", "Infected"   , min=0, value=Def_I0[8],
                               step=100)),
        column(4, numericInput("R0_8", "Recovered"  , min=0, value=Def_R0[8],
                               step=100)),
        column(3, numericInput("u_8", "Susceptibility",
                               min=0, value=100*Def_u[8], max=100)),
        column(3, numericInput("IFR_8", "Mortality",
                               min=0, value=100*Def_IFR[8], max=100)),
        column(3, numericInput("NVax_8", "Antivaxx",
                               min=0, value=100*Def_NVax[8], max=100)),
        column(3, numericInput("LE_8", "Life Expectancy",
                               min=0, value=Def_LifeExp[8], max=100)),
      ),

      h4(HTML("<strong>Over 80</strong>")),
      fluidRow(align='center',
        column(4, numericInput("T0_9", "Population" , min=0, value=Def_T0[9],
                               step=100)),
        column(4, numericInput("I0_9", "Infected"   , min=0, value=Def_I0[9],
                               step=100)),
        column(4, numericInput("R0_9", "Recovered"  , min=0, value=Def_R0[9],
                               step=100)),
        column(3, numericInput("u_9", "Susceptibility",
                               min=0, value=100*Def_u[9], max=100)),
        column(3, numericInput("IFR_9", "Mortality",
                               min=0, value=100*Def_IFR[9], max=100)),
        column(3, numericInput("NVax_9", "Antivaxx",
                               min=0, value=100*Def_NVax[9], max=100)),
        column(3, numericInput("LE_9", "Life Expectancy",
                               min=0, value=Def_LifeExp[9], max=100)),
      )),

  mainPanel(width = 6,
            plotOutput(outputId = "Plot_Legend", height='100px'),
            plotOutput(outputId = "Plot_AgeDist", heigh='400px'),
            plotOutput(outputId = "Plot_Model", height='800px'),
    )
  )
)