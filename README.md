# USDA-Forest-Service-Experimental-Forests-Soils
Through collaboration with the College of Charleston and the USDA Forest Service Southern Research Station a soils technical report was created using SQL for data mining and graphs generated in R programming language. Shape files were provided by the Forest Service and fed into the Web Soil Survey Area of Interest (AOI) tool. This returned a shape file with SSURGO map unit symbols. A SQL query was entered into the NRCS Soil Data Mart for each forest to return the map unit name associated with the map unit symbols, an example of this query is called "SQL for Santee taxon". 

Jason Nemecek of the NRCS provided us with a SQL query that could be entered into the Soil Data Mart and extract data from the National Cooperative Soil Survey Lab (NCSS). This query was modified for our specific needs and is called "All_EF_pedon_SQLscript". 

Jeffery Atkins was responsible for consolidating the data and his work can be found here:
        https://github.com/atkinsjeff/efr_soils_project
        
Three R programs were used for each of the 19 forests. 

1) C_N.R was used to calculate the carbon and nitrogen levels of each soil series within the forest. Carbon and nitrogen levels
    were reported by depth so each depth was added together to get a total sum for the soil series, the sum was then multiplied by
     the area of the soil series within the experimental forest to give megagrams per hectare. 
     
2) CNgraph.R was used to plot the carbon and nitrogen levels by depth of the 4-6 main soil series within each forest.


![SanteeCNgraph](https://user-images.githubusercontent.com/61474761/210826636-d1335036-e70a-430c-bc49-a8e21393b870.jpeg)


3) Textures.R was used to plot a ternary diagram of texture, carbon levles, and available water capacity of each soil series in the forest. 


![SanteeAWC](https://user-images.githubusercontent.com/61474761/210826860-39693c62-5a2c-462b-8993-0bf3964e644d.jpeg)
