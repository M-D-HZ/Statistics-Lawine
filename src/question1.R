# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

library(here)

# Read Lawine data
Lawine <- read.csv(here("src", "Dataset", "Lawine.csv"), row.names = 1)
set.seed(20210294)
myLawineIndex <- sample(1:500, 450)
myLawine <- Lawine[myLawineIndex,]


library(ggplot2)
ggplot(myLawine, aes(x = Temperatuur, y = LawineGevaar)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(
    title = paste("Negative Correlation (r =", round(cor_test$estimate, 2), ")"),
    x = "Temperature (°C)",
    y = "Avalanche Risk (1-10)"
  ) +
  theme_minimal()

# Histograms
par(mfrow = c(1, 2))
hist(myLawine$Temperatuur, main = "Temperature Distribution")
hist(myLawine$LawineGevaar, main = "Avalanche Risk Distribution")

# Shapiro-Wilk test (if sample size is small; for n > 50, histograms are sufficient)
shapiro.test(myLawine$Temperatuur)
shapiro.test(myLawine$LawineGevaar)

# Pearson correlation
cor_test <- cor.test(myLawine$Temperatuur, myLawine$LawineGevaar, 
                     method = "pearson")
print(cor_test)

# Pearson correlation result: The histogram shows a bimodal distribution (two peaks),
# which violates Pearson’s assumption of normality. so we will use spearman's correlation

# Spearman correlation
cor_test_spearman <- cor.test(myLawine$Temperatuur, myLawine$LawineGevaar, 
                              method = "spearman")
print(cor_test_spearman)

# Boxplot to check for outliers
boxplot(myLawine$Temperatuur, main = "Temperature Boxplot")

# Regression Analysis to quantify the relationship
model <- lm(LawineGevaar ~ Temperatuur, data = myLawine)
summary(model)