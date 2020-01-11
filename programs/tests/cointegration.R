# Test if accident/fatality series are cointegrated with any activity series 
## Sample Plot of Flight Hours-Fatalities Spread (theta * X_t - Y_t)
png(file="exports/flightHoursFatalities-Spread.png", width=768, height=576)

fat <- count_df_sort$ev_year_fat
hrs <- count_df_sort$flighthours_100k
year <- count_df_sort$ev_year

### As with EG-ADF test, theta is estimated in first-stage regression
### In this case, we set theta equal to coefficient for flight hours in reg
reg <- lm(fat ~ hrs)
theta <- reg$coefficients[2]
theta_hrs <- theta * hrs
hrs_fat_spread <- theta_hrs - fat

### Begin with line plot of fatalities by year
plot(fat~year, 
     type = "line", 
     lty = 2,
     lwd = 2,
     xlab = "Year",
     ylab = expression(paste("Fatalities, ", theta, " * Flight Hours (100k)")),
     ylim = c(250, 1500),
     main = "GA Flight Hours & Part 91 Fatalities")

### Add line of theta * flight hrs by year
lines(theta_hrs~year,
      lty = 1,
      lwd = 2)

### Shade the Flight Hours-Fatalities spread
polygon(c(year, rev(year)), 
        c(theta_hrs, rev(fat)),
        col = alpha("steelblue", alpha = 0.3),
        border = NA)

### Add the fatalities-flight hours spread by year
lines(hrs_fat_spread~year, 
     col = "steelblue",
     lwd = 2,
     lty = 1)

### Add hline at average value of spread. It helps visualize (non-)stationarity
abline(mean(hrs_fat_spread), 0)

### Add a legend
legend("topright", 
       legend = c(expression(paste(theta, " * Flight Hours (100k)")), "Fatalities", "Flight Hours-Fatalities Spread"),
       col = c("black", "black", "steelblue"),
       lwd = c(2, 2, 2),
       lty = c(1, 2, 1))

### Export plot to file
dev.off()


## EG-ADF test for all combinations of accident/fatality and activity pairs
### Write results to plain text file
file_df <- file("exports/EG-ADF-results.txt", open = "wt")
sink(file_df)
sink(file_df, type="message")

### Fatalities on Activity Measures
#### Fatalities on Flight Hours computed at line 11
e_t <- resid(reg)
print("DF test of residuals: Fatalities on Flight Hours")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(fat ~ count_df_sort$pilots_10k)
e_t <- resid(reg)
print("DF test of residuals: Fatalities on Pilots")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(fat ~ count_df_sort$private_pilots_10k)
e_t <- resid(reg)
print("DF test of residuals: Fatalities on Private Pilots")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(fat ~ count_df_sort$avgas_10k)
e_t <- resid(reg)
print("DF test of residuals: Fatalities on Avgas")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

### Total Accidents on Activity Measures
reg <- lm(count_df_sort$ev_year_t ~ hrs)
e_t <- resid(reg)
print("DF test of residuals: Total Accidents on Flight Hours")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(count_df_sort$ev_year_t ~ count_df_sort$pilots_10k)
e_t <- resid(reg)
print("DF test of residuals: Total Accidents on Pilots")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(count_df_sort$ev_year_t ~ count_df_sort$private_pilots_10k)
e_t <- resid(reg)
print("DF test of residuals: Total Accidents on Private Pilots")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(count_df_sort$ev_year_t ~ count_df_sort$avgas_10k)
e_t <- resid(reg)
print("DF test of residuals: Total Accidents on Avgas")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

### Fatal Accidents on Activity Measures
reg <- lm(count_df_sort$ev_year_f ~ hrs)
e_t <- resid(reg)
print("DF test of residuals: Fatal Accidents on Flight Hours")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(count_df_sort$ev_year_f ~ count_df_sort$pilots_10k)
e_t <- resid(reg)
print("DF test of residuals: Fatal Accidents on Pilots")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(count_df_sort$ev_year_f ~ count_df_sort$private_pilots_10k)
e_t <- resid(reg)
print("DF test of residuals: Fatal Accidents on Private Pilots")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

reg <- lm(count_df_sort$ev_year_f ~ count_df_sort$avgas_10k)
e_t <- resid(reg)
print("DF test of residuals: Fatal Accidents on Avgas")
print(summary(ur.df(e_t, type="none", lags=0, selectlags="Fixed")))

sink()
