#Title: Seeking Help
#Date: February 5, 2026
#Author: Stephanie J. Garcia

help(read.table)
#Use help with the package name in parenthesis to get a help file that describes

??read.table
#Shows all available sources that 

#Use Cran Tasks when you have no idea where to begin 

vignette()
#Gives vignette description for all present on your R system

vignette("ggplot2")
#Opens up the vignette for the introduction of ggplot2

# Challenge 1: Look at help page for c function. What kind of vector do you expect?
help("c")

c(1, 2, 3) #creates a vector of all numeric values
c('d', 'e', 'f') #creates a vector of all character values
c(1, 2, 'f') #mixed, and thus numeric are coerced to character

#Challenge 2: Use help for paste function, what is the diff between sep and collapse?
help("paste")
?paste

#sep specifies the string used between concatenated terms 
#collapse specifies that items are concatenized together using the given separator

paste(c("a","b"), "c")

paste(c("a", "b"), "c", ",")

paste(c("a", "b"), "c", collapse = "|")

paste(c("a","b"), "c", sep = ",", collapse = "|")

#Challenge 3: Find a function (and associated parameters) to load data from 
#  tabular file where columns are delimited with "/t" (tab) and decimal point (.)
#  is a period 

??"read table"
read.delim(file, header = TRUE, sep = "\t", quote = "\"",
           dec = ".", fill = TRUE, comment.char = "", ...)
