# Title:  Data Structures
# Author: Stephanie J. Garcia
# Date:   Feb 16, 2026

## R's most powerful features is its ability to deal with tabular data
## Example dataset (cats) -- will create this data frame to save as csv file

cats <- data.frame(coat = c("calico", "black", "tabby"),
                   weight = c(2.1, 5.0, 3.2),
                   likes_catnip = c(1, 0, 1))

## Create csv data file for cats and load into data folder
write.csv(x = cats, file = "data/feline-data.csv", row.names = FALSE)

head(cats) #review of cats data just created

## Loading data into environmental using read.csv from data folder

cats <- read.csv(file = "data/feline-data.csv")
cats

## Checking data types in cats data
str(cats)

## Exploring dataset pulling out columns usingt the '$' operator
cats$weight
cats$coat

## We can do operations on columns
cats$weight + 2 # add 2 kg to weight

paste("My cat is", cats$coat) # add "My cat is" to cat coat type

## Try to do operations on different data types
#cats$weight + cats$coat # error, as expected (2.1 + "black") is nonsensical

# DATA TYPES  
## 5 main types: double (numeric), integer, complex, logical, character
typeof(cats$weight) # double AKA numeric
typeof(1L) # forces number to be an integer since R uses float numbers
typeof(1+1i) # complex 
typeof(TRUE) # logical
typeof('banana') # character

## Adding an additional row to our cats table using 'rbind'
additional_cat <- data.frame(coat = "tabby", 
                             weight = "2.3 or 2.4", #Note this data in new row
                             likes_catnip = 1)
additional_cat

cats2 <- rbind(cats, additional_cat)
cats2

## Check data type for weight given new data given 
typeof(cats2$weight) # converted to character from numeric
#cats2$weight + 2 # gives error since this is no longer a numeric data type
str(cats2) 

## Data frames are composed of rows and columns, each column has the same number
## of rows; different columns in a data frame can be made up of data types, but 
## everything in a given column needs to be the same type

# Vectors and Type Coercion 
## Vector in R is an ordered list of things with special conditions that
## everything in the vector be the same data type
another_vector <- vector(mode = 'character', length = 3)
another_vector

str(another_vector) # empty vector of character strings 
str(cats$weight) # vector of numeric data type 

## Discussion 1: Why does R care about what we put in our column data? How does
##               this help? 
##               If all items in a column are the same, we can make simple 
##               assumptions about our data (all are numeric; character, etc.)

## Coercing by combining vectors
combine_vector <- c(2, 6, 3)
combine_vector
str(combine_vector) # numeric as expected

## type coercion -- R will force all to be same type when a mix are in a single 
##                  vector
quiz_vector <- c(2, 6, '3') # force to character
str(quiz_vector)

coercion_vector <- c('a', TRUE)
str(coercion_vector) # forced to character

another_coercion_vector <- c(0, TRUE)
str(another_coercion_vector) # numeric since TRUE takes on a '1' value

### The type hierarchy (coercion rules) -- read as 'transformed into'
### logical > integer > double ("numeric") > complex > character 

## Force coercion against this flow using the as. function
character_vector_example <- c('0', '2', '4')
character_vector_example # character
character_coerced_to_double <- as.double(character_vector_example) #transform to numeric
character_coerced_to_double # numeric
double_coerced_to_logical <- as.logical(character_coerced_to_double)
double_coerced_to_logical

## A case where coercion is useful
cats$likes_catnip # numeric
cats$likes_catnip <- as.logical(cats$likes_catnip)
cats$likes_catnip

# CHALLENGES
## Challenge 1: Cleaning up input data
  ## Using the object `cats2`:
  ## 1. Print the data
  cats2

  ## 2. Show an overview of the table with all data types
  str(cats2)

  ## 3. The "weight" column has the incorrect data type CHARACTER.
  ##    The correct data type is: DOUBLE/NUMERIC.

  ## 4. Correct the 4th weight data point with the mean of the two given values
        cats2$weight[4] <- 2.35
  ##    print the data again to see the effect
        cats2
        str(cats2) # still has weight as character 

  ## 5. Convert the weight to the right data type
        cats2$weight <- as.double(cats2$weight)
        str(cats2)

  ##    Calculate the mean to test yourself
        mean(cats2$weight)
        
# Some basic vector functions
  ## combine function c() can append things to vectors
     ab_vector <- c('a', 'b')
     ab_vector
     
     combine_example <- c(ab_vector, 'SWC')
     combine_example
  
  ## Series of numbers 
     mySeries <- 1:10
     mySeries
     
     seq(10) # also makes a series of numbers 1 - 10
     seq(1,10, by=0.1)
     
  ## Ask questions to vectors 
     sequence_example <- 20:25 # series of numbers 20 - 25
     head(sequence_example, n = 2) # the first two elements in seq 20 - 25
     tail(sequence_example, n = 4) # the last four elements in seq 20 - 25
     length(sequence_example) # total number of elements in 20 - 25
     typeof(sequence_example) # provide data type - integer
     
     ## obtain individual elements of a vector using bracket notation
     first_element <- sequence_example[1]
     first_element # first element of sequence 20 - 25
     
     ## change a single element using a bracket on the other side of arrow
     sequence_example[1] <- 30 # replace 20 with 30
     sequence_example
     
## Challenge 2: Make a vector with numbers 1 - 26; then multiply by 2
   c2_vector <- 1:26
   c2_vector
   c2_vectorx2 <- (c2_vector * 2)
   c2_vectorx2

# LISTS (unlike vectors, any data type can be placed in a list), use list()
  ## Lists are useful to organize data of different types (more of its use later)
  list_example <- list(1, "a", TRUE, 1+4i) # recall use c() for vectors
  list_example
  str(list_example) # data types of all elements are listed
  
  ## use a double bracket [[]] to retrieve one element from a list, do not use ()
  list_example[[2]]
  
  ## assign names to elements on a list by prepending them (create a named list)
  another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE)
  another_list
  another_list$title # we have another way to retrieve elements from a named list
  
# NAMES: give meaning to elements 
  ## we can also make a named vector
  
  
  
     

