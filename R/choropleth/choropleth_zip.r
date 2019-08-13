#Install packages
install.packages("devtools")
library(devtools)
install_github('arilamstein/choroplethrZip@v1.5.0')
#Package instructions https://github.com/arilamstein/choroplethrZip

library(readr)
library(dplyr)

#Library, Tutorial: https://arilamstein.com/creating-zip-code-choropleths-choroplethrzip/
library(choroplethrZip)

?zip.regions
data(zip.regions)
head(zip.regions)

# Cook county and filter for only cook county
cook_county <- zip.regions %>%
  filter(state.name == "illinois") %>%
    filter(county.name == "cook") %>%
      arrange(region)
cook_county

# dataframe for population
?df_pop_zip
data(df_pop_zip)
head(df_pop_zip)

#dataframe for random_pop_cook (made up data)
random_pop_cook <- read_csv("../../CSV/random_pop_data.csv")
head(random_pop_cook)
#Mutate first col to character
random_pop_cook <- random_pop_cook %>%
  mutate(region = as.character(region))
head(random_pop_cook)

#List of zipcodes of Chicago
#Pulled from https://roadsidethoughts.com/il/chicago-xx-cook-census.htm
chicago_zip   <- c("60601", "60602", "60603", "60604", "60605", "60606", "60607")
chicago_zip2  <- c("60608", "60609", "60610", "60611", "60612", "60613", "60614")
chicago_zip3  <- c("60615", "60616", "60617", "60618", "60619", "60620", "60621")
chicago_zip4  <- c("60622", "60623", "60624", "60625", "60628", "60629", "60630")
chicago_zip5  <- c("60631", "60632", "60633", "60636", "60637", "60638", "60639")
chicago_zip6  <- c("60640", "60643", "60644", "60645", "60646", "60649", "60651")
chicago_zip7  <- c("60652", "60653", "60654", "60655", "60656", "60659", "60660")
# These do not exist in ZCTA... (These are from USPS Zipcodes)
#chicago_zip8  <- c("60663", "60664", "60667", "60668", "60669", "60670", "60671")
#chicago_zip9  <- c("60672", "60673", "60674", "60677", "60678", "60679", "60680")
#chicago_zip10 <- c("60683", "60684", "60687", "60690", "60693", "60697", "60699", "60701")

#Cook county ZCTA
cook_county_zcta <- c("60607", "60004", "60005", "60007", "60008", "60010", "60015", "60016", "60018", "60022", "60025", "60026", "60029", "60043", "60053", "60056", "60062", "60067", "60068", "60070", "60074", "60076", "60077", "60089", "60090", "60091", "60093", "60103", "60104", "60107", "60120", "60126", "60130", "60131", "60133", "60141", "60153", "60154", "60155", "60160", "60162", "60163", "60164", "60165", "60169", "60171", "60172", "60173", "60176", "60192", "60193", "60194", "60195", "60201", "60202", "60203", "60301", "60302", "60304", "60305", "60402", "60406", "60409", "60411", "60415", "60419", "60422", "60423", "60425", "60426", "60428", "60429", "60430", "60438", "60439", "60443", "60445", "60452", "60453", "60455", "60456", "60457", "60458", "60459", "60461", "60462", "60463", "60464", "60465", "60466", "60467", "60469", "60471", "60472", "60473", "60475", "60476", "60477", "60478", "60480", "60482", "60487", "60501", "60513", "60521", "60525", "60526", "60527", "60534", "60546", "60558", "60601", "60602", "60603", "60604", "60605", "60606", "60607", "60608", "60609", "60610", "60611", "60612", "60613", "60614", "60615", "60616", "60617", "60618", "60619", "60620", "60621", "60622", "60623", "60624", "60625", "60626", "60628", "60629", "60630", "60631", "60632", "60633", "60634", "60636", "60637", "60638", "60639", "60640", "60641", "60642", "60643", "60644", "60645", "60646", "60647", "60649", "60651", "60652", "60653", "60654", "60655", "60656", "60657", "60659", "60660", "60661", "60706", "60707", "60712", "60714", "60803", "60804", "60805", "60827")

#filter(df_pop_zip, region %in% chicago_zip10)


# --- Choropleth using population data (df_pop_zip) ---
?zip_choropleth
# Illinois State
zip_choropleth(df_pop_zip,
               state_zoom = "illinois",
               title = "2012 Illinois State ZCTA Population",
               legend = "Population")

# Chicago, hard to use...
zip_choropleth(df_pop_zip,
               zip_zoom = c(chicago_zip, chicago_zip2, chicago_zip3, chicago_zip4, chicago_zip5, chicago_zip6, chicago_zip7),
               title = "2012 Illinois State ZCTA Population",
               legend = "Population")

#Cook County
zip_choropleth(df_pop_zip,
               zip_zoom = cook_county_zcta,
               title    = "2012 Lower and Upper East Side ZCTA Population Estimates",
               legend   = "Population")


# --- Choropleth Maps using data (random_pop_chicago) ---

#Cook County
zip_choropleth(random_pop_cook,
               zip_zoom = cook_county_zcta,
               title    = "2012 Lower and Upper East Side ZCTA Population Estimates",
               legend   = "Population")

# Illinois State
zip_choropleth(random_pop_cook,
               state_zoom = "illinois",
               title = "2012 Illinois State ZCTA Population",
               legend = "Population")

#From Experiment,
# If zipcode is not defined by ZCTA of chicago, then it will be ignored in the data
# zip_zoom must have the zip codes (ZCTA) defined in zip.regions, else it will not work!