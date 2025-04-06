# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

library(here)
library(ggplot2)

# Read Lawine data
Lawine <- read.csv("src/Dataset/Lawine.csv", row.names = 1)
set.seed(20210294)
myLawineIndex <- sample(1:500, 450)
myLawine <- Lawine[myLawineIndex,]

# --- Correlation Tests ---
# Pearson correlation
cor_test_pearson <- cor.test(myLawine$Temperatuur, myLawine$LawineGevaar, 
                             method = "pearson")
print(cor_test_pearson)
# Pearson correlation result: The histogram shows a bimodal distribution (two peaks),
# which violates Pearson’s assumption of normality. so we will use spearman's correlation

# Spearman correlation (better for bimodal data)
cor_test_spearman <- cor.test(myLawine$Temperatuur, myLawine$LawineGevaar, 
                              method = "spearman")
print(cor_test_spearman)

# --- Plot with Correlation in Title ---
ggplot(myLawine, aes(x = Temperatuur, y = LawineGevaar)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(
    title = paste("Correlation (Spearman's ρ =", round(cor_test_spearman$estimate, 2), ")"),
    x = "Temperature (°C)",
    y = "Avalanche Risk (1-10)"
  ) +
  theme_minimal()

# --- Other Diagnostics ---
# Histograms
par(mfrow = c(1, 2))
hist(myLawine$Temperatuur, main = "Temperature Distribution")
hist(myLawine$LawineGevaar, main = "Avalanche Risk Distribution")

# Shapiro-Wilk test (for reference, but not critical for n > 50)
shapiro.test(myLawine$Temperatuur)
shapiro.test(myLawine$LawineGevaar)

# Boxplot to check for outliers
boxplot(myLawine$Temperatuur, main = "Temperature Boxplot")

# Regression Analysis
model <- lm(LawineGevaar ~ Temperatuur, data = myLawine)
summary(model)