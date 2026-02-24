#Title: Exploring Data Frames
#Date: February 24-26, 2026
#Author: Stephanie J. Garcia

# Adding columns (serves as a vector)
## add a new age variable 

cats <- data.frame(coat = c("calico", "black", "tabby"),
                   weight = c(2.1, 5.0, 3.2),
                   likes_catnip = c(1, 0, 1))

age <- c(2, 3, 5)

## use cbind function 
cats_2 <- cbind(cats, age)
cats_2

# Adding rows (serves as a list)
## add a new case to a data frame -- not that the dimensions must be the same 
age <- c(2, 3)
cats_2 <- cbind(cats_2, age) #error since dimensions are not the same 

#How do identify what the dimensions are for data frame ? 
##nrow(): number of rows
##length(): number of rows 
str(cats) # Note that likes_catnip is currently set to numeric

#Change type of variable 
##covert to factor instead of as logical for future calculations
cats$likes_catnip <- as.factor(cats$likes_catnip)
str(cats)
cats

newRow <- list("tortoise shell", 3.3, TRUE, 9)

cats_3 <- rbind(cats_2, newRow) # adding a new row of data 
cats_3

# Removing rows [row, column]
cats_3[-4,] # remove the 4th row 
cats_3 # changed in column, but not global environment
## if we want to save the newly created data frame we need to create an object
remcol_cats_3 <- cats_3[-4,]
remcol_cats_3 # 4th row of data removed 

cats_3[ , -4] # removed the 4th column in console; must assign to save object 


# Appending
cats_4 <- rbind(cats_2, cats_3)
cats_4 #rows from cats_2 and rows from cats_3 are appended together; 7 rows 

# REAL EXAMPLE: gapminder data 
library(gapminder)
str(gapminder)

# Overview of the data using summary function 
summary(gapminder) #quick overview
typeof(gapminder$year) #function used to see how this data is saved in R 
typeof(gapminder$country) # integer
levels(gapminder$country) # labels for levels of country 
nrow(gapminder)
ncol(gapminder)
dim(gapminder)
head(gapminder)
colnames(gapminder)

install.packages("skimr")
library(skimr)
skim(gapminder)

