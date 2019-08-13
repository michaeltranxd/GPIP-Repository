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
#head(shp)

# Convert to dataframe for ggplot
shp.points <- fortify(shp)
head(shp.points)
#shp.points[5]
#shp.points

# read data
data <- read_csv("./shape_files/Boundaries - ZIP Codes/random_fake_patients_data.csv")
head(data)
data

# plot data on histogram
data_histogram <- data %>%
  ggplot(aes(x=zipcode)) +
    geom_histogram(binwidth = 1)

data_histogram

#Get table of ids and count
data_count <- data %>%
  group_by(zipcode) %>%
    summarize(count = n())
data_count

# Get the mapping from id to zipcode
map_id_to_zipcode <- read_csv("./shape_files/Boundaries - ZIP Codes/input to zipcode.csv");
head(map_id_to_zipcode)
map_id_to_zipcode

# Add zipcodes to data
new_data <- data_count %>%
  merge(map_id_to_zipcode, by="zipcode") %>%
    arrange(id)
head(new_data)

# add data to shp.points
shp.data <- merge(shp.points, new_data, by="id")
head(shp.data)



# Write to a csv file format
#write.csv(df_inc_data, file = "chicago_shp_data.csv")

#geom_path



# Map on ggplot
map <- ggplot() +
  geom_polygon(data = shp.data, aes(fill= count, x = long, y = lat, group = group), color = 'gray', size=1) +
    theme_void() # theme_void() removes the theme of "graph paper"
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