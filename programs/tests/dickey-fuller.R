# Dickey-Fuller Test
## Write test summaries to plain text file
file_df <- file("exports/dickey-fuller-results.txt", open = "wt")
sink(file_df)
sink(file_df, type="message")

## No constant and no trend
print("Fatalities, No Constant")
print(summary(ur.df(count_df_sort$ev_year_fat, type="none", lags=0, selectlags="Fixed")))
print("Accidents Total, No Constant")
print(summary(ur.df(count_df_sort$ev_year_t, type="none", lags=0, selectlags="Fixed")))
print("Accidents Fatal, No Constant")
print(summary(ur.df(count_df_sort$ev_year_f, type="none", lags=0, selectlags="Fixed")))
print("Private Pilots, No Constant")
print(summary(ur.df(count_df_sort$private_pilots_10k, type="none", lags=0, selectlags="Fixed")))
print("Avgas Consumption, No Constant")
print(summary(ur.df(count_df_sort$avgas_10k, type="none", lags=0, selectlags="Fixed")))
print("Flight Hours, No Constant")
print(summary(ur.df(count_df_sort$flighthours_100k, type="none", lags=0, selectlags="Fixed")))
print("Pilots Total, No Constant")
print(summary(ur.df(count_df_sort$pilots_10k, type="none", lags=0, selectlags="Fixed")))

## Constant and no trend
print("Fatalities, Constant")
print(summary(ur.df(count_df_sort$ev_year_fat, type="drift", lags=0, selectlags="Fixed")))
print("Accidents Total, Constant")
print(summary(ur.df(count_df_sort$ev_year_t, type="drift", lags=0, selectlags="Fixed")))
print("Accidents Fatal, Constant")
print(summary(ur.df(count_df_sort$ev_year_f, type="drift", lags=0, selectlags="Fixed")))
print("Private Pilots, Constant")
print(summary(ur.df(count_df_sort$private_pilots_10k, type="drift", lags=0, selectlags="Fixed")))
print("Avgas Consumption, Constant")
print(summary(ur.df(count_df_sort$avgas_10k, type="drift", lags=0, selectlags="Fixed")))
print("Flight Hours, Constant")
print(summary(ur.df(count_df_sort$flighthours_100k, type="drift", lags=0, selectlags="Fixed")))
print("Pilots Total, Constant")
print(summary(ur.df(count_df_sort$pilots_10k, type="drift", lags=0, selectlags="Fixed")))

sink()
