#######################################################
#### Emiliano Calvo Alcaniz ###########################
#######################################################
############## Ch 1 ###################################
####### What is the role of aggression ################
####### in determining contest success? ###############
#######################################################
# Jan-2026
#######################################################

# Install / Open packages ------------------------------------
library("tidyverse")
library("googledrive")


## Connect to google drive -------------------------
# Run this code, then log into google drive in order to access the data sheet
drive_auth()

## Import data sheets -----------------------------
# Download images datasheet
drive_download("aggr-ant-individuals", type = "csv", overwrite = TRUE)
# rename to something easier to use
# aggr-ant-individuals contains individual and colony info
indivdf <- read.csv("aggr-ant-individuals.csv")

# Download behavior datasheet
drive_download("aggr-dyadic-contests", type = "csv", overwrite = TRUE)
# rename to easier name
# contains behaviors at different time points
behaviordf <- read.csv("aggr-dyadic-contests.csv")







