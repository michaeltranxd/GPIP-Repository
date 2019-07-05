
library(rgeos)
library(rgdal)
library(ggplot2)
library(readr)
library(dplyr)

crime_data <- read_csv("../CSV/Crimes-2018.csv")
head(crime_data)

#shp <- readOGR(dsn="./shape_files", layer="tl_2018_us_zcta510", stringsAsFactors = FALSE)
#dim(shp)
#il.shp <- subset(shp, ZCTA5CE10 >= "60001" & ZCTA5CE10 <= "62999")
#dim(il.shp)
#il.shp

#Get zipcodes
zipcode_crimes <- crime_data %>%
  select(PrimaryType)
dim(zipcode_crimes)
zipcode_crimes

#group by
zipcode_crimes_group <- zipcode_crimes %>%
  group_by(PrimaryType)
dim(zipcode_crimes_group)
zipcode_crimes_group

#count
zipcode_crimes_count <- zipcode_crimes_group %>%
  summarize(count = n()) %>%
    arrange(desc(count))
dim(zipcode_crimes_count)
zipcode_crimes_count
bar <- ggplot(data = zipcode_crimes, aes(x = PrimaryType)) + 
    geom_bar(aes(fill=PrimaryType)) +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
bar

top_3 <- top_n(zipcode_crimes_count, 3)
top_3

pie <- bar + coord_polar("y", start=0)

pie