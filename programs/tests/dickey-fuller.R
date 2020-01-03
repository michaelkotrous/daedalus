# Dickey-Fuller Test
## No constant and no trend
summary(ur.df(count_df_sort$ev_year_fat, type="none", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$ev_year_t, type="none", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$ev_year_f, type="none", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$private_pilots_10k, type="none", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$avgas_10k, type="none", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$flighthours_100k, type="none", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$pilots_10k, type="none", lags=0, selectlags="Fixed"))

## Constant and no trend
summary(ur.df(count_df_sort$ev_year_fat, type="drift", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$ev_year_t, type="drift", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$ev_year_f, type="drift", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$private_pilots_10k, type="drift", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$avgas_10k, type="drift", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$flighthours_100k, type="drift", lags=0, selectlags="Fixed"))
summary(ur.df(count_df_sort$pilots_10k, type="drift", lags=0, selectlags="Fixed"))
