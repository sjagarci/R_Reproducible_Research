#Title: Creating Publication-Quality Graphics with ggplot2
#Date: February 10, 2026
#Author: Stephanie J. Garcia

install.packages("ggplot2")
library("ggplot2")

#OPTION 1: Read data directly from gapminder package
install.packages("gapminder")
library(gapminder)

#View the data
View(gapminder)
head(gapminder)

ggplot(data = gapminder)
#Nothing is plotted since we haven't specified what we wanted

#Add an aesthetic layer
#Scatterplot
ggplot(data = gapminder) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point()

#Line Plot (not ideal for what we are trying to portray here)
ggplot(data = gapminder) +
  aes(x = year, y = lifeExp, colour = continent) +
  geom_line()

#Line Plot (add a grouping option to shows the countries within continent)
ggplot(data = gapminder) + 
  aes(x = year, 
      y = lifeExp, 
      group = country, 
      colour = continent) + 
  geom_line()

#Let's try combine plots together (scatterplot + line plot)
ggplot(data = gapminder) + 
  aes(x = year, 
      y = lifeExp, 
      group = country, 
      colour = continent) + 
  geom_line() + 
  geom_point()

#Options in geom_point function 
ggplot(data = gapminder) +
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method = "lm", linewidth = 1.5)

#OPTION 2: Read data from dataset saved
getwd()
setwd("data")
getwd()

??read.csv
#We set the directory to data folder, for R to read gapminder_data
library(readr)
gapminder_data <- read.csv("gapminder_data.csv")
#Note that if we did not set the directory to data, we direct to data folder
#library(readr)
#gapminder_data <- read.csv("data/gapminder_data.csv")

library("ggplot2")
head(gapminder_data)

#Scatterplot of lifeExp by reported population across all countries in gapminder
ggplot(data = gapminder_data) +
  aes(x = pop, y = lifeExp) + 
  geom_point()

#Challenge 1: Modify the given code to show how life expectancy has changed over time
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point()

ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp) + 
  geom_point()
#Note: Binned scatterplot of life expectancy versus year showing how life  
#      expectancy has increased over time

#Challenge 2: Modify the previous code, add a color layer for continent
#             Is this what you expected to see? YES, Americas & Europe have 
#             higher life expectancy overall when compared to Africa & Oceania
#Binned scatterplot of life expectancy vs year with color-coded continents 
#             showing value of ‘aes’ function
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, colour = continent) + 
  geom_point()

#Plot lifeExp over time using a line graph instead of a scatterplot
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, colour = continent) + 
  geom_line()
#Line not what is expected; let's get a line by country

#Add the group aes so that ggplot knows to graph a line by country
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, group = country, colour = continent) + 
  geom_line()

#If we wish to view both a line and point the graph, we can add it
#Note that the points are on top of the line graph
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, group = country, colour = continent) + 
  geom_line() + 
  geom_point()

#Note that we can better see how the geom_point is on top of the geom_line point
#  by moving the colour option to the geom_line
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, group = country) + 
  geom_line(aes(colour = continent))+
  geom_point()

#Challenge 3: Switch the order of line and point and compare
#Switch scatterplot and line graph to show how ggplot works in layers
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, group = country) + 
  geom_point() +                           #point has switched places with line
  geom_line(aes(colour = continent))       #scatterplot is behind the line graph

#Note that using aes maps to a variable, we can switch from variable to value
ggplot(data = gapminder_data) + 
  aes(x = year, y = lifeExp, group = country) +
  geom_line(colour = "blue")
#Note that we do not add aes within the geom_line unless we are variable mapping

#TRANSFORMATION AND STATISTICS
# We can overlay statistical models over data 
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp) +
  geom_point()
#Difficult to see relationship due to outliers in gdpPercap, let's transform

#Use the scale function to change the scale of units on the x-axis
#Use alpha function to modify the transparency of points (helpful 4 clustered data)
??ggplot2 #Introduction to ggplot2 Help Page, scroll down to find info on scale
#Can refer directly to the ggplot2 book (https://ggplot2-book.org/) to search
#An example: Scale Transformations: 10.1.7 Transformations; or Alpha scales 11.6
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp) +
  geom_point(alpha = 0.5) + scale_x_log10()

#Add a new layer uusing geom_smooth to fit a simple relationship on prev code
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point(alpha = 0.5) + scale_x_log10() +
  geom_smooth(method = "lm")

