# Title: Data Wrangling
# Date: March 3-5, 2026
# Author: Stephanie J. Garcia

#install.packages("tidyverse") # includes the dplyr package
library(tidyverse) 
# loads dplyr, readr, forcats, purrr, tibble, tidyr, lubridate, ggplot2, stringr
?dplyr
?readr
?forcats
?purrr
?tibble
?tidyr
?lubridate
?ggplot2
?stringr

#install.packages("gapminder")
library(gapminder)

mean(gapminder$gdpPercap[gapminder$continent == "Africa"]) # 2193.76
mean(gapminder$gdpPercap[gapminder$continent == "Americas"]) # 7136.11
mean(gapminder$gdpPercap[gapminder$continent == "Asia"]) # 7902.15 
## lots of repetition 

# Using dplyr function: combining several functions using pipes %>% 
## select(), filter(), group_by(), summarize(), mutate()

## select(): select a few variables from a data frame
year_country_gdp <- select(gapminder, year, country, gdpPercap)

smaller_gapminder_data <- select(gapminder, -continent)
head(smaller_gapminder_data) #1704 obs, 5 vars: country, year, lifeExp, pop, gdpPercap

### pipe operator shortcut: ctrl + shift + M
year_country_gdp1 <- gapminder %>% 
  select(year, country, gdpPercap)
str(year_country_gdp1)

# Renaming data frame columns in dplyr 
## base R uses names() function to rename columns 
### rename(new_name = old_name)
tidy_gdp <- year_country_gdp1 %>% 
  rename(gdp_per_cap = gdpPercap)
head(tidy_gdp)

## filter() for European countries only 
### combine filter() and select()
year_country_gdp_euro <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)

head(year_country_gdp_euro)

## Life Expectancy of European countries in 2007
europe_lifeExp_2007 <- gapminder %>% 
  filter(continent == "Europe", year == 2007) %>% 
  select(country, lifeExp)

# Challenge 1: Write a single command (which can span multiple lines and 
#              includes pipes) that will produce a data frame that has the 
#              African values for lifeExp, country and year, but not for other 
#              Continents. How many rows does your data frame have and why?

summary(gapminder) # confirming how Africa is listed in gapminder data
Africa <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(lifeExp, country, year)

head(Africa) #624 observations, 3 variables: lifeExp, country, year

## groupby()
str(gapminder)
str(gapminder %>% group_by(continent))
### A grouped_df can be thought of as a list where each item in the list is a 
###  data.frame which contains only the rows that correspond to the a particular 
###  value continent

## summarize() combined with groupby()
### create new variable(s) by using functions that repeat for each of the 
###   continent-specific data frames
### using the group_by() function, we split our original data frame into multiple 
###  pieces, then we can run functions (e.g. mean() or sd()) within summarize()
gdp_by_continents <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gpdPercap = mean(gdpPercap))
gdp_by_continents

# Challenge 2: Calculate the average life expectancy per country. Which has the
#              longest average life expectancy and which has the shortest 
#              average life expectancy?
lifeExp_by_country <- gapminder %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) ### calculate mean lifeExp by country

lifeExp_by_country %>% 
  filter(mean_lifeExp == min(mean_lifeExp) | mean_lifeExp == max(mean_lifeExp))
### filter mean lifeExp by country to min and max value only 
### max listed first, then min average life expectancy by country 

### Another method using dplyr arrange()
lifeExp_by_country %>% 
  arrange(mean_lifeExp) %>% 
  head(1) # minimum 

### use descending option for dplyr arrange()
lifeExp_by_country %>% 
  arrange(desc(mean_lifeExp)) %>% 
  head(1) # maximum value displayed using descending 

### use descending to alphabetize 
lifeExp_by_country %>% 
  arrange(desc(country)) %>% 
  head(1) # Zimbabwe displayed 

# The function group_by() allows us to group by multiple variables. 
## Let’s group by year and continent
gdp_bycontinents_byyear <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap))
gdp_bycontinents_byyear # 60 observations 
print(gdp_bycontinents_byyear, n=60) #prints content of all 60 observations

### define more than 1 variable using summarize()
gdp_pop_bycontinents_byyear <- gapminder %>% 
  group_by(year, continent) %>% 
  summarize (mean_gdpPercap = mean(gdpPercap),
             sd_gdpPercap = sd(gdpPercap),
             mean_pop = mean(pop), 
             sd_pop = sd(pop))
print(gdp_pop_bycontinents_byyear, n=60)

# count(): count the number of observations for each group
count_continent_2002 <- gapminder %>% 
  filter(year == 2002) %>% 
  count(continent, sort = TRUE)
print(count_continent_2002, sort = TRUE)

count_continent_year <- gapminder %>% 
  group_by(year) %>% 
  count(continent, sort = TRUE)
print(count_continent_year, n = 60) #12 years across 5 continents = 60 rows

