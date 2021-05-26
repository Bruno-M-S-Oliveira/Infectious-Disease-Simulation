#  ___       _ _
# |_ _|_ __ (_) |_
#  | || '_ \| | __|
#  | || | | | | |_
# |___|_| |_|_|\__|
# Things that are useful to do in the beginning

# Simulation
Def_Times <- seq(0, 365, by=1)

Def_Country <- "PRT"
Def_BRN <- 1.100480645 # Basic reproductive number (R0 is already used...)


Def_EPeriod <- 3   # Days
Def_IPeriod <- 5   # Days
Def_RPeriod <- 365 # Days

Def_u <-c(.4, .38, .79, .86, .8, .82, .88, .74, .74)
Def_IFR <- c(.001, .003, .01, .04, .12, .40, 1.36, 4.55, 15.24)/100

Def_VaxEffect   <- .95
Def_VaxGoal     <- .70
Def_VaxStart    <- 2000
Def_VaxIncrease <- 400

Def_Priority1 <- c(0,0,0,0,0,0,1,1,1)
Def_Priority2 <- c(0,0,0,1,1,1,0,0,0)
Def_Priority3 <- c(1,1,1,0,0,0,0,0,0)

Def_Priority <- Def_Priority1

# Population distribution
# Thanks to https://github.com/dssg-pt/covid19pt-data
# Note: Cases from unknown people are ignored
Data <- read.csv('../covid19pt-data/data.csv') %>%
  filter(data=='26-12-2020') %>%
  mutate(CumI_0  = confirmados_0_9_m   + confirmados_0_9_f)   %>%
  mutate(CumI_10 = confirmados_10_19_m + confirmados_10_19_f) %>%
  mutate(CumI_20 = confirmados_20_29_m + confirmados_20_29_f) %>%
  mutate(CumI_30 = confirmados_30_39_m + confirmados_30_39_f) %>%
  mutate(CumI_40 = confirmados_40_49_m + confirmados_40_49_f) %>%
  mutate(CumI_50 = confirmados_50_59_m + confirmados_50_59_f) %>%
  mutate(CumI_60 = confirmados_60_69_m + confirmados_60_69_f) %>%
  mutate(CumI_70 = confirmados_70_79_m + confirmados_70_79_f) %>%
  mutate(CumI_80 = confirmados_80_plus_m + confirmados_80_plus_f) %>%
  mutate(D_0  = obitos_0_9_m   + obitos_0_9_f)   %>%
  mutate(D_10 = obitos_10_19_m + obitos_10_19_f) %>%
  mutate(D_20 = obitos_20_29_m + obitos_20_29_f) %>%
  mutate(D_30 = obitos_30_39_m + obitos_30_39_f) %>%
  mutate(D_40 = obitos_40_49_m + obitos_40_49_f) %>%
  mutate(D_50 = obitos_50_59_m + obitos_50_59_f) %>%
  mutate(D_60 = obitos_60_69_m + obitos_60_69_f) %>%
  mutate(D_70 = obitos_70_79_m + obitos_70_79_f) %>%
  mutate(D_80 = obitos_80_plus_m + obitos_80_plus_f)

Def_CumI <- c(Data$CumI_0,Data$CumI_10,Data$CumI_20,Data$CumI_30,Data$CumI_40,
              Data$CumI_50,Data$CumI_60,Data$CumI_70,Data$CumI_80)

# Age groups
Age <- c('[0-9]','[10-19]','[20-29]','[30-39]','[40-49]','[50-59]','[60-69]',
         '[70-79]','80+')

Def_T0 <- c(841076,1015166,1073698,1215309,1575911,1481007,1293824,
            1018314,682402)

Def_D0 <- rep(0, 9)

Def_R0 <- round((Def_CumI- Def_D0)/sum(Def_CumI - Def_D0) * Data$recuperados)

Def_I0 <- Def_CumI - Def_R0 - Def_D0

Def_E0 <- 3/5*Def_I0

Def_Sv0 <- rep(0, 9)
Def_Ev0 <- rep(0, 9)
Def_Iv0 <- rep(0, 9)
Def_Rv0 <- rep(0, 9)

Def_NVax <- rep(20, 9)/100

Def_LifeExp <- round(c(
  (81.57420886+4*80.82533621+5*76.87564665)/10,
  (71.90253472+66.9317005)/2,
  (61.99687119+57.08524021)/2,
  (52.19320158+47.30965483)/2,
  (42.46168708+37.70902792)/2,
  (33.08839878+28.63464499)/2,
  (24.34322125+20.21990929)/2,
  (16.21677938+12.4345432)/2,
  (9.034845008+6.114170105)/2))
