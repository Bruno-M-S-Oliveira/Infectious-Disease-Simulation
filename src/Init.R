#  ___       _ _
# |_ _|_ __ (_) |_
#  | || '_ \| | __|
#  | || | | | | |_
# |___|_| |_|_|\__|
# Things that are useful to do in the beginning
if(rstudioapi::isAvailable())
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Clear All Variables
rm(list = ls())

# Load libraries
library(shiny)
library(tidyverse)
library(magrittr)
library(cowplot)
library(deSolve)

# Source parameters
source('Parameters.R')

# ggplot
theme_set(theme_bw())
theme_update(
  text = element_text(size = 14),
  plot.title = element_text(hjust = 0.5),
  legend.position = "none",
  )

SEIRDS_theme <- scale_color_manual(
  name = "Grupo",
  aesthetics = c("colour", "fill"),
  values = c("Sv"="#80EAFF", "S"="#00D5FF", "Sx"="#0095B3", 
             "Ev"="#FFEE99", "E"="#FFD500", "Ex"="#B39500", 
             "Iv"="#DD99FF", "I"="#AA00FF", "Ix"="#7700B3", 
             "Rv"="#D9FFB3", "R"="#99FF33", "Rx"="#73E600", 
             "D"="#FF4D4D"),
  labels = c("Sv"="Susptíveis e Vacinados" , "S"="Suscetíveis", "Sx"="Susptíveis e Antivax" , 
             "Ev"="Expostos e Vacinados"   , "E"="Expostos"   , "Ex"="Expostos e Antivax"   , 
             "Iv"="Infetados e Vacinados"  , "I"="Infetados"  , "Ix"="Infetados e Antivax"  , 
             "Rv"="Recuperados e Vacinados", "R"="Recuperados", "Rx"="Recuperados e Antivax", 
             "D"="Mortos"),
  limits=c("Sv", "S", "Sx", "Ev", "E", "Ex", "Iv", "I", "Ix", "Rv", "R", "Rx", "D")
  )

onlyx_theme <- theme(
  axis.title.y = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks.y = element_blank()
  )

onlyy_theme <- theme(
  axis.title.x = element_blank(),
  axis.text.x = element_blank(),
  axis.ticks.x = element_blank()
  )

nolabels_theme <- onlyx_theme + onlyy_theme

ggsave <- function(filename, plot = last_plot(), device = NULL, path = NULL,
                   scale = 1, width = 10, height = 10, units = "cm",
                   dpi = 'retina', limitsize = TRUE) {
  ggplot2::ggsave(filename, plot, device, path, scale, width, height, units, dpi,
                  limitsize)
}