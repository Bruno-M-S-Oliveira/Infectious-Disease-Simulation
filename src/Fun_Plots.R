#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
# Extra functions to avoid cluttering up the code

plot_BeforeAgeDist <- function(DistData) {
  ggplot(data=DistData, aes(x=Age, fill=Group)) + SEIRDS_theme +
    ggtitle("Distribuição Populacional Antes da Simulação") +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N))
}

plot_AfterAgeDist <- function(Result) {
  Data <- Result[nrow(Result),]

  Teste <- data.frame(
    Age,
    c(Data$Sv1, Data$Sv2, Data$Sv3, Data$Sv4, Data$Sv5, Data$Sv6, Data$Sv7, Data$Sv8, Data$Sv9),
    c(Data$S1 , Data$S2 , Data$S3 , Data$S4 , Data$S5 , Data$S6 , Data$S7 , Data$S8 , Data$S9 ),
    c(Data$Sx1, Data$Sx2, Data$Sx3, Data$Sx4, Data$Sx5, Data$Sx6, Data$Sx7, Data$Sx8, Data$Sx9),
    c(Data$Ev1, Data$Ev2, Data$Ev3, Data$Ev4, Data$Ev5, Data$Ev6, Data$Ev7, Data$Ev8, Data$Ev9),
    c(Data$E1 , Data$E2 , Data$E3 , Data$E4 , Data$E5 , Data$E6 , Data$E7 , Data$E8 , Data$E9 ),
    c(Data$Ex1, Data$Ex2, Data$Ex3, Data$Ex4, Data$Ex5, Data$Ex6, Data$Ex7, Data$Ex8, Data$Ex9),
    c(Data$Iv1, Data$Iv2, Data$Iv3, Data$Iv4, Data$Iv5, Data$Iv6, Data$Iv7, Data$Iv8, Data$Iv9),
    c(Data$I1 , Data$I2 , Data$I3 , Data$I4 , Data$I5 , Data$I6 , Data$I7 , Data$I8 , Data$I9 ),
    c(Data$Ix1, Data$Ix2, Data$Ix3, Data$Ix4, Data$Ix5, Data$Ix6, Data$Ix7, Data$Ix8, Data$Ix9),
    c(Data$Rv1, Data$Rv2, Data$Rv3, Data$Rv4, Data$Rv5, Data$Rv6, Data$Rv7, Data$Rv8, Data$Rv9),
    c(Data$R1 , Data$R2 , Data$R3 , Data$R4 , Data$R5 , Data$R6 , Data$R7 , Data$R8 , Data$R9 ),
    c(Data$Rx1, Data$Rx2, Data$Rx3, Data$Rx4, Data$Rx5, Data$Rx6, Data$Rx7, Data$Rx8, Data$Rx9),
    c(Data$D1 , Data$D2 , Data$D3 , Data$D4 , Data$D5 , Data$D6 , Data$D7 , Data$D8 , Data$D9)) %>%
    set_colnames(c('Age', 
                   'Sv', 'S', 'Sx', 'Ev', 'E', 'Ex', 
                   'Iv', 'I', 'Ix', 'Rv', 'R', 'Rx', 'D')) %>% 
    pivot_longer(!Age, names_to='Group', values_to='N') %>%
    mutate(Group = factor(Group, levels=c('D','Rv','R','Rx','Iv','I','Ix','Ev','E','Ex','Sv','S','Sx')))
  
  Teste %>% 
    ggplot(aes(x=Age, fill=Group)) + SEIRDS_theme +
    ggtitle("Distribuição Populacional Após a Simulação") +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N))
}

plot_Model <- function(Result) {
  Result %>%
    select(time, S, Sx, Sv, E, Ev, I, Ix, Iv, R, Rx, Rv, D) %>%
    pivot_longer(!time, names_to='Group', values_to='N') %>%
    ggplot(aes(x=time, y=N, color=Group)) + SEIRDS_theme +
    ggtitle("Simulação") +
    scale_x_continuous('Dia') +
    scale_y_continuous('Número de Pessoas') +
    geom_line(size=1)
}

plot_Model_Zoom <- function(Result) {
  Result %>%
    select(time, E, Ex, Ev, I, Ix, Iv, D) %>%
    pivot_longer(!time, names_to='Group', values_to='N') %>%
    ggplot(aes(x=time, y=N, color=Group)) + SEIRDS_theme +
    ggtitle("Simulação") +
    scale_x_continuous('Dia') +
    scale_y_continuous('Número de Pessoas') +
    geom_line(size=1)
}