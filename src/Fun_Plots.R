#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

plot_AgeDist <- function(SickDistData) {
  ggplot(data=SickDistData, aes(x=Age, fill=State)) + alllabels_theme + SEIRD_theme +
    theme(legend.position='top') +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N))
}

plot_Model <- function(Result) {
  Result %>% 
    select(time, S, Sv, E, Ev, I, Iv, R, Rv, D) %>% 
    pivot_longer(!time, names_to='State', values_to='N') %>% 
    ggplot(aes(x=time, y=N, color=State)) + alllabels_theme + SEIRD_theme +
    scale_x_continuous('Dia') +
    scale_y_continuous('Número de Pessoas') +
    geom_point(size=1)
}

plot_Model_Zoom <- function(Result) {
  Result %>%
    select(time, E, Ev, I, Iv, Rv, D) %>% 
    pivot_longer(!time, names_to='State', values_to='N') %>% 
    ggplot(aes(x=time, y=N, color=State)) + alllabels_theme + SEIRD_theme +
    scale_x_continuous('Dia') +
    scale_y_continuous('Número de Pessoas') +
    geom_point(size=1)
}
