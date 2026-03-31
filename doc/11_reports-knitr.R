#Title: Producing Reports with knitr
#Author: Stephanie J. Garcia
#Date: March 31 - Apr 2, 2026 

#Objective: 

## Monday topics
## The imporance of writing reproducible reports
## Introduction of RMarkdown file
## 


# Reproducibility reports or data science? 

  ## Scientific integrity and trust [data manipulation, human error, fraud]
  ## Efficiency and continuity [Data science projects are never linear]
  ## The future you problem, new team 
  ## Collaboration
  ## Regulatory and compliance for publications etc. 

# Markup Language
  ## Some big names: HTML, XML, RMarkdown (human-readable)

# Create a new file > R Markdown

# YAML Header
---
  title: "Introduction to RMarkdown"
author: "Stephanie Garcia"
date: "2026-03-31"
output: html_document
---

# Code Chunk: 

  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
  
# Body of the document 

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
  
  ```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:
  
  ```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

