# European Central Bank Quantitative Easing Analysis

## Project Overview

This project aims to analyze the impact of the European Central Bank's quantitative easing (QE) measures on inflation in the Eurozone. Using historical inflation data, the project applies statistical and Bayesian methods to understand how QE influenced inflation rates.

## Data Source

The primary dataset used in this analysis is the Harmonized Index of Consumer Prices (HICP) obtained from the European Central Bank's data portal. This dataset includes monthly inflation rates in the Eurozone from 1997 to the present.

## Dependencies

- R (Version x.x.x or higher)
- R packages: `readr`, `ggplot2`, `rstan` or `brms` (for Bayesian analysis)

## Files in the Repository

- `ECB Data Portal_20231226161720.csv`: Raw HICP data from the ECB.
- `ECB_Analysis.R`: R script for data preprocessing, exploratory data analysis, and statistical modeling.
- `README.md`: Documentation of the project.

## Getting Started

1. **Install R and RStudio**: Make sure you have R and RStudio installed on your computer.

2. **Clone the Repository**: Clone this repository to your local machine to get started with the analysis.

3. **Install Required R Packages**:
   ```R
   install.packages("readr")
   install.packages("ggplot2")
   install.packages("rstan")  # or brms
