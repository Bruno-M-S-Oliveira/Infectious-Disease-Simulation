#  ___       _ _
# |_ _|_ __ (_) |_
#  | || '_ \| | __|
#  | || | | | | |_
# |___|_| |_|_|\__|
# Things that are useful to do in the beginning

# Models
SIR_Param <- c(b = 0.1, g = 0.001)

# Population distribution
# Thanks to https://github.com/dssg-pt/covid19pt-data
# Note: Cases from unknown people are ignored
Data<- import('../covid19pt-data/data.csv') %>% 
  filter(data=='26-12-2020') %>% 
  mutate(CumI_0 = confirmados_0_9_m + confirmados_0_9_f) %>% 
  mutate(CumI_10 = confirmados_10_19_m + confirmados_10_19_f) %>% 
  mutate(CumI_20 = confirmados_20_29_m + confirmados_20_29_f) %>% 
  mutate(CumI_30 = confirmados_30_39_m + confirmados_30_39_f) %>% 
  mutate(CumI_40 = confirmados_40_49_m + confirmados_40_49_f) %>% 
  mutate(CumI_50 = confirmados_50_59_m + confirmados_50_59_f) %>% 
  mutate(CumI_60 = confirmados_60_69_m + confirmados_60_69_f) %>% 
  mutate(CumI_70 = confirmados_70_79_m + confirmados_70_79_f) %>% 
  mutate(CumI_80 = confirmados_80_plus_m + confirmados_80_plus_f) %>% 
  mutate(M_0 = obitos_0_9_m + obitos_0_9_f) %>% 
  mutate(M_10 = obitos_10_19_m + obitos_10_19_f) %>% 
  mutate(M_20 = obitos_20_29_m + obitos_20_29_f) %>% 
  mutate(M_30 = obitos_30_39_m + obitos_30_39_f) %>% 
  mutate(M_40 = obitos_40_49_m + obitos_40_49_f) %>% 
  mutate(M_50 = obitos_50_59_m + obitos_50_59_f) %>% 
  mutate(M_60 = obitos_60_69_m + obitos_60_69_f) %>% 
  mutate(M_70 = obitos_70_79_m + obitos_70_79_f) %>% 
  mutate(M_80 = obitos_80_plus_m + obitos_80_plus_f)

Age <- c('[0-9]','[10-19]','[20-29]','[30-39]','[40-49]','[50-59]','[60-69]',
         '[70-79]','80+')
Def_N0 <- c(841076,1015166,1073698,1215309,1575911,1481007,
            1293824,1018314,682402)
Def_M0 <- c(Data$M_0,Data$M_10,Data$M_20,Data$M_30,Data$M_40,
            Data$M_50,Data$M_60,Data$M_70,Data$M_80)
Def_CumI <- c(Data$CumI_0,Data$CumI_10,Data$CumI_20,Data$CumI_30,Data$CumI_40,
              Data$CumI_50,Data$CumI_60,Data$CumI_70,Data$CumI_80)
Def_R0 <- (Def_CumI- Def_M0)/sum(Def_CumI - Def_M0) * Data$recuperados
Def_I0 <- Def_CumI - Def_M0 - Def_R0
