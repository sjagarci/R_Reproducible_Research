#Title: Functions
#Date: March 17-19, 2026
#Author: Stephanie J. Garcia

library(tidyverse)

# Functions in R 
 ## Define functions, arguments
 ## Create a function that returns a value
 ## Defensive programming
 ## Check argument condition with stopifnot()
 ## Why divide programs into small functions
 ## Combining functions
 ## Example function with gapminder data

# What is a function?
 ## Functions gather a sequence of operations into a whole, preserving it for 
 ##  ongoing use. 

# Why do you need functions? 
 ## Combine several operation. 
 ## Analyze data 
 ## Repetition (avoid errors)
 ## Solve challenge

# How to create a function 
help("function")

my_function <- function(parameters) {
  # perform action 
  # return value
}

adding_two_number <- function(number1, number2) {
  Sum_two_number <- number1 + number2
  # comments can be added
  return(Sum_two_number)
}

# Parts of a function 
# Function has three main parts: 
## Name: how you call the function later
## Arguments (inputs): these are the variables  you pass into the function so
   ## it has data to work with. 
## Body: the actual code inside of {} brackets
## Return value: final result that the function spits out

adding_two_number(30, 40)

# DEFINING A FUNCTION
## We define fahr_to_kelvin() by assigning it to the output of function. 
## The list of argument names are contained within parentheses. 
## Next, the body of the function–the statements that are executed when it 
###     runs–is contained within curly braces ({}). 
### The statements in the body are indented by two spaces, makes it easier to read
###     but does not affect how the code operates.
## NOTE: Return statement is not reqd, R auto returns whichever var is in the body
###      for clarity, we will explicitly define it

fahr_to_kelvin <- function(temp) {
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin) # not reqd, but included for clarity
}

# freezing point of water
fahr_to_kelvin(32)
# boiling point of water
fahr_to_kelvin(212)

# CHALLENGE 1: Write a function called kelvin_to_celsius() that takes a temp
##             in Kelvin and returns that temp to Celsius 
##             HINT: To convert from Kelvin to Celsius, subtract by 273.15

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

# Boiling point of water, Kelvin = 373.15, Celsius should be 100 C
kelvin_to_celsius(373.15)
# Freezing point of water, Kelvin = 273.15, Celsius should be 0 C
kelvin_to_celsius(273.15)
# Absolute zero, Kelvin = 0, Celsius should be -273.15
kelvin_to_celsius(0)

# COMBINING FUNCTIONS
## the real power of functions comes from mixing, matching, & combining

# Define two functions that will convert temp from F to K, and K to C
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

# CHALLENGE 2: Define a f(x) to convert directly from F to C, by reusing the two
##             functions above

fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  temp_c <- kelvin_to_celsius(temp_k)
  return(temp_c)
}

fahr_to_celsius(200)

# Interlude: DEFENSIVE PROGRAMMING
## How do you know if the function worked properly? 
## Defensive Programming: Checking function parameters 
###  Encourages us to frequently check conditions and throw an error if 
###      something is wrong. 
###  These checks are referred to as assertion statements because we want to 
###       assert some condition is TRUE before proceeding. 
###  Helps debug where the errors originate

## Checking conditions with defensive programming (e.g. stopifnot()) 

### Let's revisit the previous example
### function to convert F to K 

