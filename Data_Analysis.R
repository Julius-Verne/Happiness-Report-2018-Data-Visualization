## Import library 

library(readxl)
library(ggplot2)

# --------------------------------------------------------------------

#DATA WRANGLING

# GATHER

## Import datasets from the xls file

time_data = read_excel("original_data/WHR2018Chapter2OnlineData.xls", sheet = "Table2.1")
happiness_data = read_excel("original_data/WHR2018Chapter2OnlineData.xls", sheet = "Figure2.2")
happiness_change = read_excel("original_data/WHR2018Chapter2OnlineData.xls", sheet = "Figure2.3")
migrant_data = read_excel("original_data/WHR2018Chapter2OnlineData.xls", sheet = "Figure2.4")
country_data = read_excel("original_data/WHR2018Chapter2OnlineData.xls", sheet = "SupportingFactors")


# --------------------------------------------------------------------
# --------------------------------------------------------------------


# ASSESS



## Most of the data is adapted from the  Gallup World Poll documentation from
## 2005 - 2018

str(time_data)
summary(time_data)


#### Changes time_data:
# Delete GINI index (World Bank estimate) due to a high number of NULL values
# Delete GINI index (World Bank estimate), average 2000-15 due to NULL values
# Change year to a Date variable
# Drop all the "Standard deviation" columns

# --------------------------------------------------------------------

str(happiness_data)
summary(happiness_data)

#### Changes happiness_data:
# Drop all the x__1 - x__13 variables.
# Drop Whisker-high & Whisker-low
# Rename variables for readability

# --------------------------------------------------------------------

str(happiness_change)
summary(happiness_change)
## Changes happiness_change_
# Calculate the old Happiness Index Value using amount it has changed.
# Rename Change in happiness score as "Happiness_Change"
# Drop Whisker-high & Whisker-low
# After cleaning, Join with happiness_data

# --------------------------------------------------------------------

str(migrant_data)
summary(migrant_data)
## Changes migrat_data:
# Drop Whisker-high & Whisker-low
# After cleaning, Join with happiness_data

# --------------------------------------------------------------------

str(country_data)
summary(country_data)
## Changes country_data:
# Drop all the "Standard error" columns
# Rename variables for readability



# --------------------------------------------------------------------


## CLEANING



#### Changes time_data:
# Delete GINI index (World Bank estimate) due to a high number of NULL values
# Delete GINI index (World Bank estimate), average 2000-15 due to NULL values
# Drop all the "Standard deviation" columns
# Change year to a Date variable



# Due to the name format I have to change the name so I can access it later.
names(time_data)[names(time_data) == 'GINI index (World Bank estimate)'] <- 'gini_1'
names(time_data)[names(time_data) == "GINI index (World Bank estimate), average 2000-15"] <- 'gini_2'
names(time_data)[names(time_data) == "Standard deviation of ladder by country-year"] <- 'std_1'
names(time_data)[names(time_data) == "Standard deviation/Mean of ladder by country-year"] <- 'std_2'


names(time_data)[names(time_data) == 
                   "gini of household income reported in Gallup, by wp5-year"] <- 'GINI-household_income'


time_data_clean = subset(time_data, select = -c(gini_1,gini_2,std_1, std_2 ) )
str(time_data_clean)


time_data_clean$year <- as.Date(as.character(time_data_clean$year), "%Y")

names(time_data_clean)[names(time_data_clean) == 'country'] <- 'Country'

time_data_clean$Country <-   ifelse( time_data_clean$Country == "Hong Kong SAR, China", 
                                            "Hong Kong S.A.R. of China", time_data_clean$Country)

time_data_clean$Country <-   ifelse( time_data_clean$Country == "Trinidad & Tobago", 
                                            "Trinidad and Tobago", time_data_clean$Country)

time_data_clean$Country <-   ifelse( time_data_clean$Country == "Somalia", 
                                            "Somaliland region", time_data_clean$Country)

time_data_clean$Country <-   ifelse( time_data_clean$Country == "Northern Cyprus", 
                                            "North Cyprus", time_data_clean$Country)

## Since this dataset is not being merged with any other it is exported to CSV
write.csv(time_data_clean, file = "clean_data/csv/time_data.csv")


#-------------------------------------------------------------------
#--------------------------------------------------------------------

