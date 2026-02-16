# R for Reproducible Scientific Analysis — Training Materials

This repository contains materials and scripts created while working through the
**Software Carpentry “R for Reproducible Scientific Analysis”** lesson using the 
Gapminder dataset.

This project was created for my personal professional development, to practice:
- Using **R and RStudio** for data analysis  
- Version control with **Git** and remote hosting on **GitHub**  
- Structuring projects for **reproducibility**  
- Organizing R scripts and outputs in a clean workflow

## Motivation

I set up this repository so I can refer back to this work in the future — even 
if I’m no longer on the same computer or environment. It records both code and 
results that illustrate key reproducible research practices.

## Lesson Overview

The Software Carpentry lesson covers fundamental R topics and workflows, 
including:

- Introduction to R and RStudio  
- Project management with RStudio  
- Reading and manipulating data  
- Exploring and subsetting data frames  
- Creating graphics (like with `ggplot2`)  
- Writing data to disk  
- Data transformation with `dplyr` and `tidyr`  
- Producing reports (e.g., with `knitr`)  
- Writing modular, reproducible R code  

The Gapminder dataset is used throughout as a concrete example to practice these 
skills.

## How to Use This Repo

1. Clone this repository locally:
   ```bash
   git clone git@github.com:sjagarci/R_Reproducible_Research.git
   
2. Open the R Studio project file: 
   R_Reproducible_Research.Rproj
   
3. Explore scripts in the doc/ folder; these are organized by lesson topic. 

4. The data/ folder contains the training dataset used in examples. 

5. The results/folder contains figures and outputs generated while working
   through lessons. 
   
## Directory Structure
- data/        # Example datasets used in the lessons
- doc/         # Scripts and lesson-based R code
- results/     # Output graphics and figures
- src/         # TBD
- .gitignore
- R_Reproducible_Research.Rproj

Notes
This repository is for training and reference; it is NOT part of an official 
Software Carpentry release. Materials in this lesson are licensed under the 
Carpentries’ CC-BY license.The focus of the lesson is on teaching core R concepts 
and reproducible workflows — not on statistical modeling.

