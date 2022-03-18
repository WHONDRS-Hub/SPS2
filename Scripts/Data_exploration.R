rm(list=ls());graphics.off()

#Loading packages 
library(ggplot2);library(vegan)
library(ggthemes);library(ggpubr);library(dplyr); library(stringr);library(ggpmisc)

#####################################################################################
# Set directories
home.dir = "//pnl/projects/SBR_SFA/RC2/VGC_Spatial_Study_2/Data/"
output.dir = ("//pnl/projects/SBR_SFA/RC2/VGC_Spatial_Study/Output/")
setwd(output.dir) # setting working directory to the output directory

geo.input = paste0(home.dir,"Geospatial_data/")
shp.input = paste0(home.dir,"Shape_files_RC_model/")
