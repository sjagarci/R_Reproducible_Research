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
cats$weight + cats$coat # error, as expected (2.1 + "black") is nonsensical

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
cats2$weight + 2 # gives error since this is no longer a numeric data type
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