#### Changes happiness_data:
# Drop all the x__1 - x__13 variables.
# Drop Whisker-high & Whisker-low
# Drop row filled with NULL values
# Rename variables for readability


str(happiness_data)
summary(happiness_data)

happiness_data_clean = subset(happiness_data,
                              select = -c(X__1,X__2,
                                          X__3,X__4,X__5,X__6,X__7,X__8,X__9,
                                          X__10, X__11, X__12, X__13))

names(happiness_data_clean)[names(happiness_data_clean) == 'Whisker-high'] <- 'w_high'
names(happiness_data_clean)[names(happiness_data_clean) == "Whisker-low"] <- 'w_low'
names(happiness_data_clean)[names(happiness_data_clean) == "Dystopia (1.92) + residual"] <- 'Dystopia_Comparison'
names(happiness_data_clean)[names(happiness_data_clean) == "Explained by: GDP per capita"] <- 'Explained_GDPperCapita'
names(happiness_data_clean)[names(happiness_data_clean) == "Explained by: Social support"] <- 'Explained_SocialSupp'
names(happiness_data_clean)[names(happiness_data_clean) == "Explained by: Healthy life expectancy"] <- 'Explained_LifeExp'
names(happiness_data_clean)[names(happiness_data_clean) == "Explained by: Freedom to make life choices"] <- 'Explained_Freedom'
names(happiness_data_clean)[names(happiness_data_clean) == "Explained by: Generosity"] <- 'Explained_Generosity'
names(happiness_data_clean)[names(happiness_data_clean) == "Explained by: Perceptions of corruption"] <- 'Explained_Corruption'

happiness_data_clean = subset(happiness_data_clean,
                              select = -c(w_high, w_low))

happiness_data_clean <- subset(happiness_data_clean, !is.na(Explained_Freedom))

str(happiness_data_clean)
summary(happiness_data_clean)

happiness_data_clean$Country
## HAs Hong Kong, Trinidad & Tobago, Northern Cyprus & Somalia


happiness_data_clean$Country <-   ifelse( happiness_data_clean$Country == "Hong Kong SAR, China", 
                    "Hong Kong S.A.R. of China", happiness_data_clean$Country)

happiness_data_clean$Country <-   ifelse( happiness_data_clean$Country == "Trinidad & Tobago", 
                                          "Trinidad and Tobago", happiness_data_clean$Country)

happiness_data_clean$Country <-   ifelse( happiness_data_clean$Country == "Somalia", 
                                          "Somaliland region", happiness_data_clean$Country)

happiness_data_clean$Country <-   ifelse( happiness_data_clean$Country == "Northern Cyprus", 
                                          "North Cyprus", happiness_data_clean$Country)



# ----------------------------------------------------------------
# ----------------------------------------------------------------


## Changes happiness_change:
# Calculate the old Happiness Index Value using amount it has changed.
# Rename Change in happiness score as "Happiness_Change"
# Drop Whisker-high & Whisker-low
# After cleaning, Join with happiness_data


str(happiness_change)
summary(happiness_change)

names(happiness_change)[names(happiness_change) == 'Whisker-high'] <- 'w_high'
names(happiness_change)[names(happiness_change) == "Whisker-low"] <- 'w_low'
names(happiness_change)[names(happiness_change) == "Changes in happiness scores"] <- 'HappinessChange'

happiness_change_clean = subset(happiness_change,
                              select = -c(w_high, w_low))

str(happiness_change_clean)
summary(happiness_change_clean)

happiness_change_clean$Country <-   ifelse( happiness_change_clean$Country == "Hong Kong SAR, China", 
                                          "Hong Kong S.A.R. of China", happiness_change_clean$Country)

happiness_change_clean$Country <-   ifelse( happiness_change_clean$Country == "Trinidad & Tobago", 
                                          "Trinidad and Tobago", happiness_change_clean$Country)

happiness_change_clean$Country <-   ifelse( happiness_change_clean$Country == "Somalia", 
                                          "Somaliland region", happiness_change_clean$Country)

happiness_change_clean$Country <-   ifelse( happiness_change_clean$Country == "Northern Cyprus", 
                                          "North Cyprus", happiness_change_clean$Country)

# ----------------------------------------------
# ----------------------------------------------


## Changes migrant_data:
# Drop Whisker-high & Whisker-low
# After cleaning, Join with happiness_data
# Rename Columns for readability

