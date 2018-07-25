## Compute correlations between changes in fatality rates and changes in code-specific fatality rates
## Output: fatalityrate_coderate_change_correlations.csv in working directory
reg_df <- data.frame(matrix(NA, ncol=13, nrow=length(top5codes)))
names(reg_df) <- c("code", "private_r", "private_r2", "private_p", "avgas_r", "avgas_r2", "avgas_p", "hours_r", "hours_r2", "hours_p", "pilots_r", "pilots_r2", "pilots_p")

j <- 1

for (code in top5codes) {
    reg_df$code[j] <- code

    i <- 1
    for (field in activity_fields) {
        id[i] <- paste("ev_year_fat_",code,field,sep="")
        i <- i + 1
    }

    res_private <- rcorr(code_df_sort_reg$ev_year_fat_per_private10k_diff, code_df_sort_reg[,id[1]])

    reg_df$private_r[j] <- res_private$r[upper.tri(res_private$r)]
    reg_df$private_r2[j] <- res_private$r[upper.tri(res_private$r)]^2
    reg_df$private_p[j] <- res_private$P[upper.tri(res_private$P)]

    res_avgas <- rcorr(code_df_sort_reg$ev_year_fat_per_avgas10k_diff, code_df_sort_reg[,id[2]])

    reg_df$avgas_r[j] <- res_avgas$r[upper.tri(res_avgas$r)]
    reg_df$avgas_r2[j] <- res_avgas$r[upper.tri(res_avgas$r)]^2
    reg_df$avgas_p[j] <- res_avgas$P[upper.tri(res_avgas$P)]

    res_hours <- rcorr(code_df_sort_reg$ev_year_fat_per_hours100k_diff, code_df_sort_reg[,id[3]])

    reg_df$hours_r[j] <- res_hours$r[upper.tri(res_hours$r)]
    reg_df$hours_r2[j] <- res_hours$r[upper.tri(res_hours$r)]^2
    reg_df$hours_p[j] <- res_hours$P[upper.tri(res_hours$P)]

    res_pilots <- rcorr(code_df_sort_reg$ev_year_fat_per_pilots10k_diff, code_df_sort_reg[,id[4]])

    reg_df$pilots_r[j] <- res_pilots$r[upper.tri(res_pilots$r)]
    reg_df$pilots_r2[j] <- res_pilots$r[upper.tri(res_pilots$r)]^2
    reg_df$pilots_p[j] <- res_pilots$P[upper.tri(res_pilots$P)]

    j <- j + 1
}

write.table(reg_df, file = "exports/fatalityrate_coderate_change_correlations.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
