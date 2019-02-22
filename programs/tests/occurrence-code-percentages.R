# Use code_df_sort to compute each code's share of accidents (total, fatal) and fatalities,
# as well as each code's fatalities per accident measure.
# Output: occurrence_code_percentages.csv for Table 2
code_l <- length(seq(100,430,by=10))
colnames <- c("code", "percent_fat", "percent_f", "percent_t", "fat_per_accident")

code_percentages_df <- data.frame(matrix(NA, ncol=5, nrow=code_l))
names(code_percentages_df) <- colnames

fat_count <- sum(code_df_sort$ev_year_fat)
t_count <- sum(code_df_sort$ev_year_t)
f_count <- sum(code_df_sort$ev_year_f)

j <- 1
code_count_t_sum <- 0
code_count_f_sum <- 0
code_count_fat_sum <- 0

for (i in seq(100,430,by=10)) {
    code_percentages_df$code[j] <- i

    id_fat <- paste("ev_year_fat_", i, sep="")
    code_count_fat <- sum(code_df_sort[,id_fat])

    code_percentages_df$percent_fat[j] <- (code_count_fat/fat_count)*100

    id_f <- paste("ev_year_f_", i, sep="")
    code_count_f <- sum(code_df_sort[,id_f])

    code_count_f_sum <- code_count_f_sum + code_count_f

    code_percentages_df$percent_f[j] <- (code_count_f/f_count)*100

    id_t <- paste("ev_year_t_", i, sep="")
    code_count_t <- sum(code_df_sort[,id_t])

    code_count_t_sum <- code_count_t_sum + code_count_t

    code_percentages_df$percent_t[j] <- (code_count_t/t_count)*100

    code_percentages_df$fat_per_accident[j] <- code_count_fat/code_count_t

    j <- j + 1
}

code_percentages_df_sort <- code_percentages_df[order(code_percentages_df$percent_fat, decreasing=TRUE),]

write.table(code_percentages_df_sort, file = "exports/occurrence_code_percentages.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "utf8")
