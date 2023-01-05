library(tidyverse)
library(magrittr)


#import data
taxonEF <- (southeast_soils_data_compiled_20220615)


# select soils from EF changed to lower case
S_order <- taxonEF[taxonEF$soil_name %in% tolower
                   (c('Bayboro', 'Bethera', 'Bonneau', 'Craven', 'Duplin', 
                      'Goldsboro', 'Lenoir', 'Leon', 'Lynchburg', 'Meggett', 'Norfolk', 
                      'Ocilla','Pantego', 'Rains', 'Wahee')), ]



S_order[is.na(S_order)] = 0

S_order$Carbon = 0


#use C.y if C.x is 0
for (i in 1:nrow(S_order)){
  if(S_order$c_Mg_ha.x[i] == 0){
    (S_order$Carbon[i] = (S_order$c_Mg_ha.y[i]))
    
    
  }else{
    (S_order$Carbon[i] = (S_order$c_Mg_ha.x[i]))
  }
}

# create tibble of summed and averaged data for specified EF, convert NA(missing data) to 0

EFseriesTibb <- (S_order %>%
                   group_by(soil_name) %>%
                   summarise(
                     (OrgC = sum(Carbon, na.rm=TRUE))
                     ,(TotN = sum(n_Mg_ha, na.rm=TRUE))
                   ))
colnames(EFseriesTibb) <- c("Name", "OrgC", "TotN")

#check to see if any series are missing
EFseriesTibb

#input area data of forest in alphabetical order per soil series
Area_ha <- c(2.71, 146.37, 42.46, 254.08, 145.87, 115.66, 
             175.32, 0.68, 5.01, 949.66, 6.43, 1.97, 4.04, 5.07, 
             621.69)

#Create table with calculations for C and N
Areadata <- data.frame(Name = c(EFseriesTibb$Name),
                       Area = c(Area_ha),
                       C = c(EFseriesTibb$OrgC),
                       N = c(EFseriesTibb$TotN),
                       C_Mg = c(EFseriesTibb$OrgC* Area_ha),
                       N_Mg = c(EFseriesTibb$TotN*Area_ha)
)
# rename column names
colnames(Areadata) <- c("Name", "Area", "C (Mg/ha)", "N (Mg/ha)", "C (Mg)", "N (Mg)")
Areadata[Areadata == 0] <- NA
Areadata
write.csv(Areadata, ".Santee_C_N.csv")
