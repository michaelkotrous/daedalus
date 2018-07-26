# Run Durbin-Watson test for autocorrelation
## Null: residual autocorrelation is equal to zero
## Alternative: residual autocorrelation is greater than zero

## Output: durbinwatson-tests.csv in working directory
dw_df <- data.frame(matrix(NA, ncol=14, nrow=(2*length(top5codes)+6)))
names(dw_df) <- c("unit", "code", "private_dw", "private_p", "private_res_acf1", "avgas_dw", "avgas_p", "avgas_res_acf1", "hours_dw", "hours_p", "hours_res_acf1", "pilots_dw", "pilots_p", "pilots_res_acf1")

j <- 1

dw_df$unit[j] <- "level"
dw_df$code[j] <- "fatalities"
dw_df$private_dw[j] <- dwtest(lm(ev_year_fat ~ private_pilots_10k, data=count_df_sort))$statistic
dw_df$private_p[j] <- dwtest(lm(ev_year_fat ~ private_pilots_10k, data=count_df_sort))$p.value
dw_df$private_res_acf1[j] <- acf(lm(ev_year_fat ~ private_pilots_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$avgas_dw[j] <- dwtest(lm(ev_year_fat ~ avgas_10k, data=count_df_sort))$statistic
dw_df$avgas_p[j] <- dwtest(lm(ev_year_fat ~ avgas_10k, data=count_df_sort))$p.value
dw_df$avgas_res_acf1[j] <- acf(lm(ev_year_fat ~ avgas_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$hours_dw[j] <- dwtest(lm(ev_year_fat ~ flighthours_100k, data=count_df_sort))$statistic
dw_df$hours_p[j] <- dwtest(lm(ev_year_fat ~ flighthours_100k, data=count_df_sort))$p.value
dw_df$hours_res_acf1[j] <- acf(lm(ev_year_fat ~ flighthours_100k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$pilots_dw[j] <- dwtest(lm(ev_year_fat ~ pilots_10k, data=count_df_sort))$statistic
dw_df$pilots_p[j] <- dwtest(lm(ev_year_fat ~ pilots_10k, data=count_df_sort))$p.value
dw_df$pilots_res_acf1[j] <- acf(lm(ev_year_fat ~ pilots_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]

j <- j + 1

dw_df$unit[j] <- "level"
dw_df$code[j] <- "total"
dw_df$private_dw[j] <- dwtest(lm(ev_year_t ~ private_pilots_10k, data=count_df_sort))$statistic
dw_df$private_p[j] <- dwtest(lm(ev_year_t ~ private_pilots_10k, data=count_df_sort))$p.value
dw_df$private_res_acf1[j] <- acf(lm(ev_year_t ~ private_pilots_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$avgas_dw[j] <- dwtest(lm(ev_year_t ~ avgas_10k, data=count_df_sort))$statistic
dw_df$avgas_p[j] <- dwtest(lm(ev_year_t ~ avgas_10k, data=count_df_sort))$p.value
dw_df$avgas_res_acf1[j] <- acf(lm(ev_year_t ~ avgas_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$hours_dw[j] <- dwtest(lm(ev_year_t ~ flighthours_100k, data=count_df_sort))$statistic
dw_df$hours_p[j] <- dwtest(lm(ev_year_t ~ flighthours_100k, data=count_df_sort))$p.value
dw_df$hours_res_acf1[j] <- acf(lm(ev_year_t ~ flighthours_100k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$pilots_dw[j] <- dwtest(lm(ev_year_t ~ pilots_10k, data=count_df_sort))$statistic
dw_df$pilots_p[j] <- dwtest(lm(ev_year_t ~ pilots_10k, data=count_df_sort))$p.value
dw_df$pilots_res_acf1[j] <- acf(lm(ev_year_t ~ pilots_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]

j <- j + 1

dw_df$unit[j] <- "level"
dw_df$code[j] <- "fatal"
dw_df$private_dw[j] <- dwtest(lm(ev_year_f ~ private_pilots_10k, data=count_df_sort))$statistic
dw_df$private_p[j] <- dwtest(lm(ev_year_f ~ private_pilots_10k, data=count_df_sort))$p.value
dw_df$private_res_acf1[j] <- acf(lm(ev_year_f ~ private_pilots_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$avgas_dw[j] <- dwtest(lm(ev_year_f ~ avgas_10k, data=count_df_sort))$statistic
dw_df$avgas_p[j] <- dwtest(lm(ev_year_f ~ avgas_10k, data=count_df_sort))$p.value
dw_df$avgas_res_acf1[j] <- acf(lm(ev_year_f ~ avgas_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$hours_dw[j] <- dwtest(lm(ev_year_f ~ flighthours_100k, data=count_df_sort))$statistic
dw_df$hours_p[j] <- dwtest(lm(ev_year_f ~ flighthours_100k, data=count_df_sort))$p.value
dw_df$hours_res_acf1[j] <- acf(lm(ev_year_f ~ flighthours_100k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]
dw_df$pilots_dw[j] <- dwtest(lm(ev_year_f ~ pilots_10k, data=count_df_sort))$statistic
dw_df$pilots_p[j] <- dwtest(lm(ev_year_f ~ pilots_10k, data=count_df_sort))$p.value
dw_df$pilots_res_acf1[j] <- acf(lm(ev_year_f ~ pilots_10k, data=count_df_sort)$residuals, plot=FALSE)$acf[2]

j <- j + 1

# for loop for codes with level measures
for (code in top5codes) {
    dw_df$unit[j] <- "level"
    dw_df$code[j] <- code

    i <- 3
    for(level in activity_levels) {
        formula_levels <- paste("ev_year_fat",level," ~ ev_year_fat_",code,level,sep="")
        dw_df[,i][j] <- dwtest(lm(formula_levels, data=code_df_sort))$statistic
        i <- i + 1
        dw_df[,i][j] <- dwtest(lm(formula_levels, data=code_df_sort))$p.value
        i <- i + 1
        dw_df[,i][j] <- acf(lm(formula_levels, data=code_df_sort)$residuals, plot=FALSE)$acf[2]
        i <- i + 1
    }
    j <- j + 1
}

dw_df$unit[j] <- "change"
dw_df$code[j] <- "fatalities"
dw_df$private_dw[j] <- dwtest(lm(ev_year_fat_diff ~ private_pilots_10k_diff, data=count_df_sort_reg))$statistic
dw_df$private_p[j] <- dwtest(lm(ev_year_fat_diff ~ private_pilots_10k_diff, data=count_df_sort_reg))$p.value
dw_df$private_res_acf1[j] <- acf(lm(ev_year_fat_diff ~ private_pilots_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$avgas_dw[j] <- dwtest(lm(ev_year_fat_diff ~ avgas_10k_diff, data=count_df_sort_reg))$statistic
dw_df$avgas_p[j] <- dwtest(lm(ev_year_fat_diff ~ avgas_10k_diff, data=count_df_sort_reg))$p.value
dw_df$avgas_res_acf1[j] <- acf(lm(ev_year_fat_diff ~ avgas_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$hours_dw[j] <- dwtest(lm(ev_year_fat_diff ~ flighthours_100k_diff, data=count_df_sort_reg))$statistic
dw_df$hours_p[j] <- dwtest(lm(ev_year_fat_diff ~ flighthours_100k_diff, data=count_df_sort_reg))$p.value
dw_df$hours_res_acf1[j] <- acf(lm(ev_year_fat_diff ~ flighthours_100k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$pilots_dw[j] <- dwtest(lm(ev_year_fat_diff ~ pilots_10k_diff, data=count_df_sort_reg))$statistic
dw_df$pilots_p[j] <- dwtest(lm(ev_year_fat_diff ~ pilots_10k_diff, data=count_df_sort_reg))$p.value
dw_df$pilots_res_acf1[j] <- acf(lm(ev_year_fat_diff ~ pilots_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]

j <- j + 1

dw_df$unit[j] <- "change"
dw_df$code[j] <- "total"
dw_df$private_dw[j] <- dwtest(lm(ev_year_t_diff ~ private_pilots_10k_diff, data=count_df_sort_reg))$statistic
dw_df$private_p[j] <- dwtest(lm(ev_year_t_diff ~ private_pilots_10k_diff, data=count_df_sort_reg))$p.value
dw_df$private_res_acf1[j] <- acf(lm(ev_year_t_diff ~ private_pilots_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$avgas_dw[j] <- dwtest(lm(ev_year_t_diff ~ avgas_10k_diff, data=count_df_sort_reg))$statistic
dw_df$avgas_p[j] <- dwtest(lm(ev_year_t_diff ~ avgas_10k_diff, data=count_df_sort_reg))$p.value
dw_df$avgas_res_acf1[j] <- acf(lm(ev_year_t_diff ~ avgas_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$hours_dw[j] <- dwtest(lm(ev_year_t_diff ~ flighthours_100k_diff, data=count_df_sort_reg))$statistic
dw_df$hours_p[j] <- dwtest(lm(ev_year_t_diff ~ flighthours_100k_diff, data=count_df_sort_reg))$p.value
dw_df$hours_res_acf1[j] <- acf(lm(ev_year_t_diff ~ flighthours_100k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$pilots_dw[j] <- dwtest(lm(ev_year_t_diff ~ pilots_10k_diff, data=count_df_sort_reg))$statistic
dw_df$pilots_p[j] <- dwtest(lm(ev_year_t_diff ~ pilots_10k_diff, data=count_df_sort_reg))$p.value
dw_df$pilots_res_acf1[j] <- acf(lm(ev_year_t_diff ~ pilots_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]

j <- j + 1

dw_df$unit[j] <- "change"
dw_df$code[j] <- "fatal"
dw_df$private_dw[j] <- dwtest(lm(ev_year_f_diff ~ private_pilots_10k_diff, data=count_df_sort_reg))$statistic
dw_df$private_p[j] <- dwtest(lm(ev_year_f_diff ~ private_pilots_10k_diff, data=count_df_sort_reg))$p.value
dw_df$private_res_acf1[j] <- acf(lm(ev_year_f_diff ~ private_pilots_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$avgas_dw[j] <- dwtest(lm(ev_year_f_diff ~ avgas_10k_diff, data=count_df_sort_reg))$statistic
dw_df$avgas_p[j] <- dwtest(lm(ev_year_f_diff ~ avgas_10k_diff, data=count_df_sort_reg))$p.value
dw_df$avgas_res_acf1[j] <- acf(lm(ev_year_f_diff ~ avgas_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$hours_dw[j] <- dwtest(lm(ev_year_f_diff ~ flighthours_100k_diff, data=count_df_sort_reg))$statistic
dw_df$hours_p[j] <- dwtest(lm(ev_year_f_diff ~ flighthours_100k_diff, data=count_df_sort_reg))$p.value
dw_df$hours_res_acf1[j] <- acf(lm(ev_year_f_diff ~ flighthours_100k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]
dw_df$pilots_dw[j] <- dwtest(lm(ev_year_f_diff ~ pilots_10k_diff, data=count_df_sort_reg))$statistic
dw_df$pilots_p[j] <- dwtest(lm(ev_year_f_diff ~ pilots_10k_diff, data=count_df_sort_reg))$p.value
dw_df$pilots_res_acf1[j] <- acf(lm(ev_year_f_diff ~ pilots_10k_diff, data=count_df_sort_reg)$residuals, plot=FALSE)$acf[2]

j <- j + 1

for (code in top5codes) {
    dw_df$unit[j] <- "change"
    dw_df$code[j] <- code

    i <- 3
    for(field in activity_fields) {
        formula_change <- paste("ev_year_fat",field," ~ ev_year_fat_",code,field,sep="")
        dw_df[,i][j] <- dwtest(lm(formula_change, data=code_df_sort_reg))$statistic
        i <- i + 1
        dw_df[,i][j] <- dwtest(lm(formula_change, data=code_df_sort_reg))$p.value
        i <- i + 1
        dw_df[,i][j] <- acf(lm(formula_change, data=code_df_sort_reg)$residuals, plot=FALSE)$acf[2]
        i <- i + 1
    }
    j <- j + 1
}

write.table(dw_df, file = "exports/durbinwatson-tests.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
