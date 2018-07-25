# Summary statistics and time series data for top 5 fatality codes
# Output: fatalitytop5-counts.csv
years <- unique(factor(code_df_sort$ev_year))
j <- 1
for (year in years) {
    for (code in top5codes) {
        fatcode1 <- paste("ev_year_fat_",top5codes[1],sep="")
        fatcode2 <- paste("ev_year_fat_",top5codes[2],sep="")
        fatcode3 <- paste("ev_year_fat_",top5codes[3],sep="")
        fatcode4 <- paste("ev_year_fat_",top5codes[4],sep="")
        fatcode5 <- paste("ev_year_fat_",top5codes[5],sep="")

        fcode1 <- paste("ev_year_f_",top5codes[1],sep="")
        fcode2 <- paste("ev_year_f_",top5codes[2],sep="")
        fcode3 <- paste("ev_year_f_",top5codes[3],sep="")
        fcode4 <- paste("ev_year_f_",top5codes[4],sep="")
        fcode5 <- paste("ev_year_f_",top5codes[5],sep="")

        tcode1 <- paste("ev_year_t_",top5codes[1],sep="")
        tcode2 <- paste("ev_year_t_",top5codes[2],sep="")
        tcode3 <- paste("ev_year_t_",top5codes[3],sep="")
        tcode4 <- paste("ev_year_t_",top5codes[4],sep="")
        tcode5 <- paste("ev_year_t_",top5codes[5],sep="")
    }

    ## Append sums to code_df_sort data frame as new columns
    code_df_sort$ev_year_fat_top5[j] <- code_df_sort[,fatcode1][j] + code_df_sort[,fatcode2][j] + code_df_sort[,fatcode3][j] + code_df_sort[,fatcode4][j] + code_df_sort[,fatcode5][j]
    code_df_sort$ev_year_f_top5[j] <- code_df_sort[,fcode1][j] + code_df_sort[,fcode2][j] + code_df_sort[,fcode3][j] + code_df_sort[,fcode4][j] + code_df_sort[,fcode5][j]
    code_df_sort$ev_year_t_top5[j] <- code_df_sort[,tcode1][j] + code_df_sort[,tcode2][j] + code_df_sort[,tcode3][j] + code_df_sort[,tcode4][j] + code_df_sort[,tcode5][j]
    j <- j + 1
}

code_df_sort$ev_year_fat_top5_percent <- code_df_sort$ev_year_fat_top5/code_df_sort$ev_year_fat
code_df_sort$ev_year_f_top5_percent <- code_df_sort$ev_year_f_top5/code_df_sort$ev_year_f
code_df_sort$ev_year_t_top5_percent <- code_df_sort$ev_year_t_top5/code_df_sort$ev_year_t

fatalitytop5counts <- code_df_sort[c("ev_year", "ev_year_fat", "ev_year_fat_top5", "ev_year_fat_top5_percent", "ev_year_fat_250", "ev_year_fat_240", "ev_year_fat_230", "ev_year_fat_350", "ev_year_fat_220", "ev_year_f", "ev_year_f_top5", "ev_year_f_top5_percent", "ev_year_f_250", "ev_year_f_240", "ev_year_f_230", "ev_year_f_350", "ev_year_f_220", "ev_year_t", "ev_year_t_top5", "ev_year_t_top5_percent", "ev_year_t_250", "ev_year_t_240", "ev_year_t_230", "ev_year_t_350", "ev_year_t_220")]
write.table(fatalitytop5counts, file = "exports/fatalitytop5-counts.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
