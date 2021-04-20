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

SIRD_theme <- c("#FC717F", "#9890FF", "#00BC59", "#00BBD8")

alllabels_theme <- theme(plot.title = element_text(size = 12, face = "plain"),
                         legend.position = "none")
onlyx_theme <- alllabels_theme + theme(axis.title.y = element_blank(),
                                       axis.text.y = element_blank())
onlyy_theme <- alllabels_theme + theme(axis.title.x = element_blank(),
                                       axis.text.x = element_blank())
nolabels_theme <- onlyx_theme + onlyy_theme

ggsave <- function(filename, plot = last_plot(), device = NULL, path = NULL,
                   scale = 1, width = 10, height = 10, units = "cm",
                   dpi = 'retina', limitsize = TRUE) {
  ggplot2::ggsave(filename, plot, device, path, scale, width, height, units, dpi,
                  limitsize)
}