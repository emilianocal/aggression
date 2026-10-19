## Emiliano Calvo Alcaniz, Anna Dornhaus
## (c) 2026
## What is the role of aggression in determining contest success? 

# Setup ------------------------------------
## Packages -------------------------
library("tidyverse")
library("googledrive")


## Connect to google drive -------------------------
# Run this code, then log into google drive in order to access the data sheet
drive_auth()

## Import datasheets -------------------------
# Download aggr info datasheet, contains individual and colony info
drive_download("aggr-ant-individuals", type = "csv", overwrite = TRUE)
# Download behavior datasheet, contains video behavior analysis
drive_download("aggr-dyadic-contests", type = "csv", overwrite = TRUE)

## Rename datasheets -------------------------
indivdf <- read.csv("aggr-ant-individuals.csv")
behaviordf <- read.csv("aggr-dyadic-contests.csv")

# Data wrangling -------------------------
## Data wrangling for indivdf -------------------------


## Data wrangling for behaviordf -------------------------






# Figures -------------------------
## 



# Stat analysis -------------------------










