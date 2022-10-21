install.packages("readr")
install.packages("ggplot2")
library(readr)
ecb_data <- read_csv("E:/ECB QE/ECB Data Portal_20231226161720.csv")
ecb_data$DATE <- as.Date(ecb_data$DATE, format="%Y-%m-%d")
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
str(ecb_data)
summary(ecb_data)
library(ggplot2)
ggplot(ecb_data, aes(x = DATE, y = `HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)) +
geom_line() +
labs(title = "Time Series of HICP - Overall Index", x = "Date", y = "HICP Index")
ggplot(ecb_data, aes(x = DATE, y = `HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`)) + 
  geom_line() +
  geom_vline(xintercept = as.numeric(qe_start_date), linetype="dashed", color = "red") +
  labs(title = "Inflation Rates with QE Period Highlighted", x = "Date", y = "Inflation Rate (%)")
quantile(ecb_data$`HICP - Overall index (ICP.M.U2.N.000000.4.ANR)`, probs = c(0.25, 0.5, 0.75))

