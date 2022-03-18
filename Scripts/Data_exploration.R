rm(list=ls());graphics.off()

#Loading packages 
library(ggplot2);library(vegan)
library(ggthemes);library(ggpubr);library(dplyr); library(stringr);library(ggpmisc)

#####################################################################################
# Set directories
home.dir = "C:/Users/gara009/OneDrive - PNNL/Documents/GitHub/SPS2/Data/"
output.dir = ("C:/Users/gara009/OneDrive - PNNL/Documents/GitHub/SPS2/Output/")
setwd(output.dir) # setting working directory to the output directory

geo.input = paste0(home.dir,"Geospatial_data/")
shp.input = paste0(home.dir,"Shape_files_RC_model/")

# Load data
model.out = read.csv(paste0(geo.input,"RC2_model_inputs_outputs_all.csv"))
stream.out = read.csv(paste0(geo.input,"RC2_all_stream_Attributes.csv"))
topo = read.csv(paste0(geo.input,"RC2_all_topographic_Attributes.csv"))
ppl = read.csv(paste0(geo.input,"RC2_all_Population_Regional_WaterUse_Attributes.csv"))
land = read.csv(paste0(geo.input,"RC2_all_LandCover_Attributes.csv"))
hydro = read.csv(paste0(geo.input,"RC2_all_Hydrologic_Attributes.csv"))
climate = read.csv(paste0(geo.input,"RC2_all_Climateand WaterBalanceModel.csv"))
loc = read.csv(paste0(geo.input,"022522_all_sites_NHD_streamline_matched_v2.csv"))

# Merge all the dataframes by site_ID

df = Reduce(function(x,y)merge(x,y, all = T, by = c('site_ID','COMID','ID')),list(topo,stream.out,climate,hydro,land,ppl)) #



df.all = merge(df,unique(model.out), by = c("COMID","ID","StreamOrde"), all= T)


