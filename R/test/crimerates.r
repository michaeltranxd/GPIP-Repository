library(ggplot2)
library(readr)
library(dplyr)

crime_data <- read_csv("../CSV/Crimes-2018.csv")
head(crime_data)

#Get zipcodes
zipcode_crimes <- crime_data %>%
  select(PrimaryType)

#group by
zipcode_crimes_group <- zipcode_crimes %>%
  group_by(PrimaryType)

#count
zipcode_crimes_count <- zipcode_crimes_group %>%
  summarize(count = n()) %>%
    arrange(desc(count))

head(zipcode_crimes_count)

bar <- ggplot(data = zipcode_crimes, aes(x = PrimaryType)) + 
    geom_bar(aes(fill=PrimaryType)) +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
bar

top_3 <- top_n(zipcode_crimes_count, 3)
top_3
