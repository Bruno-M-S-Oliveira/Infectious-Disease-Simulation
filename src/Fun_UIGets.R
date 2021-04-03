#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

Get_N0Dist <- function(input) {
  c(input$N0_1,input$N0_2,input$N0_3,input$N0_4,input$N0_5,
    input$N0_6,input$N0_7,input$N0_8,input$N0_9)
}

Get_I0Dist <- function(input) {
  c(input$I0_1,input$I0_2,input$I0_3,input$I0_4,input$I0_5,
    input$I0_6,input$I0_7,input$I0_8,input$I0_9)
}

Get_InitialState<- function(input) {
  N0 <- sum(Get_N0Dist(input))
  I0 <- sum(Get_I0Dist(input))
  S0 <- N0 - I0
  
  c(S=S0, I=I0, R=0)
}