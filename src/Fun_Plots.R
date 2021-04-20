#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

Plot_AgeDist <- function(SickDistData) {
  ggplot(data=SickDistData, aes(x=Age, fill=State)) + alllabels_theme +
    scale_fill_manual(values=SIRD_theme) +
    scale_x_discrete('Idade (Anos)') +
    scale_y_continuous('Número de Pessoas') +
    geom_bar(aes(weight=N))
}

Plot_Model <- function(Result) {
  ggplot(Result, aes(x=time)) + alllabels_theme +
    scale_color_manual(values=SIRD_theme) +
    #geom_point(aes(y=N, color='N')) +
    geom_point(aes(y=S, color='S')) +
    geom_point(aes(y=I, color='I')) +
    geom_point(aes(y=R, color='R')) +
    geom_point(aes(y=D, color='D'))
}