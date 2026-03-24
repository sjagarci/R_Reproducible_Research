#Title: Iterations with Purrr
#Author: Stephanie J. Garcia
#Date: March 24-26, 2026

# If I have a list of data, how do I loop through that list manipulating and 
##  running analyses on its data without using for() loops? 
# Goal: apply our manipulations and analyses the same way to every item in the list

# Use PURRR to replace loops()
## 1. Read in many CSVs as a list of data frames

library(tidyverse)
dir("data/", pattern = "_torn.csv", full.names = TRUE)

## Using purrr:map we can read all at once
### map(.x = , #Here we supply the vector or list of values (in this case filenames))
###     .f = ~ ) #Here we supply the function we want to feed those values into

## Let's start mapping!

# Create a vector of all csv filenames 
filenames <- dir("data/", pattern = "_torn.csv", full.names = TRUE)

# For each name in the vector, read it and make a dataframe out of it 
tornado_data_list <- map(.x = filenames, # .x signifies one item in our list of filenames)
                         .f = ~ read.csv(file = .x, stringsAsFactors = FALSE)
                         )

# Review output of map() statement 
str(tornado_data_list) # messy 
length(tornado_data_list) #helpful, shows 11 data frames
head(tornado_data_list[[1]]) # review at 1 individual one
tornado_data_list # review all of them 

## 2. Apply a model to the data for each separate data frame

# Iteratively performing analysis: run a linear model for all 11 data frames
## We'll model tornado ratio (mag) as a function of estimated property loss (loss)
map(.x = tornado_data_list,
    .f = ~ lm(formula = mag ~ loss, data = .x)) # ERRORS
## 3. Cover how to handle errors while iterating over lists 

# Purrr has functions that allows us to continue pushing through past errors
## safely(): for each list item you iterate over returns both a result and error

safe_model <- safely(.f = ~ lm(formula = mag ~ loss, data = .x)) 
                      # feed this newly wrapped function into the map statement 
                      # that caused earlier errors

safe_model_output <- map(.x = tornado_data_list, 
                         .f = ~ safe_model(.x))

safe_model_output[[1]]

# Use transpose() to invert the output of safe_model
transposed <- transpose(safe_model_output) # lists 10/11 with no errors -- issue with df 7

#successful_model <- safe_model_output %>% 
# transpose() %>% 
#  pluck("result")

#successful_model <- successful_model %>% 
# discard(is.null) # update successful_model to discard error model

#length(successful_model) # 10 successful runs 

## Review error with df 7 
tornado_data_list[[7]]$mag %>% 
  unique() # cheeseburger included as a "y" response

## Discard the df that does not have the outcome in format needed
discard(transposed$result, is.null) #discard item #7 that had null value 

## 4. Filter the data for each data frame separately, then combine into single df

# Summarizing and condensing datasets 
tornado_summary <- 
  map_df(tornado_data_list, 
         ~.x %>% 
           mutate(mag = as.numeric(mag)) %>% 
           filter(
             # Remove unknown values
             mag != -9, 
             # Tornadoes not crossing state lines ns == 1
             ns == 1, 
             # Entire track in current state sn == 1
             sn == 1, 
             # Entire track, not a portion of the track sg == 1
             sg == 1) %>% 
           select(om, date, yr, st, mag, loss, closs)
           )

head(tornado_summary, n = 11)

#tornado_summary <- transposed %>% 
  #map(~ .x %>% 
        #mutate(mag = as.numeric(mag)) %>% 
        #filter(mag != -9, # Remove unknown values map !=-9, 
               #ns == 1, # Tornadoes not crossing state lines ns == 1, 
               #sn == 1, # Entire track in current state sn == 1, 
               #sg == 1 # Entire track, not a portion of the track sg == 1
        #) %>% 
        #select(om, date, yr, st, mag, loss, closs))

#head(tornado_summary)
                            
## 5. Split a data frame into a new list 

tornado_by_state <- tornado_summary %>% 
  split(x = ., # . replace the name with the data frame 
        f = list(.$st)) # look at the specific column from the list with st

### Alternatively, can be written as below 

tornado_by_state_alt <- 
  split(x = tornado_summary,
        f = tornado_summary$st) # split by state 

## 6. Plot and export .png files for many figures all at once 