## using n(): number of observations for calculations
### obtain standard error of lifeExp per continent 
se_lifeExp_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarize(se_le = sd(lifeExp)/sqrt(n()))
se_lifeExp_continent

## chain together several summary operations
### calculate the min, max, mean, and se of each continents' life expectancy
lifeExp_continent_stats <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_lifeExp = mean(lifeExp), 
            min_lifeExp = min(lifeExp),
            max_lifeExp = max(lifeExp), 
            se_lifeExp = sd(lifeExp)/sqrt(n()))
lifeExp_continent_stats

# mutate(): create new variables prior to (or even after) summarizing info 
gdp_pop_bycontinents_byyear <- gapminder %>% 
  mutate(gdp_billion = gdpPercap*pop/10^9) %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop), 
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))
gdp_pop_bycontinents_byyear

## connect mutate with logical filtering: ifelse
#### keeping all data but "filtering" after a certain condition 
### calculate GDP only for people with a life expectation above 25
??ifelse
gdp_pop_bycontinents_byyear_above25 <- gapminder %>% 
  mutate(gdp_billion = ifelse(lifeExp > 25, gdpPercap * pop / 10^9, NA)) %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))
gdp_pop_bycontinents_byyear_above25

summary(gdp_pop_bycontinents_byyear_above25)
print("Position of missing values by column wise")
sapply(gdp_pop_bycontinents_byyear_above25, function(x) which(is.na(x)))

print("Count of missing values by column wise")
sapply(gdp_pop_bycontinents_byyear_above25, function(x) sum(is.na(x)))

### report number of NULL values in newly created variable
#miss_gdp_pop_bycontinents_byyear_above25 %>% 
#  summarize(across(everything(), ~ sum(is.na(.)), .names = "missing_{.col}")) %>% 
#  pivot_longer(cols = everything(),
#               names_to = "column",
#               values_to = "missing_count")
#miss_gdp_pop_bycontinents_byyear_above25

### update only if certain condition is fulfilled
## life expectation above 40 years, the gdp to be expected in the future is scaled
gdp_pop_bycontinents_high_lifeExp <- gapminder %>% 
  mutate(gdp_futureExpectation = ifelse(lifeExp > 40, gdpPercap * 1.5, gdpPercap)) %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap),
            mean_gdpPercap_expected = mean(gdp_futureExpectation))
gdp_pop_bycontinents_high_lifeExp

# combining dplyr and ggplot2
#install.packages("ggplot2") #install if necessary
library(ggplot2)

## Filter countries located in the Americas (old code)
### requires the need to create an intermediate variable (americas)
americas <- gapminder[gapminder$continent == "Americas",]
# Make the plot 
ggplot(data = americas, mapping = aes(x = year, y = lifeExp)) + 
  geom_line() + 
  facet_wrap( ~ country) +
  theme(axis.text.x = element_text(angle = 45))

## let's look an update to the code where we combine dplyr and ggplot
gapminder %>% 
  #Filter countries located in the Americas
  filter(continent == "Americas") %>% 
  #Make the plot
  ggplot(mapping = aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country) + 
  theme(axis.text.x = element_text(angle = 45))

# mutate() and ggplot2 package using base R startsWith
gapminder %>% 
  #extract first letter of country name into new column 
  mutate(startsWith = substr(country, 1, 1)) %>% 
  #only keep countries starting with A or Z 
  filter(startsWith %in% c("A", "Z")) %>% 
  #plot lifeExp into facets
  ggplot(aes(x = year, y = lifeExp, colour = continent)) +
  geom_line() + 
  facet_wrap(vars(country)) + 
  theme_minimal()

?substr()
#substr(country, 1, 1) start at the first letter, end at the first letter

## mutate() and ggplot2 package using dplyr starts_with
AZ_lifeExp <- gapminder %>% 
  #extract first letter of country name into new column 
  mutate(starts_with = substr(country, 1, 1)) %>% 
  #only keep countries starting with A or Z 
  filter(starts_with %in% c("A", "Z")) %>% 
  #plot lifeExp into facets
  ggplot(aes(x = year, y = lifeExp, colour = continent)) +
  geom_line() + 
  ggtitle("Life Expectancy for 'A & Z' Countries across all Continents") + 
  facet_wrap(vars(country)) + 
  theme_minimal()
AZ_lifeExp

# ADVANCED CHALLENGE: Calculate the average life expectancy in 2022 of 2 randomly
#                     selected countries for each continent. Then arrange the 
#                     continent names in reverse order. HINT: Use the dplyr 
#                     functions arrange() and sample_n(), they have similar 
#                     syntax to other dplyr functions. 
?arrange() #a function used for ordering
?sample_n() #a function used for sampling which is superceded by slice_sample()
?slice_sample() # randomly select rows 

