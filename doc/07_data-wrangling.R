# Title: Data Wrangling
# Date: March 3, 2026
# Author: Stephanie J. Garcia

#install.packages("tidyverse") # includes the dplyr package
library(tidyverse) 
# loads dplyr, readr, forcats, purrr, tibble, tidyr, lubridate, ggplot2, stringr
??dplyr
??readr
??forcats
??purrr
??tibble
??tidyr
??lubridate
??ggplot2
??stringr

#install.packages("gapminder")
library(gapminder)

mean(gapminder$gdpPercap[gapminder$continent == "Africa"]) # 2193.76
mean(gapminder$gdpPercap[gapminder$continent == "Americas"]) # 7136.11
mean(gapminder$gdpPercap[gapminder$continent == "Asia"]) # 7902.15 
## lots of repetition 

# Using dplyr function: combining several functions using pipes 
## select(), filter(), group_by(), summarize(), mutate()

## select(): select a few variables from a data frame
year_country_gdp <- select(gapminder, year, country, gdpPercap)

smaller_gapminder_data <- select(gapminder, -continent)
head(smaller_gapminder_data) #1704 obs, 5 vars: country, year, lifeExp, pop, gdpPercap

### pipe operator shortcut: ctrl + shift + M
year_country_gdp1 <- gapminder %>% select(year, country, gdpPercap)
str(year_country_gdp1)

# Renaming data frame columns in dplyr 
## base R uses names() function to rename columns 
### rename(new_name = old_name)
tidy_gdp <- year_country_gdp1 %>% rename(gdp_per_cap = gdpPercap)
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

### The function group_by() allows us to group by multiple variables. 
### Let’s group by year and continent
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

## count(): count the number of observations for each group
count_continent_2002 <- gapminder %>% 
  filter(year == 2002) %>% 
  count(continent, sort = TRUE)
print(count_continent_2002, sort = TRUE)

count_continent_year <- gapminder %>% 
  group_by(year) %>% 
  count(continent, sort = TRUE)
print(count_continent_year, n = 60) #12 years across 5 continents = 60 rows

## using n(): number of observations for calculations
## obtain standard error of lifeExp per continent 
sd_lifeExp_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarize(se_le = sd(lifeExp)/sqrt(n()))
sd_lifeExp_continent






