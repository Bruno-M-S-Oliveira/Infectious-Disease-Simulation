#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

plot_BeforeAgeDist <- function(DistData) {
  ggplot(data=DistData, aes(x=Age, fill=State)) + SEIRDS_theme +
    ggtitle("Distribuição Populacional Antes da Simulação") +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N)) +
    theme(legend.position='top') +
    guides(color=guide_legend(nrow=1))
}

plot_Model <- function(Result) {
  Result %>% 
    select(time, S, Sv, E, Ev, I, Iv, R, Rv, D) %>% 
    pivot_longer(!time, names_to='State', values_to='N') %>% 
    ggplot(aes(x=time, y=N, color=State)) + SEIRDS_theme +
    ggtitle("Simulação") +
    scale_x_continuous('Dia') +
    scale_y_continuous('Número de Pessoas') +
    geom_point(size=1)
}

plot_Model_Zoom <- function(Result) {
  Result %>%
    select(time, E, Ev, I, Iv, Rv, D) %>% 
    pivot_longer(!time, names_to='State', values_to='N') %>% 
    ggplot(aes(x=time, y=N, color=State)) + SEIRDS_theme +
    ggtitle("Simulação") +
    scale_x_continuous('Dia') +
    scale_y_continuous('Número de Pessoas') +
    geom_point(size=1)
}

plot_AfterAgeDist <- function(Result) {
  Data <- Result[nrow(Result),]
  
  data.frame(
    Age, 
    c(Data$S1, Data$S2, Data$S3, Data$S4, Data$S5, Data$S6, Data$S7, Data$S8, Data$S9),
    c(Data$Sv1, Data$Sv2, Data$Sv3, Data$Sv4, Data$Sv5, Data$Sv6, Data$Sv7, Data$Sv8, Data$Sv9),
    c(Data$E1, Data$E2, Data$E3, Data$E4, Data$E5, Data$E6, Data$E7, Data$E8, Data$E9),
    c(Data$Ev1, Data$Ev2, Data$Ev3, Data$Ev4, Data$Ev5, Data$Ev6, Data$Ev7, Data$Ev8, Data$Ev9),
    c(Data$I1, Data$I2, Data$I3, Data$I4, Data$I5, Data$I6, Data$I7, Data$I8, Data$I9),
    c(Data$Iv1, Data$Iv2, Data$Iv3, Data$Iv4, Data$Iv5, Data$Iv6, Data$Iv7, Data$Iv8, Data$Iv9),
    c(Data$R1, Data$R2, Data$R3, Data$R4, Data$R5, Data$R6, Data$R7, Data$R8, Data$R9),
    c(Data$Rv1, Data$Rv2, Data$Rv3, Data$Rv4, Data$Rv5, Data$Rv6, Data$Rv7, Data$Rv8, Data$Rv9),
    c(Data$D1, Data$D2, Data$D3, Data$D4, Data$D5, Data$D6, Data$D7, Data$D8, Data$D9)) %>%
    set_colnames(c('Age', 'S', 'Sv', 'E', 'Ev', 'I', 'Iv', 'R', 'Rv', 'D')) %>% 
    pivot_longer(!Age, names_to='State', values_to='N') %>% 
    ggplot(aes(x=Age, fill=State)) + SEIRDS_theme +
    ggtitle("Distribuição Populacional Após a Simulação") +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N))
}