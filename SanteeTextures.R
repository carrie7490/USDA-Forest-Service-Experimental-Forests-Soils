library(ggplot2)
library(magrittr)
library(scales)
library(tidyverse)
library(Surrogate)
library(ggtern)


#references used:
#1. https://bjnnowak.netlify.app/2021/07/26/r-plotting-soil-textures-example-of-water-storage-capacity/
#2. https://saryace.github.io/flipbook_soiltexture_en/#35

#name variables
SSeries$carbon = 0
USDA_text$AWC = 0

#name data sets to be used
data(USDA)
EFdata <- (southeast_soils_data_compiled_20220715)

#select soil series in forest of interest
SSeries <- EFdata[EFdata$soil_name %in% tolower
                  (c('Bethera', 'Bonneau', 'Caroline', 'Craven', 
                     'Duplin', 'Goldsboro', 'Lenoir',  
                     'Meggett', 'Wahee'
                     
                     
                  )), ]
SSeries[is.na(SSeries)] = 0

#use C.y if C.x is 0
for (i in 1:nrow(SSeries)){
  if(SSeries$c_Mg_ha.x[i] == 0){
    (SSeries$carbon[i] = (SSeries$c_Mg_ha.y[i]))
    
    
  }else{
    (SSeries$carbon[i] = (SSeries$c_Mg_ha.x[i]))
  }
}

tail(SSeries)

#find weighted average (multiply texture by thickness of horizon layer in cm)

for (i in 1:nrow(SSeries)){
  if(SSeries$horizon[i] == "20_40"){
    (SSeries$bulk_density[i] = (SSeries$bulk_density[i] * 20))
    (SSeries$silt[i] = (SSeries$silt[i] * 20))
    (SSeries$clay[i] = (SSeries$clay[i] * 20))
    (SSeries$frag[i] = (SSeries$frag[i] * 20))
    (SSeries$sand[i] = (SSeries$sand[i] * 20))
    
    
  }else if(SSeries$horizon[i] == "40_100"){
    (SSeries$bulk_density[i] = (SSeries$bulk_density[i] * 60))
    (SSeries$silt[i] = (SSeries$silt[i] * 60))
    (SSeries$clay[i] = (SSeries$clay[i] * 60))
    (SSeries$frag[i] = (SSeries$frag[i] * 60))
    (SSeries$sand[i] = (SSeries$sand[i] * 60))
   
    
  }else{
    (SSeries$bulk_density[i] = (SSeries$bulk_density[i] * 10))
    (SSeries$silt[i] = (SSeries$silt[i] * 10))
    (SSeries$clay[i] = (SSeries$clay[i] * 10))
    (SSeries$frag[i] = (SSeries$frag[i] * 10))
    (SSeries$sand[i] = (SSeries$sand[i] * 10))
  
  }
  
}  
SSeries[SSeries == 0] <- NA
tail(SSeries)


#find weighted average (add horizon textures together by soil name)/100
FinalPercent <- (SSeries %>% group_by(soil_name) %>% summarise
                 (
                   BD = (sum(bulk_density, na.rm = TRUE)/100),
                   SILT=(sum(silt, na.rm=TRUE)/100), 
                   CLAY=(sum(clay, na.rm=TRUE)/100),
                   frags = (sum(frag, na.rm = TRUE)/100),
                   SAND=(sum(sand, na.rm=TRUE)/100),
                   carbon = (sum(carbon, na.rm=TRUE))
                 )
)

colnames(FinalPercent) <- c("Name","BD" , "Silt", 
                            "Clay", "frags", "Sand", "SOC")

#print table
FinalPercent

#set up AWC data from USDA dataset: AWC = (FC-WPS)*100
USDA_text <- USDA %>% group_by(Label) %>%
  summarize_if(is.numeric, mean, na.rm = TRUE)
USDA_text
FC <-
  ( c(42, 36, 27, 18, 12, 10, 36, 28, 31,
      41, 38, 30))
WPS <-
  (c(
    30, 25, 17, 8, 5, 5, 22, 
    14, 11, 27, 22, 6
  ))
USDA_text$FC <- FC
USDA_text$WPS <- WPS
USDA_text['AWC'] <- ((USDA_text$FC - USDA_text$WPS))
USDA_text

#plot general triangle
graph <-ggplot()+              
  coord_tern(                # Add z coordinate to ggplot
    L='x',                   # Left
    T='y',                   # Top
    R='z'                    # Right
  )+
  labs(
    yarrow = "Clay (%)",
    zarrow = "Silt (%)",
    xarrow = "Sand (%)"
  )+
  theme_bw()+
  theme_showarrows()      # Add arrows to axis titles


#interpolate USDA data to create AWC visual, add experimental forest data
fill_graph<-graph+
  stat_interpolate_tern(             
    data=USDA_text,         
    aes(
      x = Sand,y = Clay,z = Silt,
      value = AWC,
      fill=..level..
    ),
    geom="polygon",                  
    formula=value~x+y, 
    method='lm',
    n=100,bins=100,                  # Increase for smoother result
    expand=1
  )+
  scale_fill_continuous(
    low="antiquewhite",
    high="lightskyblue3"
  )+
  
  labs(
    fill="AWC (%)",size = "SOC (Mg/ha)", color = "Soil Series"
    
  )+
  
  theme(
    legend.text = element_text(size = 10
    ))+
  
  geom_polygon(
    data=USDA,aes(x=Sand,y=Clay,z=Silt,group=Label),
    fill=NA,size = 0.3,alpha=0.6,
    color = "black"
  )+
  geom_text(
    data=USDA_text,
    aes(x=Sand,y=Clay,z=Silt,label=Label),
    size = 4,
    color = "black"
  )+
  geom_point(data=FinalPercent,
             aes(
               x=Sand,
               y=Clay,
               z=Silt,
               size = SOC,
               color = Name
             ))+
  
  theme(legend.position = c(0.92,0.7))+
  theme(legend.box = "horizontal")+
  theme(legend.key = element_rect
        (fill = "lightskyblue3"))+
  guides(
    size = guide_legend(order = 1),
    fill = guide_colorbar(order = 2),
    color = guide_legend 
    (override.aes = list(size = 3)))+
  
  scale_colour_manual(values = 
        c( "green3", "darkcyan", 
           "cyan3","royalblue1","blue3", "purple4",
           "mediumpurple1", "orchid2", "magenta", 
           "hotpink4",  "red", "orangered", "orange1", 
           "sienna","yellow", 
           "dimgray"))

fill_graph





