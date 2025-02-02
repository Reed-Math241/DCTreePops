## code to prepare `DC_tree_pop_sf` dataset goes here

#Libraries loaded
library(tidyverse)
library(sp)
library(sf)
library(rgdal)
library(dplyr)
library(raster)
library(units)
library(tmap)


#loading population data as spatial
DC_pop <- readOGR(".", layer = "ACS_2018_Population_Variables_Tract")


#tidying tree data and making it spatial
Urban_Forestry_Street_Trees <- read_csv("./Urban_Forestry_Street_Trees.csv")

DC_trees <- Urban_Forestry_Street_Trees %>%
  dplyr::select(X, Y, FACILITYID, VICINITY, SCI_NM, OBJECTID, GLOBALID, WARD) %>%
  rename(Latitude = Y, Longitude = X) %>%
  filter(!is.na(Longitude))

DC_trees2 <- DC_trees %>%
  st_as_sf(
    coords = c("Longitude", "Latitude"),
    agr = "constant", 
    stringsAsFactors = FALSE, 
    remove = FALSE
  )

#Tidy model for final dataframe
DC_pop1 <- ACS_2018_Population_Variables_Tract %>%
  dplyr::select(OBJECTID, GEOID, NAME, ALAND, AWATER, Shape__Length, Shape__Area, 
                B01001_001E, B01001_001M) %>%
  rename(Total_Pop = B01001_001E, Total_Pop_ME = B01001_001M)

#Transforming population data to sf object for final join 
DC_pop2 <- DC_pop %>%
  st_as_sf() %>%
  dplyr::select(OBJECTID, GEOID, NAME, ALAND, AWATER, Shape__Len, Shape__Are, 
                B01001_001, B01001_0_1) %>%
  rename(Total_Pop = B01001_001, Total_Pop_MoE = B01001_0_1) %>%
  mutate(Pop_density_mi2 = Total_Pop/(ALAND/2.59e+6)) %>%
  mutate(Pop_density_km2 = Total_Pop/(ALAND/1e+6))

#final join
DC_tree_pop <- st_join(DC_trees2, DC_pop2, join = st_within)

#tidying for final data set
tree_pop_count <- count(as_tibble(DC_tree_pop), GEOID)
DCTreePops <- left_join(DC_pop2, tree_pop_count) %>%
  mutate(Tree_density_mi2 = as.numeric(n/(ALAND/2.59e+6))) %>%
  mutate(Tree_density_km2 = as.numeric(n/(ALAND/1e+6))) %>%
  rename(trees_per_tract = n, 
         shape_area = Shape__Are, 
         shape_length = Shape__Len,
         object_id = OBJECTID,
         name = NAME,
         land_area = ALAND,
         water_area = AWATER,
         total_pop = Total_Pop,
         total_pop_moe = Total_Pop_MoE,
         pop_density = Pop_density_km2,
         tree_density = Tree_density_km2,
         geo_id = GEOID) %>%
  subset(select = -c(Pop_density_mi2, Tree_density_mi2))

usethis::use_data(DCTreePops, overwrite = TRUE)
