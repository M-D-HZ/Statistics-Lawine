# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

library(here)

# Read Temperatuur data
Temperatuur <- read.csv(here("src", "Dataset", "Temperatuur.csv"), row.names = 1)
set.seed(20210294)
myTempIndex <- sample(1:2500, 250)
myTemp <- Temperatuur[myTempIndex,]