## Compute autocorrelations of accident, fatality, and activity time series
## Output: timeseries_autocorrelations.csv in working directory
autocorr_df <- data.frame(matrix(NA, ncol=4, nrow=7))
names(autocorr_df) <- c("series", "r_lag", "r2_lag", "p_lag")

t_ac1 <- rcorr(count_df_sort_reg$ev_year_t, count_df_sort_reg$ev_year_t_lag)
autocorr_df$series[1] <- "total_accidents"
autocorr_df$r_lag[1] <- t_ac1$r[upper.tri(t_ac1$r)]
autocorr_df$r2_lag[1] <- autocorr_df$r_lag[1]^2
autocorr_df$p_lag[1] <- t_ac1$P[upper.tri(t_ac1$P)]

f_ac1 <- rcorr(count_df_sort_reg$ev_year_f, count_df_sort_reg$ev_year_f_lag)
autocorr_df$series[2] <- "fatal_accidents"
autocorr_df$r_lag[2] <- f_ac1$r[upper.tri(f_ac1$r)]
autocorr_df$r2_lag[2] <- autocorr_df$r_lag[2]^2
autocorr_df$p_lag[2] <- f_ac1$P[upper.tri(f_ac1$P)]

fat_ac1 <- rcorr(count_df_sort_reg$ev_year_fat, count_df_sort_reg$ev_year_fat_lag)
autocorr_df$series[3] <- "fatalities"
autocorr_df$r_lag[3] <- fat_ac1$r[upper.tri(fat_ac1$r)]
autocorr_df$r2_lag[3] <- autocorr_df$r_lag[3]^2
autocorr_df$p_lag[3] <- fat_ac1$P[upper.tri(fat_ac1$P)]

priv_ac1 <- rcorr(count_df_sort_reg$private_pilots_10k, count_df_sort_reg$private_pilots_10k_lag)
autocorr_df$series[4] <- "private_pilots"
autocorr_df$r_lag[4] <- priv_ac1$r[upper.tri(priv_ac1$r)]
autocorr_df$r2_lag[4] <- autocorr_df$r_lag[4]^2
autocorr_df$p_lag[4] <- priv_ac1$P[upper.tri(priv_ac1$P)]

pil_ac1 <- rcorr(count_df_sort_reg$pilots_10k, count_df_sort_reg$pilots_10k_lag)
autocorr_df$series[5] <- "pilots"
autocorr_df$r_lag[5] <- pil_ac1$r[upper.tri(pil_ac1$r)]
autocorr_df$r2_lag[5] <- autocorr_df$r_lag[5]^2
autocorr_df$p_lag[5] <- pil_ac1$P[upper.tri(pil_ac1$P)]

avgas_ac1 <- rcorr(count_df_sort_reg$avgas_10k, count_df_sort_reg$avgas_10k_lag)
autocorr_df$series[6] <- "avgas"
autocorr_df$r_lag[6] <- avgas_ac1$r[upper.tri(avgas_ac1$r)]
autocorr_df$r2_lag[6] <- autocorr_df$r_lag[6]^2
autocorr_df$p_lag[6] <- avgas_ac1$P[upper.tri(avgas_ac1$P)]

hours_ac1 <- rcorr(count_df_sort_reg$flighthours_100k, count_df_sort_reg$flighthours_100k_lag)
autocorr_df$series[7] <- "flighthours"
autocorr_df$r_lag[7] <- hours_ac1$r[upper.tri(hours_ac1$r)]
autocorr_df$r2_lag[7] <- autocorr_df$r_lag[7]^2
autocorr_df$p_lag[7] <- hours_ac1$P[upper.tri(hours_ac1$P)]

write.table(autocorr_df, file = "exports/timeseries_autocorrelations.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
