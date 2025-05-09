# Author: Anass Hamzaoui - 20210294
# Part 1: Loading all the given data based on my student number

# Read Temperatuur data (If you are in Rstudio, make sure ur working directory is set correctly)
Temperatuur <- read.csv("src/Dataset/Temperatuur.csv", row.names = 1)
set.seed(20210294)
myTempIndex <- sample(1:2500, 250)
myTemp <- Temperatuur[myTempIndex,]

# Summary statistics
summary(myTemp)

# Scatter plot to visualize the relationship with better formatting
plot(myTemp$Hoogte, myTemp$Temperatuur, 
     xlab = "Altitude (m)", ylab = "Temperature (°C)",
     main = "Temperature vs. Altitude",
     pch = 19, col = "blue", cex = 0.7)
grid()

# Fit linear model
temp_model <- lm(Temperatuur ~ Hoogte, data = myTemp)

# Model summary
summary(temp_model)

# Plot regression line with confidence interval
plot(myTemp$Hoogte, myTemp$Temperatuur, 
     xlab = "Altitude (m)", ylab = "Temperature (°C)",
     main = "Temperature vs. Altitude with Regression Line",
     pch = 19, col = "blue", cex = 0.7)
abline(temp_model, col = "red", lwd = 2)

# Add confidence interval
newdata <- data.frame(Hoogte = seq(min(myTemp$Hoogte), max(myTemp$Hoogte), length.out = 100))
pred <- predict(temp_model, newdata, interval = "confidence")
lines(newdata$Hoogte, pred[, "lwr"], col = "red", lty = 2)
lines(newdata$Hoogte, pred[, "upr"], col = "red", lty = 2)
legend("topright", legend = c("Regression line", "95% CI"), 
       col = c("red", "red"), lty = c(1, 2), lwd = c(2, 1))

# Diagnostic plots
par(mfrow = c(2, 2))
plot(temp_model, which = 1:4)
par(mfrow = c(1, 1))

# Check for normality of residuals
shapiro.test(residuals(temp_model))

# Check for heteroscedasticity
library(lmtest)
bptest(temp_model)

# Calculate and print model performance metrics
cat("\nModel Performance Metrics:\n")
cat("R-squared:", summary(temp_model)$r.squared, "\n")
cat("Adjusted R-squared:", summary(temp_model)$adj.r.squared, "\n")
cat("RMSE:", sqrt(mean(residuals(temp_model)^2)), "\n")

# Check for polynomial relationship
# Fit quadratic model
temp_model_quad <- lm(Temperatuur ~ Hoogte + I(Hoogte^2), data = myTemp)
summary(temp_model_quad)

# Compare models
anova(temp_model, temp_model_quad)

# Plot quadratic fit
plot(myTemp$Hoogte, myTemp$Temperatuur, 
     xlab = "Altitude (m)", ylab = "Temperature (°C)",
     main = "Quadratic Model Fit",
     pch = 19, col = "blue", cex = 0.7)
lines(sort(myTemp$Hoogte), predict(temp_model_quad, newdata = data.frame(Hoogte = sort(myTemp$Hoogte))), 
      col = "green", lwd = 2)
legend("topright", legend = c("Data", "Quadratic fit"), 
       col = c("blue", "green"), pch = c(19, NA), lty = c(NA, 1), lwd = c(NA, 2))

# Conclusion
cat("\nConclusion:\n")
cat("Based on the analysis, altitude is a statistically significant predictor of temperature (p < 2.2e-16).\n")
cat("The linear model explains", round(summary(temp_model)$r.squared * 100, 1), "% of the variance in temperature.\n")
cat("For every 100m increase in altitude, temperature decreases by approximately", 
    round(coef(temp_model)[2] * 100, 2), "°C on average.\n")
cat("The quadratic model provides a slightly better fit (R-squared =", 
    round(summary(temp_model_quad)$r.squared * 100, 1), "%) but the improvement is not substantial.\n")
cat("The linear model appears adequate for predicting temperature from altitude in this region.\n")