# This file creates dataframes used across tests
# Output: count_df_sort, count_df_sort_reg, code_df_sort, and code_df_sort_reg data frames
## Generally, these data frames present the number of annual accidents (fatal and nonfatal) and fatalities overall, as well as by occurrence code. 
## They also include four measures of general aviation activity to compute accident and fatality rates
## Specifically,
##   * `count` dataframes include all years 1983 to 2015
##   * `code` dataframes cut off at end of 2007. Accident and fatality counts are only accurate at the occurrence code level between 1983 and 2007 due to NTSB methodology changes.
##   * `_reg` dataframes drop 1983 totals to avoid errors with certain tests, like computing correlations on annual changes
## With these annual counts and rates, various computations are made to produce new columns required for tests

years <- unique(factor(acc_countdata$ev_year))
years_l <-length(years)
code_l <- length(seq(100,430,by=10))
rows <- years_l
cols <- code_l * 4 + 9

colnames <- c("ev_year", "ev_year_fat", "ev_year_t", "ev_year_f", "ev_year_fat_per_accident", "pilots_10k", "private_pilots_10k", "avgas_10k", "flighthours_100k")

j <- 10

for (i in seq(100,430,by=10)) {
    colnames[j] <- paste("ev_year_fat_", i, sep="")
    j <- j + 1

    colnames[j] <- paste("ev_year_t_", i, sep="")
    j <- j + 1

    colnames[j] <- paste("ev_year_f_", i, sep="")
    j <- j + 1

    colnames[j] <- paste("ev_year_fat_", i, "_per_accident", sep="")
    j <- j + 1
}

count_df <- data.frame(matrix(NA, ncol=cols, nrow=years_l))
names(count_df) <- colnames

j <- 1

occcodes <- c("100", "110", "120", "130", "131", "132", "140", "150", "160", "170", "171", "172", "180", "190", "191", "192", "193", "194", "195", "196", "197", "198", "200", "210", "220", "230", "231", "232", "240", "250", "260", "270", "271", "280", "290", "300", "310", "320", "330", "340", "350", "351", "352", "353", "354", "355", "360", "370", "380", "390", "400", "410", "420", "430")
occcodes <- as.integer(occcodes)

# populate event total columns
for (year in years) {
    count_df$ev_year[j] <- year
    count_df$ev_year_fat[j] <- sum(acc_countdata$inj_tot_f[which(acc_countdata$ev_year == year & acc_countdata$aircraft_key == 1)])
    count_df$ev_year_t[j] <- length(which(acc_countdata$ev_year == year & acc_countdata$aircraft_key == 1))
    count_df$ev_year_f[j] <- length(which(acc_countdata$ev_year == year & acc_countdata$aircraft_key == 1 & acc_countdata$inj_tot_f > 0))
    count_df$ev_year_fat_per_accident[j] <- count_df$ev_year_fat[j]/count_df$ev_year_t[j]

    for(i in seq(100,430,by=10)) {
        id_fat <- paste("ev_year_fat_", i, sep="")
        id_t <- paste("ev_year_t_", i, sep="")
        id_f <- paste("ev_year_f_", i, sep="")
        id_fat_per_t <- paste("ev_year_fat_", i, "_per_accident", sep="")
        occ_code_s <- i
        occ_code_e <- occ_code_s + 9
        codes <- occcodes[occcodes >= occ_code_s & occcodes <= occ_code_e]

        lfat <- 0
        lf <- 0
        lt <- 0

        for (code in codes) {
            lfat <- lfat + sum(acc_countdata$inj_tot_f[which(grepl(code, acc_countdata$ev_occ_codes) & acc_countdata$ev_year == year & acc_countdata$aircraft_key == 1)])
            lf <- lf + length(which(grepl(code, acc_countdata$ev_occ_codes) & acc_countdata$ev_year == year & acc_countdata$aircraft_key == 1 & acc_countdata$inj_tot_f > 0))
            lt <- lt + length(which(grepl(code, acc_countdata$ev_occ_codes) & acc_countdata$ev_year == year & acc_countdata$aircraft_key == 1))
        }

        count_df[,id_fat][j] <- lfat
        count_df[,id_f][j] <- lf
        count_df[,id_t][j] <- lt
        count_df[,id_fat_per_t][j] <- lfat/lt
    }

    j <- j + 1
}

