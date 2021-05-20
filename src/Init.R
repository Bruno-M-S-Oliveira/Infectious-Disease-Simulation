#  ___       _ _
# |_ _|_ __ (_) |_
#  | || '_ \| | __|
#  | || | | | | |_
# |___|_| |_|_|\__|
# Things that are useful to do in the beginning
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Clear All Variables
rm(list = ls())

# Load libraries
library(shiny)
library(tidyverse)
library(magrittr)
library(cowplot)
library(rio)
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
  name = "Estado",
  aesthetics = c("colour", "fill"),
  values = c("S"="#00BBD8", "Sv"="#0CDEFF", "E"="#C4983B", "Ev"="#D0AD62", 
             "I"="#695DFF", "Iv"="#9890FF", "R"="#3BC455", "Rv"="#62D077",
             "D"="#FC717F"),
  limits=c("S", "Sv", "E", "Ev", "I", "Iv", "R", "Rv", "D")
  )

onlyx_theme <- theme(
  axis.title.y = element_blank(),
  axis.text.y = element_blank()
  )

onlyy_theme <- theme(
  axis.title.x = element_blank(),
  axis.text.x = element_blank()
  )

nolabels_theme <- onlyx_theme + onlyy_theme

ggsave <- function(filename, plot = last_plot(), device = NULL, path = NULL,
                   scale = 1, width = 10, height = 10, units = "cm",
                   dpi = 'retina', limitsize = TRUE) {
  ggplot2::ggsave(filename, plot, device, path, scale, width, height, units, dpi,
                  limitsize)
}