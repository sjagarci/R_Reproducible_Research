# Title: Project Management With RStudio
# Date: February 3, 2026 
# Author: Stephanie J. Garcia

# Challenge 4: general idea about the dataset, directly from the command line, 
#             before loading it into R

# Use Terminal below to run the Challenge 3 lines
      # ls -lh data/gapminder_data.csv
      # wc -l data/gapminder_data.csv
      # head data/gapminder_data.csv

# 1. What is the size of the file? 80K
# 2. How many rows of data does it contain? 1705
# 3. What kinds of values are stored in this file? 
     # country, year, pop, continent, lifeExp, gdpPercap

install.packages(c("gapminder", "tidyverse"))
library("gapminder")
library(tidyverse)

head(gapminder)

# Challenge 5: Checking working directory 

getwd()
# "C:/Users/sjagarci/OneDrive - Florida International University/FIU-STATCONSULT/TRAINING/Professional Development/R-for-Reproducible-Research/R_Reproducible_Research"

# Change working directory using the setwd() 

setwd("data") # sets the working directory to the data folder 

getwd() # updated working directory now points to data folder 

# SUPPLEMENTAL: USING GIT FROM RSTUDIO
# Confirmed that RStudio has been linked to GitHub
# Will check to see whether or not this appears on GitHub
