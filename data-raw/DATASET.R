## code to prepare `DC_tree_pop` dataset goes here

#Libraries loaded
library(tidyverse)
library(sp)
library(rgdal)
library(dplyr)
library(raster)

#making population data as spatial
DC_popshape <- readOGR("./data-raw", layer = "ACS_2018_Population_Variables_Tract")

#tidying tree data and making it spatial
DC_trees <- Urban_Forestry_Street_Trees %>%
  dplyr::select(X, Y, FACILITYID, VICINITY, SCI_NM, OBJECTID, GLOBALID, WARD, SHAPE) %>%
  rename(Latitude = Y, Longitude = X) %>%
  filter(!is.na(Longitude))
coordinates(DC_trees) <- c("Longitude", "Latitude")

#I have no clue what I am doing with any of this 
DC_popshape <- DC_treeshape@data %>%
  dplyr::select(OBJECTID, GEOID, NAME, ALAND, AWATER, Shape__Len, Shape__Are, 
         B01001_001, B01001_0_1) %>%
  rename(Total_Pop = B01001_001, Total_Pop_ME = B01001_0_1)

DC_pop <- ACS_2018_Population_Variables_Tract %>%
  dplyr::select(OBJECTID, GEOID, NAME, ALAND, AWATER, Shape__Length, Shape__Area, 
                B01001_001E, B01001_001M) %>%
  rename(Total_Pop = B01001_001E, Total_Pop_ME = B01001_001M)

DC_pop <- spPolygons(DC_treeshape)


usethis::use_data(DATASET, overwrite = TRUE)
