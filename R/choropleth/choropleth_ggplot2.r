library(rgeos)
library(rgdal)
library(ggplot2)
library(readr)
library(dplyr)
library(ggmap)

# Shape files have the coordinates (latitude/longitude) and particular ids


# Same issue, but how do I plot my data of various zipcodes
# to map onto the shapefile regions?

# Get shp file from folder
shp <- readOGR(dsn="./shape_files/Boundaries - ZIP Codes", layer="geo_export_c9507149-0e38-4528-927f-c06ba2fab6b1", stringsAsFactors = FALSE)
dim(shp)
head(shp)
shp[1]

# Convert to dataframe for ggplot
shp.points <- fortify(shp)
head(shp.points)
shp.points

df_inc_data <- shp.points %>% 
  transform(hehexd = 0)
head(df_inc_data)

df_diff_id <- shp.points %>%
  group_by(id) %>%
    distinct(id)
df_diff_id

# Write to a csv file format
write.csv(df_inc_data, file = "chicago_shp_data.csv")

?geom_path

# Map on ggplot
map <- ggplot() +
  geom_polygon(data = df_inc_data, aes(x = long, y = lat, group = group, fill=id),
    color = 'gray', size=1)
map



# --- Working Map ---

# Get shp file from folder
shp <- readOGR(dsn="./shape_files/ne_10m_parks_and_protected_lands", layer="ne_10m_parks_and_protected_lands_area", stringsAsFactors = FALSE)
dim(shp)

# Convert to dataframe for ggplot
shp.points <- fortify(shp)
head(shp.points)

# Map on ggplot
map <- ggplot() +
    geom_path(data = shp.points, aes(x = long, y = lat, group = group),
        color = 'gray', size=1)
map