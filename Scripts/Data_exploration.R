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
model.out.2 = read.csv(paste0(geo.input,"RC2_model_inputs_outputs_all_v2.csv"))
stream.out = read.csv(paste0(geo.input,"RC2_all_stream_Attributes.csv"))
topo = read.csv(paste0(geo.input,"RC2_all_topographic_Attributes.csv"))
ppl = read.csv(paste0(geo.input,"RC2_all_Population_Regional_WaterUse_Attributes.csv"))
land = read.csv(paste0(geo.input,"RC2_all_LandCover_Attributes.csv"))
hydro = read.csv(paste0(geo.input,"RC2_all_Hydrologic_Attributes.csv"))
climate = read.csv(paste0(geo.input,"RC2_all_Climateand WaterBalanceModel.csv"))
loc = read.csv(paste0(geo.input,"022522_all_sites_NHD_streamline_matched_v2.csv"))

# Merge all the dataframes by site_ID

df = Reduce(function(x,y)merge(x,y, all = T, by = c('site_ID','COMID','ID')),list(topo,stream.out,climate,hydro,land,ppl,model.out.2)) #


#test = merge(stream.out,unique(model.out.2), by = c("site_ID","COMID","ID","StreamOrde"), all= T)

#df.all = merge(df,unique(model.out), by = c("COMID","ID","StreamOrde"), all= T)

colnames(df)= gsub("StreamOrde","StreamOrder",colnames(df))
# Plots

# Hist of the slope
pdf("histogram_slope.pdf")
hist(df.all$CAT_STREAM_SLOPE, breaks = 10)
dev.off()

# Hist of the respiration
pdf("histogram_resp.pdf")
hist(df.all$logtotco2g_per_m2, breaks = 10)
dev.off()

# Hist of the stream order
pdf("histogram_streamorder.pdf")
hist(df.all$StreamOrder, breaks = 44)
dev.off()

# Slope resp regression
my.formula <- y ~ x

ggplot(df.all, aes(x = CAT_STREAM_SLOPE, y = logtotco2g_per_m2, color = as.factor(StreamOrder))) + coord_cartesian()+
  geom_point(size = 3) + scale_color_viridis_d() +
  theme_bw()+theme(  legend.background = element_rect(fill = 'NA'), legend.text = element_text(size=12))+
  #labs(y = name[1], x = meta[j])+ 
  #theme(legend.position=c(0.7,0.2))+ 
  theme(axis.text.x=element_text(size=12))+theme(axis.text.x=element_text(colour = "black"))+
  theme(aspect.ratio=1)+
  theme(axis.text.y=element_text(size=12,colour = "black"))+
  theme(axis.title.x =element_text(size=12,colour = "black"))+
  theme(axis.title =element_text(size=12,colour = "black"))+
  theme(axis.title.y =element_text(size=12,colour = "black"))
ggsave(file=paste0("Slope_vs_Resp_all",Sys.Date(),".png"),width = 7.38, height = 7.38)

ggplot(df.all, aes(color = CAT_STREAM_SLOPE, y = logtotco2g_per_m2, x = StreamOrder)) + coord_cartesian()+
  geom_point(size = 3) + scale_color_viridis_c() +
  theme_bw()+theme(  legend.background = element_rect(fill = 'NA'), legend.text = element_text(size=12))+
  #labs(y = name[1], x = meta[j])+ 
  #theme(legend.position=c(0.7,0.2))+ 
  theme(axis.text.x=element_text(size=12))+theme(axis.text.x=element_text(colour = "black"))+
  theme(aspect.ratio=1)+
  theme(axis.text.y=element_text(size=12,colour = "black"))+
  theme(axis.title.x =element_text(size=12,colour = "black"))+
  theme(axis.title =element_text(size=12,colour = "black"))+
  theme(axis.title.y =element_text(size=12,colour = "black"))

#ggsave(file=paste0("",Sys.Date(),".png"),width = 7.38, height = 7.38)
# Setting a threshold for the slope based on the slope histogram

slope.threshold = 0.005
df.all = df
df2 = subset(df.all,df.all$CAT_STREAM_SLOPE <= slope.threshold)

write.csv(df2,"Filtered_sites_by_gradient_0-005.csv",row.names = F)
# Plot regression again with filtered data

ggplot(df2, aes(color = CAT_STREAM_SLOPE, y = logtotco2g_per_m2, x = StreamOrder)) + coord_cartesian()+
  geom_point(size = 3) + scale_color_viridis_c() +
  theme_bw()+theme(  legend.background = element_rect(fill = 'NA'), legend.text = element_text(size=12))+
  labs(x = "Stream_order")+ 
  #theme(legend.position=c(0.7,0.2))+ 
  theme(axis.text.x=element_text(size=12))+theme(axis.text.x=element_text(colour = "black"))+
  theme(aspect.ratio=1)+
  theme(axis.text.y=element_text(size=12,colour = "black"))+
  theme(axis.title.x =element_text(size=12,colour = "black"))+
  theme(axis.title =element_text(size=12,colour = "black"))+
  theme(axis.title.y =element_text(size=12,colour = "black"))
ggsave(file=paste0("Filtered_Resp_vs_Slope_all",Sys.Date(),".png"),width = 7.38, height = 7.38)
