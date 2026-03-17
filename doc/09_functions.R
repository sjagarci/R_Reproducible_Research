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

# Course material examples:
fahr_to_kelvin <- function(temp) {
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

fahr_to_kelvin(200)

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  temp_c <- kelvin_to_celsius(temp_k)
  return(temp_c)
}

fahr_to_celsius(200)

# Defensive Programming 
## How do you know if the function worked properly? 

# Let's revisit the previous example
fahr_to_kelvin <- function(temp) {
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

# For this function to work, what should the properties of temp? 
## temp MUST be a numeric (not character, not logical)
# We can include an input to check if the properties are correct for this f(x)
fahr_to_kelvin <- function(temp) {
  if(!is.numeric(temp)) {
    stop("temp must be a numeric vector")
  }
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

fahr_to_kelvin(as.factor(212))

# Where are you seen defensive programming messages? 
# Cran Task Views: Clinical Trials 
#library(eselect) # error received from library f(x) since we did not install eselect

# You could also use a stopifnot(is.numeric(temp))
fahr_to_kelvin <- function(temp) {
    stopifnot(is.numeric(temp)) 
  kelvin <- (temp - 32) * (5 / 9) + 273.15
  return(kelvin)
}

#fahr_to_kelvin(as.character(200)) # error since 200 is coerced to character
