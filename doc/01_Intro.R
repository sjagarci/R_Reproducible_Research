# Introduction 
# Date: February 3, 2026
# Author: Stephanie J. Garcia 

# USING R AS A CALCULATOR 

1 + 100
1 + 
  # R waits for you to complete this command if the console shows + instead of >
  # Press ESC to cancel a command 
  # Order of operations PEMDAS
  
3 + 5 * 2
# Note that 1 is added from the previous command left unfinished

(3 + 5) * 2

(3 +(5 * (2 ^ 2))) # hard to read
3 + 5 * 2 ^ 2 # clear if you remember the rules
3 + 5 * (2 ^ 2) #if you forget some of the rules, this will help

2 / 100000

5e3 # Note the lack of minus here

# MATHEMATICAL FUNCTIONS 

getwd() #returns an absolute filepath

sin(1) # trig functions

log(1) # natural log

log(10) # base-10 log

exp(0.5) # e^(1/2)

# Use ? before the name of a command to open a help page 

# COMPARING THINGS

1 == 1 # equality ( == is read as 'is equal to')
# only used when comparing two integers
# refer to issue of floating points and how sometimes you can a funky result
  # https://floating-point-gui.de/ 

1 != 2 # inequality ( ! = is read as 'is not equal to' )

1 < 2 # less than

1 <= 1 # less than or equal to

1 > 0 # greater than 

1 >= -9 # greater than or equal to

# VARIABLES AND ASSIGNMENT

# Recall use alt + - for assignment operator
x <- 1/40
x

log(x)

x <- 100 
# Note that the value of x is now replaced from 0.25 to 100

x <- x + 1
y <- x * 2 

# Notes about variable names: can contain letters, numbers, period, underscore, 
#   but no spaces (e.g. periods.between.words, underscore_between_words, 
#   camelCaseToSeparateWords (doesn't matter which one you use, just be consistent)

# Challenge 1: Which of the following are valid R variable names? 
# min_height
# max.height
# _age (NO)
# .mass (NO) # this creates a hidden variable 
# MaxLength
# min-length (NO)
# 2widths (NO)
# celsius2kelvin

# VECTORIZATION 
# (R is vectorized - variables and functions can have vectors as values)

1:5

2^(1:5)

x <- 1:5 
2^x

# MANAGING YOUR ENVIRONMENT
ls() # lists all of the variables and functions stored in global environment
# ls will hide any variables or functions starting with a "." by default
ls(all.names = TRUE) # lists all objects (even the hidden ones)

ls
# using ls without the parenthesis will have R print out the contents of ls
# the content printed here is what makes the ls function work when we add the ()
#  just like we did when we asked for R to print 'x' and it contained 1,2,3,4,5

rm(x)
# use rm() to delete objects you no longer need, here we remove x 
# we can run rm(list = ls()) if we wish to delete all the objects in our environment

# R PACKAGES

installed.packages() # Review what packages are installed
# install individual packages by using install.packages("packagename")
update.packages() # update installed packages 
# remove packages by using remove.packages("packagename")

# Make use of a package by using library("packagename")

# Challenge 2: What will be the value of each variable after each statement? 
mass <- 47.5
mass
age <- 122
age
mass <- mass * 2.3
age <- age - 20

# Challenge 3: Write a command to compare mass to age. Is mass larger than age?
mass > age 

# Challenge 4: Clean up working environment by deleting mass and age variables. 
rm(mass, age)

# Challenge 5: Install Packages (ggplot2, plyr, gapminder)
install.packages(c("ggplot2", "plyr", "gapminder"))


  
  
  
  