# ==============================================================================
# Web Analytics & User Behavior Modeling
# ==============================================================================

# ------------------------------------------------------------------------------
# 1) Package Management & Dependencies
# ------------------------------------------------------------------------------
required_packages <- c("car", "ggplot2", "dplyr", "readxl")
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages) > 0) install.packages(new_packages)

library(car)
library(ggplot2)
library(dplyr)
library(readxl)

# ------------------------------------------------------------------------------
# 2) Data Ingestion & Schema Cleaning
# ------------------------------------------------------------------------------
# Relative path assumes working directory is set to this project folder
web_data <- readxl::read_xlsx("1555058318_internet_dataset.xlsx")

# Standardize column names to valid R identifiers
names(web_data) <- make.names(names(web_data))

# Quick structural inspection
str(web_data)

# ------------------------------------------------------------------------------
# 3) Exploratory Data Summaries
# ------------------------------------------------------------------------------
summary(web_data)

# Compute parametric and non-parametric statistics across attributes
num_summary <- sapply(web_data, function(x) {
  if (is.numeric(x)) {
    c(
      min = min(x, na.rm = TRUE),
      max = max(x, na.rm = TRUE),
      mean = mean(x, na.rm = TRUE),
      median = median(x, na.rm = TRUE),
      sd = sd(x, na.rm = TRUE)
    )
  } else {
    c(unique_values = length(unique(x)))
  }
})
print(num_summary)

# ------------------------------------------------------------------------------
# 4) Categorical Variable Encoding
# ------------------------------------------------------------------------------
if ("Continent" %in% names(web_data)) {
  web_data$Continent <- as.factor(web_data$Continent)
}
if ("Source.group" %in% names(web_data)) {
  web_data$Source.group <- as.factor(web_data$Source.group)
}

# ------------------------------------------------------------------------------
# 5) Bivariate Analysis: Unique Pageviews vs. Visits
# ------------------------------------------------------------------------------
cor_test_uv <- cor.test(web_data$Uniquepageviews, web_data$Visits, use = "complete.obs")
print(cor_test_uv)

model_uv <- lm(Uniquepageviews ~ Visits, data = web_data)
summary(model_uv)

# Scatter plot with linear regression fit
ggplot(web_data, aes(x = Visits, y = Uniquepageviews)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
  labs(
    title = "Unique Pageviews vs Visits",
    x = "Visits",
    y = "Unique Pageviews"
  ) +
  theme_minimal()

# ------------------------------------------------------------------------------
# 6) Multivariate Regression: Factors Affecting Exits
# ------------------------------------------------------------------------------
if ("Exits" %in% names(web_data)) {
  # Full OLS model
  model_exits <- lm(
    Exits ~ Bounces + Continent + Sourcegroup + Timeinpage + Uniquepageviews + Visits,
    data = web_data
  )
  print(summary(model_exits))
  print(anova(model_exits))
  print(vif(model_exits))
  
  # Bidirectional stepwise model selection
  step_exits <- step(model_exits, direction = "both")
  print(summary(step_exits))
  
  # Diagnostic visualisations for Exits
  # Exits vs Bounces
  p1 <- ggplot(web_data, aes(x = Bounces, y = Exits)) +
    geom_point(color = "darkred", alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 1) +
    labs(title = "Bounces vs Exits", x = "Bounces", y = "Exits") +
    theme_minimal()
  print(p1)
  
  # Exits by Continent
  p2 <- ggplot(web_data, aes(x = Continent, y = Exits)) +
    geom_boxplot(fill = "lightgreen") +
    labs(title = "Exits by Continent", x = "Continent", y = "Exits") +
    theme_minimal()
  print(p2)
  
  # Exits by Source Group
  p3 <- ggplot(web_data, aes(x = Sourcegroup, y = Exits)) +
    geom_boxplot(fill = "skyblue") +
    coord_flip() +
    labs(title = "Exits by Source Group", x = "Source Group", y = "Exits") +
    theme_minimal()
  print(p3)
  
  # Exits vs Time on Page
  p4 <- ggplot(web_data, aes(x = Timeinpage, y = Exits)) +
    geom_point(color = "purple", alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
    labs(title = "Exits vs Time on Page", x = "Time on Page", y = "Exits") +
    theme_minimal()
  print(p4)
  
  # Exits vs Unique Pageviews
  p5 <- ggplot(web_data, aes(x = Uniquepageviews, y = Exits)) +
    geom_point(color = "orange", alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
    labs(title = "Exits vs Unique Pageviews", x = "Unique Pageviews", y = "Exits") +
    theme_minimal()
  print(p5)
  
  # Exits vs Visits
  p6 <- ggplot(web_data, aes(x = Visits, y = Exits)) +
    geom_point(color = "blue", alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
    labs(title = "Exits vs Visits", x = "Visits", y = "Exits") +
    theme_minimal()
  print(p6)
  
} else {
  cat("Column 'Exits' not found in dataset.\n")
}

# ------------------------------------------------------------------------------
# 7) Secondary Models: Time on Page & Bounces
# ------------------------------------------------------------------------------
model_time <- lm(
  Timeinpage ~ Bounces + Continent + Sourcegroup + Uniquepageviews + Visits + Exits,
  data = web_data
)
summary(model_time)

model_bounce <- lm(
  Bounces ~ Continent + Sourcegroup + Timeinpage + Uniquepageviews + Visits + Exits,
  data = web_data
)
summary(model_bounce)
print(summary(model_bounce))
