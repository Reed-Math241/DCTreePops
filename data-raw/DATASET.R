## code to prepare `DC_tree_pop` dataset goes here

library(tidyverse)
library(sp)
library(rgdal)

DC_treeshape <- readOGR("./data-raw", layer = "ACS_2018_Population_Variables_Tract")

DC_trees <- Urban_Forestry_Street_Trees %>%
  select(X, Y, FACILITYID, VICINITY, SCI_NM, OBJECTID, GLOBALID, WARD, SHAPE) %>%
  rename(Latitude = Y, Longitude = X) %>%
  filter(!is.na(Longitude))
  coordinates(DC_trees) <- c("Longitude", "Latitude")
  

DC_pop <- DC_treeshape %>%
  select(OBJECTID, GEOID, NAME, ALAND, AWATER, Shape__Length, Shape__Area, 
         B01001_001E, B01001_001M) %>%
  rename(Total_Pop = B01001_001E, Total_Pop_ME = B01001_001M)


usethis::use_data(DATASET, overwrite = TRUE)