count_df_sort <- count_df[order(count_df$ev_year,decreasing=FALSE),]

# populate activity estimate columns
count_df_sort$pilots_10k <- c("718004", "722376", "709540", "709118", "699653", "694016", "700010", "702659", "692095", "682959", "665069", "654088", "638879", "622261", "616342", "618298", "635472", "625581", "612274", "631762", "625011", "618633", "609737", "597109", "590349", "613746", "594285", "627588", "617128", "610576", "599086", "593499", "590039", "584362")
count_df_sort$pilots_10k <- as.integer(count_df_sort$pilots_10k)/10000

count_df_sort$private_pilots_10k <- c("318643", "320086", "311086", "305736", "300949", "299786", "293179", "299111", "293306", "288078", "283700", "284236", "261399", "254002", "247604", "247226", "258749", "251561", "243823", "245230", "241045", "235994", "228619", "219233", "211096", "222596", "211619", "202020", "194441", "188001", "180214", "174883", "170718", "162313")
count_df_sort$private_pilots_10k <- as.integer(count_df_sort$private_pilots)/10000

count_df_sort$avgas_10k <- c("944.4", "869.2", "996.9", "1167.3", "904.1", "970.5", "942.7", "891.0", "826.5", "813.3", "760.6", "755.5", "784.1", "740.0", "786.4", "703.2", "776.0", "718.8", "692.1", "668.2", "598.7", "618.9", "700.6", "662.6", "625.8", "560.3", "526.1", "535.8", "536.0", "497.5", "442.9", "429.8", "418.8", "405.4")
count_df_sort$avgas_10k <- as.numeric(count_df_sort$avgas_10k)

count_df_sort$flighthours_100k <- c("286.7", "291.0", "283.2", "270.7", "269.7", "274.5", "279.2", "285.1", "276.8", "237.2", "229.1", "225.5", "250.8", "250.8", "256.0", "255.2", "289.4", "275.2", "251.2", "252.1", "256.0", "248.9", "231.7", "239.6", "238.2", "228.1", "208.6", "216.9", "213.0", "208.8", "194.9", "196.2", "205.8", "213.3")
count_df_sort$flighthours_100k <- as.numeric(count_df_sort$flighthours_100k)

# compute fatality rate values
count_df_sort$ev_year_fat_per_private10k <- count_df_sort$ev_year_fat/count_df_sort$private_pilots_10k
count_df_sort$ev_year_fat_per_avgas10k <- count_df_sort$ev_year_fat/count_df_sort$avgas_10k
count_df_sort$ev_year_fat_per_hours100k <- count_df_sort$ev_year_fat/count_df_sort$flighthours_100k
count_df_sort$ev_year_fat_per_pilots10k <- count_df_sort$ev_year_fat/count_df_sort$pilots_10k

# compute lag and diff variables
count_df_sort$ev_year_fat_lag <- lag(count_df_sort$ev_year_fat, 1)
count_df_sort$ev_year_fat_diff[2:rows] <- diff(count_df_sort$ev_year_fat, lags=1, differences=1)
count_df_sort$ev_year_fat_per_private10k_diff[2:rows] <- diff(count_df_sort$ev_year_fat_per_private10k, lags=1, differences=1)
count_df_sort$ev_year_fat_per_avgas10k_diff[2:rows] <- diff(count_df_sort$ev_year_fat_per_avgas10k, lags=1, differences=1)
count_df_sort$ev_year_fat_per_hours100k_diff[2:rows] <- diff(count_df_sort$ev_year_fat_per_hours100k, lags=1, differences=1)
count_df_sort$ev_year_fat_per_pilots10k_diff[2:rows] <- diff(count_df_sort$ev_year_fat_per_pilots10k, lags=1, differences=1)
count_df_sort$ev_year_f_lag <- lag(count_df_sort$ev_year_f, 1)
count_df_sort$ev_year_f_diff[2:rows] <- diff(count_df_sort$ev_year_f, lags=1, differences=1)
count_df_sort$ev_year_t_lag <- lag(count_df_sort$ev_year_t, 1)
count_df_sort$ev_year_t_diff[2:rows] <- diff(count_df_sort$ev_year_t, lags=1, differences=1)
count_df_sort$private_pilots_10k_lag <- lag(count_df_sort$private_pilots_10k, 1)
count_df_sort$private_pilots_10k_diff[2:rows] <- diff(count_df_sort$private_pilots_10k, lags=1, differences=1)
count_df_sort$pilots_10k_lag <- lag(count_df_sort$pilots_10k, 1)
count_df_sort$pilots_10k_diff[2:rows] <- diff(count_df_sort$pilots_10k, lags=1, differences=1)
count_df_sort$avgas_10k_lag <- lag(count_df_sort$avgas_10k, 1)
count_df_sort$avgas_10k_diff[2:rows] <- diff(count_df_sort$avgas_10k, lags=1, differences=1)
count_df_sort$flighthours_100k_lag <- lag(count_df_sort$flighthours_100k, 1)
count_df_sort$flighthours_100k_diff[2:rows] <- diff(count_df_sort$flighthours_100k, lags=1, differences=1)