str(migrant_data)
summary(migrant_data)

names(migrant_data)[names(migrant_data) == 'Whisker-high'] <- 'w_high'
names(migrant_data)[names(migrant_data) == "Whisker-low"] <- 'w_low'
names(migrant_data)[names(migrant_data) == "Average happiness of foreign born"] <- 'AVG_Happiness_Foreign'
names(migrant_data)[names(migrant_data) == "Average happiness of locally born"] <- 'AVG_Happiness_Local'

migrant_data_clean = subset(migrant_data,
                                select = -c(w_high, w_low))

str(migrant_data_clean)
summary(migrant_data_clean)

migrant_data_clean$Country <-   ifelse( migrant_data_clean$Country == "Hong Kong SAR, China", 
                                            "Hong Kong S.A.R. of China", migrant_data_clean$Country)

migrant_data_clean$Country <-   ifelse( migrant_data_clean$Country == "Trinidad & Tobago", 
                                            "Trinidad and Tobago", migrant_data_clean$Country)

migrant_data_clean$Country <-   ifelse( migrant_data_clean$Country == "Somalia", 
                                            "Somaliland region", migrant_data_clean$Country)

migrant_data_clean$Country <-   ifelse( migrant_data_clean$Country == "Northern Cyprus", 
                                            "North Cyprus", migrant_data_clean$Country)

# ----------------------------------------------
# ----------------------------------------------

## Changes country_data:
# Drop all the "Standard error" columns
# Rename variables for readability
# Capitalize country so it can merge with other datasets.

str(country_data)
summary(country_data)

names(country_data)[names(country_data) == 'country'] <- 'Country'
names(country_data)[names(country_data) == 'Standard error, life ladder, 2015-2017'] <- 'ste_ll'
names(country_data)[names(country_data) == "Standard error, social support, 2015-2017"] <- 'ste_ss'
names(country_data)[names(country_data) == "Standard error, freedom to make life choices, 2015-2017"] <- 'ste_f'
names(country_data)[names(country_data) == "Standard error, perceptions of corruption, 2015-2017"] <- 'ste_c'

country_data_clean = subset(country_data,
                            select = -c(ste_ll, ste_ss, ste_f, ste_c))

str(country_data_clean)

country_data_clean$Country <-   ifelse( country_data_clean$Country == "Hong Kong SAR, China", 
                                        "Hong Kong S.A.R. of China", country_data_clean$Country)

country_data_clean$Country <-   ifelse( country_data_clean$Country == "Trinidad & Tobago", 
                                        "Trinidad and Tobago", country_data_clean$Country)

country_data_clean$Country <-   ifelse( country_data_clean$Country == "Somalia", 
                                        "Somaliland region", country_data_clean$Country)

country_data_clean$Country <-   ifelse( country_data_clean$Country == "Northern Cyprus", 
                                        "North Cyprus", country_data_clean$Country)

# ----------------------------------------------
# ----------------------------------------------


## MERGE

master_db <- merge(x = migrant_data_clean, y = happiness_data_clean, by = "Country", all= TRUE)
master_db <- merge(x = master_db, y = happiness_change_clean, by = "Country", all = TRUE)
names(master_db)[names(master_db) == 'Happiness score'] <- 'Happiness_Index_2018'
master_db$Happiness_Index_2010 <- master_db$Happiness_Index_2018 - master_db$HappinessChange
master_db <- merge(x = master_db, y = country_data_clean, by = "Country", all = TRUE)

master_db <- subset(master_db, Country != "Oman")
master_db <- subset(master_db, Country != "Djibouti")
master_db <- subset(master_db, Country != "Comoros")

str(master_db)

head(master_db)


write.csv(master_db, file = "clean_data/csv/happiness_data.csv")

----------------------------------------------------------

country <- master_db$Country
region <- master_db$`Region indicator`
year <- "2018"
happy_index <- master_db$Happiness_Index_2018 
change <- master_db$HappinessChange



df_1 <- data.frame(country,region, year, happy_index, change)

country <- master_db$Country
region <- master_db$`Region indicator`
year <- "2010"
happy_index <- master_db$Happiness_Index_2010

df_2 <- data.frame(country, region, year, happy_index, change)

library(dplyr)

final <- bind_rows(df_1, df_2)

str(final)
summary(final)

write.csv(final, file = "clean_data/csv/slopegraph_data.csv")
