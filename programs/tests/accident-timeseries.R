# Count all, fatal, and nonfatal accidents by year
# Output: accident_time_series-year.csv in working directory
time_df_year <- count_df_sort[c("ev_year", "ev_year_t", "ev_year_f", "ev_year_fat")]
time_df_year$ev_year_nf <- time_df_year$ev_year_t - time_df_year$ev_year_f
time_df_year <- time_df_year[c("ev_year", "ev_year_t", "ev_year_nf", "ev_year_f", "ev_year_fat")]

write.table(time_df_year, file = "exports/accident_time_series-year.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
