#Title: Data Frame Manipulation with tidyr
#Author: Stephanie J. Garcia
#Date: March 10-12, 2026

# Overview: Reshaping data (wide/long format)

## Long: each column is a variable; each row is an observation (repeated IDs)
## Wide: each row is often a site/subject/patient and you have 
##        multiple observation variables containing the same type of data

library(tidyverse) # includes tidyr, dplyr, and readr
?tidyr #tidy messy data 

## Load gapminder data
### Note that we do not need to run readr since readr is in tidyverse
gapminder_data <- read_csv("data/gapminder_data.csv") 
View(gapminder_data)
str(gapminder_data)

# Challenge 1: Is gapminder purely wide, purely long, or intermediate? 
## gapminder is intermediate: 
##                            pop, lifeExp, and gdpPercap have multiple obs
##                            country, continent, year are ID variables 

# wide to long format with pivot_longer()
## Load gapminder data formatted in wide format 
### Note: we don’t want our continent and country columns to be factors, 
###       so we use the stringsAsFactors argument for read.csv() to disable that
gapminder_wide <- read_csv("data/gapminder_wide.csv")
### Historically, before R 4.0.0, the default was stringsAsFactors = TRUE, 
###           meaning any column with text values would be stored as a 
###           factor. From R 4.0.0 onwards, the default is FALSE, so 
###           character data remains as plain text unless explicitly converted; 
###           thus, we do not need to add stringAsFactors = FALSE in our code
str(gapminder_wide)
View(gapminder_wide)

### change this very wide data frame layout back to our nice, intermediate 
###   (or longer) layout, we will use one of the two available pivot functions 
###   from the tidyr package: 
###   pivot_longer() function: convert from wide to a longer format. 
###   pivot_longer() makes datasets longer by increasing the number of rows and 
###                  decreasing the number of columns, or ‘lengthening’ your 
###                  observation variables into a single variable.

gap_long <- gapminder_wide %>% 
  pivot_longer(cols = 
                 c(starts_with('pop'), 
                   starts_with('lifeExp'), 
                   starts_with('gdpPercap')
                   ),
    names_to = "obstype_year", values_to = "obs_values"
    )
str(gap_long)
view(gap_long)

### sometimes you have 1 ID variable and 40 observation variables with irregular 
###  variable names. The flexibility is a huge time saver!
gap_long_rm <- gapminder_wide %>% 
  pivot_longer(cols = c(-continent, -country),
               names_to = "obstype_year", values_to = "obs_values"
               )
str(gap_long_rm)
view(gap_long_rm)

gap_long_clean <- gap_long_rm %>% 
  separate(obstype_year, into = c('obs_type', 'year'), sep = "_")
gap_long_clean$year <- as.integer(gap_long_clean$year)
str(gap_long_clean)
view(gap_long_clean)

# Challenge 2: Using gap_long_clean, calculate mean lifeExp, pop and gdpPercap
#              by continent 
gap_long_clean %>% 
  group_by(continent, obs_type) %>% 
  summarize(means = mean(obs_values))

# long to intermediate format with pivot_wider()
## pivot_wider(), to ‘widen’ our observation variables back out. 
## pivot_wider() is the opposite of pivot_longer(), making a dataset wider by 
##  increasing the number of columns and decreasing the number of rows 
##  use pivot_wider() to pivot or reshape our gap_long to the original 
##      intermediate format or the widest format. 
##  The pivot_wider() function takes names_from and values_from arguments.
##  To names_from we supply the column name whose contents will be pivoted into 
##      new output columns in the widened data frame. 
##  The corresponding values ##  will be added from the column named in the 
##      values_from argument.

gap_normal <- gap_long_clean %>% 
  pivot_wider(names_from = obs_type, values_from = obs_values)
dim(gap_normal)
str(gap_normal)

dim(gapminder_data) # matches gap_normal, order of variables different 
str(gapminder_data)

names(gap_normal)
names(gapminder_data) # matches gap_normal, order of variables different 

## check order of the variables 
gap_normal <- gap_normal[, names(gapminder_data)]
all.equal(gap_normal, gapminder_data)

head(gap_normal)
head(gapminder_data)

gap_normal <- gap_normal %>% 
  arrange(country, year)
all.equal(gap_normal, gapminder_data)





