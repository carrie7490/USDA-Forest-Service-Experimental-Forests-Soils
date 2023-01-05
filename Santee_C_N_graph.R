library(tidyverse)
library(ggplot2)
library(ggtern)
library(patchwork)


#import data
taxonEF <- (souteast_soils_analyte_per_20220823)


# select soils from EF changed to lower case
EFsoils <- taxonEF[taxonEF$soil_name %in% tolower
                   (c( 'Craven', 'Lenoir', 'Meggett', 'Wahee', 'Duplin', 'bethera')), ]


EFsoils[is.na(EFsoils)] = 0

#name variables
EFsoils$Carbon = 0
EFsoils$Depth

#use org_c if C is 0 
for (i in 1:nrow(EFsoils)){
  if(EFsoils$org_c_per[i] == 0){
    (EFsoils$Carbon[i] = (EFsoils$c_per[i]))
  }else{
    (EFsoils$Carbon[i] = (EFsoils$org_c_per[i]))
  }
}
# change horizon char to num
for (i in 1:nrow(EFsoils)){
  if(EFsoils$horizon[i] == '0_10'){
    (EFsoils$Depth[i] = as.numeric(5))
  }else if(EFsoils$horizon[i] == '10_20'){
    (EFsoils$Depth[i] = as.numeric(15))
  }else if(EFsoils$horizon[i] == '20_40'){
    (EFsoils$Depth[i] = as.numeric(30))
  }else{
    (EFsoils$Depth[i] = as.numeric(100))
  }
}
#change 0 to NA so that ggplot ignores it
EFsoils[EFsoils==0]<- NA    
EFsoils

#create carbon (x1) and nitrogen (x2) plots
x1 <- ggplot(EFsoils, aes(x=Carbon, y=Depth, color = soil_name)) +
  scale_x_continuous(position = "top")+
  ylim(100,5)+
  geom_smooth(method = "loess", orientation = "y", span = 0.8)+
  geom_point()+
  labs( y="Depth (cm)", x = "Carbon (%)")+
  theme_bw()+
  theme(legend.position = "none") 

x2 <- ggplot(EFsoils, aes(x=n_per, y=Depth, color = soil_name)) + 

  scale_x_continuous(position = "top")+
  ylim(100,5)+
  geom_smooth(method = "loess", orientation = "y", span = 0.8)+
  geom_point()+
  labs(color = "Soil Series", y="Depth (cm)", x = "Nitrogen (%)")+
  theme_bw()+
  guides(color=guide_legend(override.aes = list(fill=NA)))

#plot together in one grid

x1+x2+plot_layout(guides="collect")+
  plot_annotation(title = "Santee Experimental Forest")

  


