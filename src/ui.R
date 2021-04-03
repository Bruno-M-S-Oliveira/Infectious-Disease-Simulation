#  _   _ ___
# | | | |_ _|
# | | | || |
# | |_| || |
#  \___/|___|
# UI for the Shiny App
source('Init.R')
source('Fun_Plots.R')
source('Fun_UIGets.R')
source('Fun_DE.R')

fluidPage(
  titlePanel("Projeto de LID"),
  
  sidebarLayout(
    sidebarPanel(
      h4(Age[1]),
      fluidRow(align='center',
        column(4, numericInput("N0_1", "# Pessoas"    , min=0, value=Def_N0[1])),
        column(4, numericInput("I0_1", "# Infetadas"  , min=0, value=Def_I0[1])),
        column(4, numericInput("R0_1", "# Recuperadas", min=0, value=Def_R0[1]))
      ),
      
      h4(Age[2]),
      fluidRow(align='center',
        column(4, numericInput("N0_2", "# Pessoas"    , min=0, value=Def_N0[2])),
        column(4, numericInput("I0_2", "# Infetadas"  , min=0, value=Def_I0[2])),
        column(4, numericInput("R0_2", "# Recuperadas", min=0, value=Def_R0[2]))
      ),
      
      h4(Age[3]),
      fluidRow(align='center',
        column(4, numericInput("N0_3", "# Pessoas"    , min=0, value=Def_N0[3])),
        column(4, numericInput("I0_3", "# Infetadas"  , min=0, value=Def_I0[3])),
        column(4, numericInput("R0_3", "# Recuperadas", min=0, value=Def_R0[3]))
      ),
      
      h4(Age[4]),
      fluidRow(align='center',
        column(4, numericInput("N0_4", "# Pessoas"    , min=0, value=Def_N0[4])),
        column(4, numericInput("I0_4", "# Infetadas"  , min=0, value=Def_I0[4])),
        column(4, numericInput("R0_4", "# Recuperadas", min=0, value=Def_R0[4]))
      ),
      
      h4(Age[5]),
      fluidRow(align='center',
        column(4, numericInput("N0_5", "# Pessoas"    , min=0, value=Def_N0[5])),
        column(4, numericInput("I0_5", "# Infetadas"  , min=0, value=Def_I0[5])),
        column(4, numericInput("R0_5", "# Recuperadas", min=0, value=Def_R0[5]))
      ),
      
      h4(Age[6]),
      fluidRow(align='center',
        column(4, numericInput("N0_6", "# Pessoas"    , min=0, value=Def_N0[6])),
        column(4, numericInput("I0_6", "# Infetadas"  , min=0, value=Def_I0[6])),
        column(4, numericInput("R0_6", "# Recuperadas", min=0, value=Def_R0[6]))
      ),
      
      h4(Age[7]),
      fluidRow(align='center',
        column(4, numericInput("N0_7", "# Pessoas"    , min=0, value=Def_N0[7])),
        column(4, numericInput("I0_7", "# Infetadas"  , min=0, value=Def_I0[7])),
        column(4, numericInput("R0_7", "# Recuperadas", min=0, value=Def_R0[7]))
      ),
      
      h4(Age[8]),
      fluidRow(align='center',
        column(4, numericInput("N0_8", "# Pessoas"    , min=0, value=Def_N0[8])),
        column(4, numericInput("I0_8", "# Infetadas"  , min=0, value=Def_I0[8])),
        column(4, numericInput("R0_8", "# Recuperadas", min=0, value=Def_R0[8]))
      ),
      
      h4(Age[9]),
      fluidRow(align='center',
        column(4, numericInput("N0_9", "# Pessoas"    , min=0, value=Def_N0[9])),
        column(4, numericInput("I0_9", "# Infetadas"  , min=0, value=Def_I0[9])),
        column(4, numericInput("R0_9", "# Recuperadas", min=0, value=Def_R0[9]))
      )),
    
  mainPanel(
    #plotOutput(outputId = "AgeDist"),
    plotOutput(outputId = "SickDist"),
    plotOutput(outputId = "SIR")
    )
  )
)
