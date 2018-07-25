## Compute correlations between changes in accidents (total and fatal) and fatalities and changes in activity measures
## Output: accident_activity_change_correlations.csv in working directory
activity_changes <- c("private_pilots_10k_diff", "avgas_10k_diff", "flighthours_100k_diff", "pilots_10k_diff")

corr_change_df <- data.frame(matrix(NA, ncol=10, nrow=length(activity_changes)))
names(corr_change_df) <- c("activity", "t_r", "t_r2", "t_p", "f_r", "f_r2", "f_p", "fat_r", "fat_r2", "fat_p")

j <- 1

for (activity_change in activity_changes) {
    corr_change_df$activity[j] <- activity_change

    res_t <- rcorr(count_df_sort_reg$ev_year_t_diff, count_df_sort_reg[,activity_change])

    corr_change_df$t_r[j] <- res_t$r[upper.tri(res_t$r)]
    corr_change_df$t_r2[j] <- res_t$r[upper.tri(res_t$r)]^2
    corr_change_df$t_p[j] <- res_t$P[upper.tri(res_t$P)]

    res_f <- rcorr(count_df_sort_reg$ev_year_f_diff, count_df_sort_reg[,activity_change])

    corr_change_df$f_r[j] <- res_f$r[upper.tri(res_f$r)]
    corr_change_df$f_r2[j] <- res_f$r[upper.tri(res_f$r)]^2
    corr_change_df$f_p[j] <- res_f$P[upper.tri(res_f$P)]

    res_fat <- rcorr(count_df_sort_reg$ev_year_fat_diff, count_df_sort_reg[,activity_change])

    corr_change_df$fat_r[j] <- res_fat$r[upper.tri(res_fat$r)]
    corr_change_df$fat_r2[j] <- res_fat$r[upper.tri(res_fat$r)]^2
    corr_change_df$fat_p[j] <- res_fat$P[upper.tri(res_fat$P)]

    j <- j + 1
}

write.table(corr_change_df, file = "exports/accident_activity_change_correlations.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