avg_lifeExp_rando_countries <- gapminder %>% 
  filter(year == 2002) %>% #keep 2002 data only
  group_by(continent) %>% #group by continent
  slice_sample(n = 2) %>% #slice_sample supersedes sample_n() function 
  summarize(mean_avg_lifeExp_rando_countries = mean(lifeExp)) %>% 
  arrange(desc(mean_avg_lifeExp_rando_countries))
avg_lifeExp_rando_countries

### Another method: identify which random country was sample (3 parts)
# Step 0: Set a seed to ensure reproducibility 
set.seed(123) 

# Step 1: Sample 2 countries per continent for 2002
sampled_countries <- gapminder %>%
  filter(year == 2002) %>%       # Keep only 2002 data
  group_by(continent) %>%        # Group by continent
  slice_sample(n = 2)            # Randomly select 2 rows per continent

# View the sampled countries
print(sampled_countries)

# Step 2: Then calculate the mean life expectancy
avg_lifeExp_rando_2countries <- sampled_countries %>%
  summarize(mean_avg_lifeExp_rando_2countries = mean(lifeExp)) %>%
  arrange(desc(mean_avg_lifeExp_rando_2countries))

print(avg_lifeExp_rando_2countries)
  
### Summary 
### mutate() adds new variables that are functions of existing variables
### select() picks variables based on their names.
### filter() picks cases based on their values.
### summarize() reduces multiple values down to a single summary.
### arrange() changes the ordering of the rows.

# NOTES FROM VIDEO LECTURE 2026-03-03 
# install.packages("magick", type = "binary")
library(magick)
?magick

## Verify if it is 'magick' is working. 
## Read a sample image from the web
scientist <- image_read("https://jeroen.github.io/images/frink.png")
# Display it in your RStudio viewer
print(scientist)

# Using select()
## used to select or keep few variable/column
?select()

head(gapminder) #6 variables: country, continent, year, lifeExp, pop, gdpPercap

## keep country, year, pop, and lifeExp from gapminder
gapminder_keep <- select(gapminder, country, year, pop, lifeExp)
gapminder_keep

## drop columns from gapminder 
gapminder_drop <- select(gapminder, -country, -year, -pop, -lifeExp)
gapminder_drop

## what to do when you do not know the column names, refer to "additions"
?select() #starts_with(), ends_with(), contains()

# rename function: give new names to columns 
## syntax: rename(new_name = old_name)
rename_gdp <- gapminder %>% 
  select(year, country, gdpPercap) %>% 
  rename(GDP = gdpPercap)

rename_gdp

rename_all <- gapminder %>% 
  select(year, country, gdpPercap) %>% 
  rename(GDP = gdpPercap, Year = year, Nation = country)
rename_all

# How many rows are there in each continent 
table(gapminder$continent) # 1704 total

# Add more than 1 filter
gapminder %>% 
  select(year, continent, country, gdpPercap) %>% 
  filter(continent == "Europe", year == 2002)

install.packages("conflicted")
library(conflicted)
browseVignettes("dplyr")
#library(dplyr) # similar functions used
#library(stats) # similar functions used
# Declare which package wins for specific functionsconflicts_prefer(dplyr::filter)
# conflicts_prefer(dplyr::lag)

# NOTES FROM VIDEO LECTURE 2026-03-05
## using "OR" operator; can also use membership operator %in% (suggested over OR)
### using "|" OR operator
gapminder %>% 
  filter(continent == "Europe" | continent == "Africa")

### using membership operator %in% 
conflicts_prefer(dplyr::filter) #set a preference for dplyr filter
gapminder %>% 
  filter(continent %in% c("Africa", "Europe"))

### enhance the above code and further filter by lifeExp > 60
### no shortcut for %in% (manually must be written)
gapminder %>% 
  filter(continent %in% c("Africa", "Europe"), lifeExp > 60)

# create a data frame for each country/continent using group_by()
gapminder %>% 
  group_by(continent) #shows that data has been grouped by 5 continents

# group_by() and summarize()
?group_by

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_pop = mean(pop), 
            mean_lifeExp = mean(lifeExp), 
            mean_gdp = mean(gdpPercap))

## review other variables that can be used to group_by()
colnames(gapminder)

gapminder %>% 
  group_by(country) %>% 
  summarize(median_lifeExp = median(lifeExp))

# ungroup(); remove grouping variable 
?ungroup()
ungroup() #reset all groupings

# mutate(): create a new variable/column 
## multiply lifeExp by 1.5
gapminder %>% 
  mutate(scaled_lifeExp = lifeExp * 1.5)

#### MAKE SURE TO ALWAYS NAME THE NEW VARIABLE YOU ARE CREATING 
#### e.g: lifeExp is replaced with lifeExp * 1.5 (NOT WHAT YOU WANT TO DO)
####      gapminder %>% 
####      mutate(lifeExp = lifeExp * 1.5) 

gapminder %>% 
  filter(continent == "Americas", year == 2007)

## use filter() and ggplot()
gapminder %>% 
  filter(continent == "Asia") %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line() + 
  facet_wrap(~ country)