#Make line thicker by usng the linewidth aes in the geom_smooth layer 
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point(alpha = 0.5) + scale_x_log10() + 
  geom_smooth(method = "lm", linewidth = 1.5)

#Challenge 4A: Modify the color and size points on the point layer in previous ex
#Remove alpha transparency
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp) + 
  geom_point(size = 3, colour = "orange") + scale_x_log10() +
  geom_smooth(method = "lm", linewidth = 1.5)

#Challenge 4B: Modify points to different shapes and color by continent with trendline
#Use color argument inside aes (since this maps to variables)
??ggplot2 #choose the option for aesthetic specifications
ggplot(data = gapminder_data) + 
  aes(x = gdpPercap, y = lifeExp, colour = continent) +
  geom_point(shape = 18) + scale_x_log10() + 
  geom_smooth(method = "lm", linewidth = 1.5)

#MULTI-PANEL FIGURES
#Subset data to include only countries from a specific continent (i.e., Americas) ~ 25
americas <- gapminder_data[gapminder_data$continent == "Americas",] #subset
ggplot(data = americas) + #use americas data
  aes(x = year, y = lifeExp) + #year by lifeExp
  geom_line() + #use a line graph
  facet_wrap(~ country) + #wrap by country
  theme(axis.text.x = element_text(angle = 45))

#Modify text (clean for publication)
#theme: controls the axis text overall text size
#labs: labels axes, plot title, and legend 
#Legend titles: set using the same names in aes specification (i.e. colour = continent)
#  while title of a fill legend would be set using fill = "MyTitle"
ggplot(data = americas) + 
  aes(x = year, y = lifeExp, colour = continent) + 
  geom_line() + 
  facet_wrap(~ country) + 
  labs(
    x = "Year", 
    y = "Life Expectancy", 
    title = "Figure 1", 
    colour = "Continent"
  ) + 
  theme(axis.text.x = element_text(angle = 45))

#Exporting the Plot using the ggsave() function
#specify dimension and resolution by adjusting arguments (width, height, dpi)
#To export: 
#1) assign it to a variable
#2) tell ggsave() to save in png format
#3) save to your results directory 

getwd()
setwd("..") #move up one level to parent directory
getwd()

#Modify title size using stringr package
install.packages("stringr")
library("stringr")

lifeExp_plot <-  
  ggplot(data = americas) + 
  aes(x = year, y = lifeExp, colour = continent) + 
  geom_line() + 
  facet_wrap(~ country) + 
  labs(
    x = "Year", 
    y = "Life Expectancy", 
    title = strwrap("Figure 1: Life Expectancy of Americas by Country and Year", 
                    width = 80),
    colour = "Continent"
  ) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  theme(plot.title = element_text(hjust = 0.5, 
                                  size = 14, 
                                  margin = margin(b = 10)))
          

ggsave(filename = "results/lifeExp.png", 
       plot = lifeExp_plot, 
       width = 20, height = 18, dpi = 300, 
       units = "cm")

#Challenge 5: Boxplots to compare life expectancy between continents during available yrs
ggplot(data = gapminder_data) + 
  aes(x = continent, 
      y = lifeExp, 
      fill = continent) + 
  geom_boxplot() + #boxplot graph
  facet_wrap(~ year) + #wrap by year
  labs(
    y = "Life Expectancy", 
    fill = "Continent") + 
  theme(axis.title.x = element_blank(), #remove title
        axis.text.x = element_blank(), #remove x axis label
        axis.ticks.x = element_blank()) #remove tick marks on x-axis

#Try saving
lifeExp_boxplot <- 
ggplot(data = gapminder_data) + 
  aes(x = continent, 
      y = lifeExp, 
      fill = continent) + 
  geom_boxplot() + #boxplot graph
  facet_wrap(~ year) + #wrap by year
  labs(
    y = "Life Expectancy", 
    fill = "Continent") + 
  theme(axis.title.x = element_blank(), #remove title
        axis.text.x = element_blank(), #remove x axis label
        axis.ticks.x = element_blank()) #remove tick marks on x-axis

ggsave(filename = "results/lifeExp_boxplot.png", 
       plot = lifeExp_boxplot, 
       width = 20, height = 18, dpi = 300, 
       units = "cm")
