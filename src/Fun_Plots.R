#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

Plot_AgeDist <- function(AgeDistData) {
  ggplot(data=AgeDistData, aes(x=Age,fill=Age)) + alllabels_theme +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N0))
}

Plot_SickDist <- function(SickDistData) {
  ggplot(data=SickDistData, aes(x=Age,fill=Age)) + alllabels_theme +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N0), alpha=.4) +
    geom_bar(aes(weight=I0), alpha=1)
}
