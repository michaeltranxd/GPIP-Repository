#Load packages
library(choroplethr)
library(choroplethrMaps)

#Data for map
data(df_pop_state)
head(df_pop_state)

?state_choropleth

#Make Maps
state_choropleth(df_pop_state,
                 title = "2012 State Population Estimates",
                 legend = "Population",
                 num_colors = 9)


#Data for region
?state.regions
data(state.regions)
head(state.regions)

