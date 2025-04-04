# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

library(here)

# Read Lawine data
Lawine <- read.csv(here("src", "Dataset", "Lawine.csv"), row.names = 1)
set.seed(20210294)
myLawineIndex <- sample(1:500, 450)
myLawine <- Lawine[myLawineIndex,]

head(myLawine)  # View first few rows
summary(myLawine)  # Summary statistics
str(myLawine)  # Check data types

library(ggplot2)
ggplot(myLawine, aes(x = Temperatuur, y = LawineGevaar)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relationship between Temperature and Avalanche Risk",
       x = "Temperature (°C)",
       y = "Avalanche Risk (1-10)") +
  theme_minimal()

# Histograms
par(mfrow = c(1, 2))
hist(myLawine$Temperatuur, main = "Temperature Distribution")
hist(myLawine$LawineGevaar, main = "Avalanche Risk Distribution")

# Shapiro-Wilk test (if sample size is small; for n > 50, histograms are sufficient)
shapiro.test(myLawine$Temperatuur)
shapiro.test(myLawine$LawineGevaar)