fahr_to_kelvin <- function(temp) {
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

# For this function to work, what should the properties of temp? 
## temp MUST be a numeric (not character, not logical)
## We can include an input to check if the properties are correct for this f(x)
## NOTE: if we had many args to check, we would need to write many lines of code
##       see below for R's convenience function stopifnot()

fahr_to_kelvin <- function(temp) {
  if(!is.numeric(temp)) {
    stop("temp must be a numeric vector")
  }
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

# fahr_to_kelvin(as.factor(212)) #error, 212 coerced to factor

## Where are you seen defensive programming messages? Everytime we have an error
## Cran Task Views: Clinical Trials 
## library(eselect) # error received from library f(x) since we did not install 
##                    eselect package 

# Using stopifnot(is.numeric(temp))
fahr_to_kelvin <- function(temp) {
  stopifnot(is.numeric(temp)) 
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

# freezing point of water
fahr_to_kelvin(temp = 32)

#fahr_to_kelvin(as.character(200)) # error since 200 is coerced to character

# CHALLENGE 3: Use defensive programming to ensure that fahr_to_celsius throws
##             an error immediately if the argument temp is incorrecly specified

fahr_to_celsius <- function(temp) {
  stopifnot(is.numeric(temp))
  temp_k <- fahr_to_kelvin(temp)
  temp_c <- kelvin_to_celsius(temp_k)
  return(temp_c)
}

# fahr_to_celsius(as.character(150))

# MORE ON COMBINING FUNCTIONS
## Define a function that calculates the Gross Domestic Product (GDP) of a nation
##   from the data available in our dataset

# Takes a dataset and multiplies the population column 
# with the GDP per capita column
## Per capita GDP is a financial metric that breaks down a country's economic 
##     output per person (nation GDP/population)

library(gapminder)

calcGDP <- function(dat) {
  gdp <- dat$pop * dat$gdpPercap
  return(gdp)
}

calcGDP(head(gapminder)) # not very informative, gives gdp all country & years?

## adding more arguments, to produce gdp extract per year, per country 

# Function to calculate GDP for given year and/or country
calcGDP_yrcountry <- function(dat, year = NULL, country = NULL) {
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ] # selects those rows with year data
  }
  if(!is.null(country)) {
    dat <- dat[dat$country %in% country, ] # selects those rows with country data
  }
  gdp <- dat$pop * dat$gdpPercap # gdp function
  
  new <- cbind(dat, gdp = gdp) 
  return(new)
}

## Specify for Year 2007
head(calcGDP_yrcountry(gapminder, year = 2007))

## Specify for country of Austrailia 
calcGDP_yrcountry(gapminder, country = "Australia")

## Specify for both Year = 2007 and country of Australia 
calcGDP_yrcountry(gapminder, year = 2007, country = "Australia")

# CHALLENGE 4: Test out GDP function for New Zealand 1987; how does this differ
##             from New Zealand 1952

### Notes mentioned, forgot that c() refers to combine values into a vector or list
# calcGDP(gapminder, year = c(1952, 1987), country = "New Zealand")
calcGDP_yrcountry(gapminder, year = c(1952, 1987), country = "New Zealand")
?c # concatenate function  

?rbind
calcGDP_yrcountry(gapminder, year = rbind(1952, 1987), country = "New Zealand")
## results same but this is overkill, recall that rbind creates a matrix

# CHALLENGE 5: The paste() function can be used to combine text together 
best_practice <- c("Write", "programs", "for", "people", "not", "computers")
paste(best_practice, collapse = " ")

## Write a function called fence() that takes two vectors as arguments, called 
##   text and wrapper, and prints out the text with the wrapper : 
## Note: the paste() function has an argument called sep, which specifies 
##      the separator between text. The default is a space: ” “. 
##      The default for paste0() is no space”“.

fence <- function(text, wrapper) {
  text <- c(wrapper, text, wrapper)
  result <- paste(text, collapse = " ")
  return(result)
  }
  
best_practice <- c("Write", "programs", "for", "people", "not", "computers")

fence(best_practice, wrapper = "***")

# TIP: TESTING AND DOCUMENTING

# Notes from Video Walkthrough 3-19-2026

## Define a function that calculates gdp by country and year
## Adding NULL allows us to put a range of inputs 
## Much cleaner version of code than the base R function method above 
calGDP_new <- function(data, Year = NULL, Country = NULL) {
  if(!is.null(Year)) {
    data <- data %>% filter(year == Year)
  }
  if(!is.null(Country)) {
    data <- data %>% filter(country == Country)
  }
  
  gdp <- data$pop * data$gdpPercap
  
  new <- cbind(data, gdp = gdp) 
  return(new)
}

# Report gdp for all years in New Zealand 
calGDP_new(gapminder, Year = , Country = "New Zealand")

# PASS BY VALUE: invoke a function, creates an intermediate data frame, once the 
##               function is done, it is done, it is not saved in your environment

# SCOPING RULES: How does R locate an object? 
## Local environment: inside function 
## Enclosing environment: if a function is inside another function - looks here first
### e.g. filter (dplyr function) search within the function where it is defined, 
### if it does not exist here, go to global environment, if not search the package 
## Global environment 
## Packages 