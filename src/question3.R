# Author: Anass Hamzaoui - 20210294
# Part 1: Loading Wind data based on student number

Wind <- read.csv("src/Dataset/Wind.csv", row.names = 1)

set.seed(20210294)
myWindIndex <- sample(1:nrow(Wind), 250)
myWind <- Wind[myWindIndex, , drop = FALSE]  # ensure it's still a data frame

# Part 2: Hypothesis test on absolute wind speed
absWind <- abs(myWind$Windsnelheid)

# One-sided t-test: H0: mean <= 14, H1: mean > 14
t.test(absWind, mu = 14, alternative = "greater")
