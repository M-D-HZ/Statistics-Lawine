# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

library(here)

# Read Wind data
Wind <- read.csv(here("src", "Dataset", "Wind.csv"), row.names = 1)
set.seed(20210294)
myWindIndex <- sample(1:1000, 50)
myWind <- Wind[myWindIndex,]