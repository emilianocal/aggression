## Emiliano Calvo Alcaniz, Anna Dornhaus
## (c) 2026
## What is the role of aggression in determining contest success? 

# Setup ------------------------------------
## Packages -------------------------
library("tidyverse")
library("googledrive")
library('lubridate') # I believe this is native with tidyverse but just confirming

## Connect to google drive -------------------------
# Run this code, then log into google drive in order to access the data sheet
drive_auth()

## Import datasheets -------------------------
### Download aggr info datasheet, contains individual and colony info
drive_download("aggr-ant-individuals", type = "csv", overwrite = TRUE)
### Download behavior datasheet, contains video behavior analysis
drive_download("aggr-dyadic-contests", type = "csv", overwrite = TRUE)

## Rename datasheets -------------------------
indivdf <- read.csv("aggr-ant-individuals.csv")
behaviordf <- read.csv("aggr-dyadic-contests.csv")

# Data wrangling -------------------------
## Data wrangling for indivdf -------------------------

## Change the data types to all be much more usable for analysis
### Switching to logical data type
### Set yes/nos to True/False
indivdf$SITE_SAME <- if_else(indivdf$SITE_SAME == "no", FALSE, TRUE)
indivdf$oa <- if_else(indivdf$oa == "no", FALSE, TRUE)

### Remove unnecessary columns and the first row which I straight up won't use
indivdf <- select(indivdf, -c(colony_worker_number, colony_brood_number, color))
indivdf <- indivdf[-1,]

## Data wrangling for behaviordf -------------------------
### CHANGING DATA TYPES -------------------------
### Remove NA-NA dish lifted points (not getting used)
behaviordf <- filter(behaviordf, colony_id != "NA")
behaviordf <- filter(behaviordf, behavior != "died")

### Set factor data types
behaviordf$behavior <- as.factor(behaviordf$behavior)

### Parsing the times so they're manipulatable as time points
behaviordf$parsed_start <- ms(behaviordf$time_start)
behaviordf$parsed_end <- ms(behaviordf$time_end)

### Getting the duration for each behavior
behaviordf$duration <- behaviordf$parsed_end - behaviordf$parsed_start


### List of behaviors
behlist <- c("carry_opponent", "contact", "escape", "hold_brood"
               , "off_camera", "touch_brood")


### Collapse multiple instances of same behavior per contest
behaviordf <- behaviordf |>
  ### Group by the united columns
  group_by(contest_id, colony_id, focal_individual, behavior) |>
  ### Take the sum of the united columns, make the duration numeric so it doesn't glitch
  summarise(duration = sum(as.numeric(duration)))


### Add in every behavior for every individual
behaviordf <- crossing(behaviordf, b1 = behlist)

### 
behaviordf <- behaviordf |>
  mutate(duration = ifelse(behaviordf$behavior == behaviordf$b1, duration, 0))

### Remove column behavior
behaviordf <- behaviordf |> 
  select(-behavior)

behaviordf$behavior <- behaviordf$b1

behaviordf <- behaviordf |> 
  select(-b1)

## Summary table for figures -------------------------
###
mergedf <- full_join(
  indivdf
  , behaviordf 
  , by = join_by(contest_id, colony_id, ant_color_code == focal_individual))



# Figures -------------------------
## Individual morphology -------------------------

### Thorax Length to Weight
plot(jitter(indivdf$thorax_length_mm, factor = 1.5) ~ indivdf$weight_grams
  , xlab = "Indidvidual weight (g)"
  , ylab = "Thorax length (mm)"
  , pch = 19
)

### Head width to Weight
plot(indivdf$head_width_mm ~ indivdf$weight_grams
, xlab = "Indidvidual weight (g)"
, ylab = "Head width (mm)"
, pch = 19
)

### Femur length to Weight
plot(indivdf$femur_length_mm ~ indivdf$weight_grams
     , xlab = "Indidvidual weight (g)"
     , ylab = "Femur length (mm)"
     , pch = 19
)



## Behavior stuff -------------------------
### Boxplot different behaviors

boxplot(mergedf$duration ~ mergedf$behavior
#        , range = 0
        , main = "Time spent exhibiting different behaviors"
        , xlab = "Behaviors"
        , ylab = "Duration of behavior (sec)")






# Stat analysis -------------------------










