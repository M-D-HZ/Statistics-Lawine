# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

# Read Temperatuur data (If you are in Rstudio, make sure ur working directory is set correctly)
Temperatuur <- read.csv("src/Dataset/Temperatuur.csv", row.names = 1)
set.seed(20210294)
myTempIndex <- sample(1:2500, 250)
myTemp <- Temperatuur[myTempIndex,]

# Summary statistics
summary(myTemp)

# Scatter plot to visualize the relationship
plot(myTemp$Hoogte, myTemp$Temperatuur, 
     xlab = "Altitude (m)", ylab = "Temperature (°C)",
     main = "Temperature vs. Altitude")A