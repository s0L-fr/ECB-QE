# libraries
install.packages("readr")
install.packages("ggplot2")
install.packages("e1071")
install.packages("stats")
install.packages("zoo")
install.packages("brms")
library(readr)

# Load the dataset (adjust the path to your CSV file)
ecb_data <- read_csv("E:/ECB QE/ECB Data Portal_20231226161720.csv")

# Convert DATE column to Date format
ecb_data$DATE <- as.Date(ecb_data$DATE, format="%Y-%m-%d")

# Define the QE start date and create a binary indicator for QE period
qe_start_date <- as.Date("1997-01-31")  # Replace with actual QE start date
ecb_data$QEPeriod <- ifelse(ecb_data$DATE >= qe_start_date, 1, 0)
sum(is.na(ecb_data))
# Count missing values in each column
sapply(ecb_data, function(x) sum(is.na(x)))
# Using naniar for visualization (install it if not already installed)
install.packages("naniar")
library(naniar)
vis_miss(ecb_data)
library(naniar)
vis_miss(ecb_data)

table(is.na(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`), ecb_data$DATE)

# --- Exploratory Data Analysis (EDA) ---

# Basic structure and summary of the data
str(ecb_data)
summary(ecb_data)
library(ggplot2)
# Time Series Plot
ggplot(ecb_data, aes(x = DATE, y = `HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)) +
geom_line() +
labs(title = "Time Series of HICP - Overall Index", x = "Date", y = "HICP Index")

# Highlighting Pre and Post QE Periods
ggplot(ecb_data, aes(x = DATE, y = `HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)) + 
  geom_line() +
  geom_vline(xintercept = as.numeric(qe_start_date), linetype="dashed", color = "red") +
  labs(title = "Inflation Rates with QE Period Highlighted", x = "Date", y = "Inflation Rate (%)")
quantile(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`, probs = c(0.25, 0.5, 0.75))
# Calculate the standard deviation of the column
std_deviation <- sd(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)

# Calculate the number of observations
n <- length(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)

# Calculate the standard error
std_error <- std_deviation / sqrt(n)

# Now you can view the standard error
std_error

# Trends in Inflation Rate

aggregate(`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)` ~ QEPeriod, data = ecb_data, FUN = mean)
aggregate(`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)` ~ QEPeriod, data = ecb_data, FUN = median)
aggregate(`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)` ~ QEPeriod, data = ecb_data, FUN = sd)

# Monthly or Yearly Changes

ecb_data$Year <- format(ecb_data$DATE, "%Y")
aggregate(`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)` ~ Year, data = ecb_data, FUN = mean)

# Identifying Outliers

boxplot(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`, main = "Boxplot of Inflation Rates")

# Grouped Analysis
aggregate(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)` ~ ecb_data$QEPeriod, FUN = summary)

# Time Series Decomposition

library(stats)
decomposed <- decompose(ts(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`, frequency = 12))  # Adjust 'frequency' as per your data
plot(decomposed)

#Histogram

ggplot(ecb_data, aes(x = `HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)) +
  geom_histogram(bins = 30, fill = "blue", alpha = 0.7) +
  labs(title = "Histogram of Inflation Rates", x = "Inflation Rate (%)", y = "Frequency")
