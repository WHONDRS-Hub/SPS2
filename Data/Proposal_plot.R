rm(list=ls());graphics.off()

#Loading packages 
library(ggplot2);library(vegan)
library(ggthemes);library(ggpubr);library(dplyr); library(stringr);library(ggpmisc)

#####################################################################################
# Set directories
home.dir = "C:/Users/gara009/OneDrive - PNNL/Documents/GitHub/SPS2/Data/"

setwd(home.dir)

sites = read.csv("Potential_sites_Proposal_VGC.csv")

map = read.csv("022522_all_sites_NHD_streamline_matched_v2.csv")

data = merge(sites,map, by = "site_ID")

#write.csv (data, "Proposal_sites_to_plot.csv",row.names = F)

ggplot(data, aes(x=logtotco2g_per_m2, fill=as.factor(StreamOrder))) +
  geom_histogram(bins = 11) + coord_cartesian(ylim = c(0,10))+ scale_y_continuous(limits=c(0,10), breaks=seq(0,10,2))+
  scale_fill_viridis_d(name = "Stream Order") + theme_bw() +
  #theme(legend.position="top")+
  theme(legend.position=c(0.15,0.75))+ 
  theme(legend.background = element_rect(fill = 'NA'), legend.text = element_text(size=10))+
  labs(x = expression(Predicted~ER[sed]~(log10~g~C~m^{-2})))+
  theme(axis.text.x=element_text(size=14))+theme(axis.text.x=element_text(colour = "black"))+
  theme(axis.text.y=element_text(size=14,colour = "black"))+
  theme(axis.title.x =element_text(size=14,colour = "black"))+
  theme(axis.title =element_text(size=14,colour = "black"))+
  theme(axis.title.y =element_text(size=14,colour = "black"))
ggsave(file=paste0("Hist_porposed_sites",Sys.Date(),".png"),width = 7.38, height = 7.38)
