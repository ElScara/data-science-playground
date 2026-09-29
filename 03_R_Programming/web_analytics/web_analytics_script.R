# -----------------------------------------
# 0) Install packages 
# -----------------------------------------
install.packages("car")       
 install.packages("ggplot2")  
 install.packages("dplyr")    

# -----------------------------------------
# 1) Load libraries
# -----------------------------------------
library(car)
library(ggplot2)
 library(dplyr)

# -----------------------------------------
# 2) Load the dataset
# -----------------------------------------
web_data <- readxl::read_xlsx("C:\\Users\\KaraboRamalatso\\Downloads\\1555058318_internet_dataset.xlsx")
# Make column names R-friendly
names(web_data) <- make.names(names(web_data))

# Check structure
str(web_data)

# -----------------------------------------
# 3) Basic data summarization
# -----------------------------------------
summary(web_data)

# summary for numeric variables
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

# -----------------------------------------
# 4) Convert categorical variables to factors
# -----------------------------------------
if ("Continent" %in% names(web_data)) {
web_data$Continent <- as.factor(web_data$Continent)
}

if ("Source.group" %in% names(web_data)) {
web_data$Source.group <- as.factor(web_data$Source.group)
}

# -----------------------------------------
# 5) Unique Pageview vs Visits
# -----------------------------------------
cor_test_uv <- cor.test(web_data$Uniquepageviews, web_data$Visits, use = "complete.obs")
print(cor_test_uv)

model_uv <- lm(Uniquepageviews ~ Visits, data = web_data)
summary(model_uv)

# Plot
library(ggplot2)

ggplot(web_data, aes(x = Visits, y = Uniquepageviews)) +
geom_point(color = "blue", alpha = 0.6) +
geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
labs(title = "Unique Pageviews vs Visits",
     x = "Visits",
     y = "Unique Pageviews") +
theme_minimal()

# -----------------------------------------
# 6) Factors affecting Exits
# -----------------------------------------
if ("Exits" %in% names(web_data)) {
model_exits <- lm(Exits ~ Bounces + Continent + Sourcegroup +
                    Timeinpage +  Uniquepageviews + Visits,
                  data = web_data)
summary(model_exits)
anova(model_exits)
vif(model_exits)

# Optional stepwise selection
step_exits <- step(model_exits, direction = "both")
summary(step_exits)
} else {
cat("Column 'Exits' not found in dataset.\n")
}

# -----------------------------------------
# Individual plots for factors affecting Exits
# -----------------------------------------

# Exits vs Bounces
ggplot(web_data, aes(x = Bounces, y = Exits)) +
  geom_point(color = "darkred", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linewidth = 1) +
  labs(title = "Bounces vs Exits",
       x = "Bounces",
       y = "Exits") +
  theme_minimal()

# Exits by Continent
ggplot(web_data, aes(x = Continent, y = Exits)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Exits by Continent",
       x = "Continent",
       y = "Exits") +
  theme_minimal()

# Exits by Source Group
ggplot(web_data, aes(x = Sourcegroup, y = Exits)) +
  geom_boxplot(fill = "skyblue") +
  coord_flip() +
  labs(title = "Exits by Source Group",
       x = "Source Group",
       y = "Exits") +
  theme_minimal()

# Exits vs Time on Page
ggplot(web_data, aes(x = Timeinpage, y = Exits)) +
  geom_point(color = "purple", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
  labs(title = "Exits vs Time on Page",
       x = "Time on Page",
       y = "Exits") +
  theme_minimal()

# Exits vs Unique Pageviews
ggplot(web_data, aes(x = Uniquepageviews, y = Exits)) +
geom_point(color = "orange", alpha = 0.6) +
geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
labs(title = "Exits vs Unique Pageviews",
     x = "Unique Pageviews",
     y = "Exits") +
theme_minimal()

# Exits vs Visits
ggplot(web_data, aes(x = Visits, y = Exits)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
  labs(title = "Exits vs Visits",
       x = "Visits",
       y = "Exits") +
  theme_minimal()

} else {
cat("Column 'Exits' not found in dataset.\n")
}

# -----------------------------------------
# 7) Factors affecting Time on Page
# -----------------------------------------
model_time <- lm(Timeinpage ~ Bounces + Continent + Sourcegroup +
  Uniquepageviews + Visits + Exits,
data = web_data)

summary(model_time)

# -----------------------------------------
# 8) Factors affecting Bounces
# -----------------------------------------

model_bounce <- lm(Bounces ~ Continent + Sourcegroup +
  Timeinpage + Uniquepageviews + Visits + Exits,
data = web_data)

summary(model_bounce)