for(i in seq(100,430,by=10)) {
    id_lag <- paste("ev_year_fat_",i,"_lag",sep="")
    id_diff <- paste("ev_year_fat_",i,"_diff",sep="")
    id_ncode <- paste("ev_year_fat_n",i,sep="")
    id_ncode_lag <- paste("ev_year_fat_n",i,"_lag",sep="")
    id_private <- paste("ev_year_fat_",i,"_per_private10k",sep="")
    id_private_diff <- paste("ev_year_fat_",i,"_per_private10k_diff",sep="")
    id_avgas <- paste("ev_year_fat_",i,"_per_avgas10k",sep="")
    id_avgas_diff <- paste("ev_year_fat_",i,"_per_avgas10k_diff",sep="")
    id_hours <- paste("ev_year_fat_",i,"_per_hours100k",sep="")
    id_hours_diff <- paste("ev_year_fat_",i,"_per_hours100k_diff",sep="")
    id_pilots <- paste("ev_year_fat_",i,"_per_pilots10k",sep="")
    id_pilots_diff <- paste("ev_year_fat_",i,"_per_pilots10k_diff",sep="")
    field <- paste("ev_year_fat_",i,sep="")

    count_df_sort[,id_lag] <- NA
    count_df_sort[,id_lag] <- lag(count_df_sort[,field], 1)

    count_df_sort[,id_ncode] <- count_df_sort$ev_year_fat - count_df_sort[,field]
    count_df_sort[,id_ncode_lag] <- lag(count_df_sort[,id_ncode], 1)

    count_df_sort[,id_diff] <- NA
    count_df_sort[,id_diff][2:rows] <- diff(count_df_sort[,field], lags=1, differences=1)

    count_df_sort[,id_private] <- count_df_sort[,field]/count_df_sort$private_pilots_10k
    count_df_sort[,id_private_diff] <- NA
    count_df_sort[,id_private_diff][2:rows] <- diff(count_df_sort[,id_private], lags=1, differences=1)

    count_df_sort[,id_avgas] <- count_df_sort[,field]/count_df_sort$avgas_10k
    count_df_sort[,id_avgas_diff] <- NA
    count_df_sort[,id_avgas_diff][2:rows] <- diff(count_df_sort[,id_avgas], lags=1, differences=1)

    count_df_sort[,id_hours] <- count_df_sort[,field]/count_df_sort$flighthours_100k
    count_df_sort[,id_hours_diff] <- NA
    count_df_sort[,id_hours_diff][2:rows] <- diff(count_df_sort[,id_hours], lags=1, differences=1)

    count_df_sort[,id_pilots] <- count_df_sort[,field]/count_df_sort$pilots_10k
    count_df_sort[,id_pilots_diff] <- NA
    count_df_sort[,id_pilots_diff][2:rows] <- diff(count_df_sort[,id_pilots], lags=1, differences=1)
}

# Create subset from 1983-2007 for occurrence code analysis
code_df_sort <- subset(count_df_sort, ev_year <= "2007")

# Drop 1983 rows to work with lag variables (because we cannot compute changes between 1982 and 1983)
count_df_sort_reg <- count_df_sort[-c(1),]
code_df_sort_reg <- code_df_sort[-c(1),]
