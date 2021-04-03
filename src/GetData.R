# Thanks to https://github.com/dssg-pt/covid19pt-data

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source('Init.R')

RawData <- import('../covid19pt-data/data.csv') %>% 
  mutate(confirmados_0 = confirmados_0_9_m + confirmados_0_9_f) %>% 
  mutate(confirmados_10 = confirmados_10_19_m + confirmados_10_19_f) %>% 
  mutate(confirmados_20 = confirmados_20_29_m + confirmados_20_29_f) %>% 
  mutate(confirmados_30 = confirmados_30_39_m + confirmados_30_39_f) %>% 
  mutate(confirmados_40 = confirmados_40_49_m + confirmados_40_49_f) %>% 
  mutate(confirmados_50 = confirmados_50_59_m + confirmados_50_59_f) %>% 
  mutate(confirmados_60 = confirmados_60_69_m + confirmados_60_69_f) %>% 
  mutate(confirmados_70 = confirmados_70_79_m + confirmados_70_79_f) %>% 
  mutate(confirmados_80 = confirmados_80_plus_m + confirmados_80_plus_f)

BeforeVax <- filter(RawData, data=='26-12-2020')
c(BeforeVax$confirmados_0,BeforeVax$confirmados_10,BeforeVax$confirmados_20,
  BeforeVax$confirmados_30,BeforeVax$confirmados_40,BeforeVax$confirmados_50,
  BeforeVax$confirmados_60,BeforeVax$confirmados_70,BeforeVax$confirmados_80)

VaccineData <- import('../covid19pt-data/vacinas.csv')
