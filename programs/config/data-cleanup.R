# Output: acc_countdata and occdata subsets for analysis

# Format variables
accidentdata$ev_date <- as.Date(accidentdata$ev_date)
accidentdata$ev_month <- substr(accidentdata$ev_date,0,7)
accidentdata$ev_year <- substr(accidentdata$ev_date,0,4)
accidentdata$ev_time <- times(accidentdata$ev_time)
accidentdata$date_last_insp <- as.Date(accidentdata$date_last_insp)
accidentdata$pilot_date_lst_med <- as.Date(accidentdata$pilot_date_lst_med)
accidentdata$pilot_bfr_date <- as.Date(accidentdata$pilot_bfr_date)

# Generate variables to help with analysis
## Fatal/Nonfatal Accident binary
accidentdata$fatal_bin <- "N"
accidentdata$fatal_bin[accidentdata$inj_tot_f > 0] <- "Y"

## Classify pilots into age categories
## Refer to Bazargan and Guzhva, 2011, Accident Analysis and Prevention
accidentdata$pilot_age_cat <- NA
accidentdata$pilot_age_cat[accidentdata$pilot_age < 20] <- 1
accidentdata$pilot_age_cat[accidentdata$pilot_age >= 20 & accidentdata$pilot_age <= 29] <- 2
accidentdata$pilot_age_cat[accidentdata$pilot_age >= 30 & accidentdata$pilot_age <= 39] <- 3
accidentdata$pilot_age_cat[accidentdata$pilot_age >= 40 & accidentdata$pilot_age <= 49] <- 4
accidentdata$pilot_age_cat[accidentdata$pilot_age >= 50 & accidentdata$pilot_age <= 59] <- 5
accidentdata$pilot_age_cat[accidentdata$pilot_age >= 60] <- 6

accidentdata$pilot_age_cat_str <- factor(accidentdata$pilot_age_cat)

## Classify pilots by experience categories for flight hours with same make of aircraft
## Refer to Bazargan and Guzhva, 2011, Accident Analysis and Prevention
accidentdata$pilot_exp_cat_make <- NA
accidentdata$pilot_exp_cat_make[accidentdata$pilot_flight_hours_totl_make < 100] <- 1
accidentdata$pilot_exp_cat_make[accidentdata$pilot_flight_hours_totl_make >= 100 & accidentdata$pilot_flight_hours_totl_make <= 300] <- 2
accidentdata$pilot_exp_cat_make[accidentdata$pilot_flight_hours_totl_make > 300 & accidentdata$pilot_flight_hours_totl_make <= 2000] <- 3
accidentdata$pilot_exp_cat_make[accidentdata$pilot_flight_hours_totl_make > 2000 & accidentdata$pilot_flight_hours_totl_make <= 5000] <- 4
accidentdata$pilot_exp_cat_make[accidentdata$pilot_flight_hours_totl_make > 5000] <- 5

accidentdata$pilot_exp_cat_make_str <- factor(accidentdata$pilot_exp_cat_make)

## Classify pilots by experience categories for total flight hours
## Refer to Bazargan and Guzhva, 2011, Accident Analysis and Prevention
accidentdata$pilot_exp_cat_total <- NA
accidentdata$pilot_exp_cat_total[accidentdata$pilot_flight_hours_totl_all < 100] <- 1
accidentdata$pilot_exp_cat_total[accidentdata$pilot_flight_hours_totl_all >= 100 & accidentdata$pilot_flight_hours_totl_all <= 300] <- 2
accidentdata$pilot_exp_cat_total[accidentdata$pilot_flight_hours_totl_all > 300 & accidentdata$pilot_flight_hours_totl_all <= 2000] <- 3
accidentdata$pilot_exp_cat_total[accidentdata$pilot_flight_hours_totl_all > 2000 & accidentdata$pilot_flight_hours_totl_all <= 5000] <- 4
accidentdata$pilot_exp_cat_total[accidentdata$pilot_flight_hours_totl_all > 5000] <- 5

accidentdata$pilot_exp_cat_total_str <- factor(accidentdata$pilot_exp_cat_total)

## Flight Phase Groupings
accidentdata$flight_phase_no <- NA
accidentdata$flight_phase_str <- NA

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "500"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "501"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "502"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "503"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "504"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "505"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "510"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "511"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "512"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "513"] <- 1
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "514"] <- 1
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "500"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "501"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "502"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "503"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "504"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "505"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "510"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "511"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "512"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "513"] <- "Standing/Taxi"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "514"] <- "Standing/Taxi"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "520"] <- 2
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "521"] <- 2
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "522"] <- 2
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "523"] <- 2
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "520"] <- "Takeoff"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "521"] <- "Takeoff"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "522"] <- "Takeoff"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "523"] <- "Takeoff"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "530"] <- 3
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "531"] <- 3
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "530"] <- "Climb"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "531"] <- "Climb"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "540"] <- 4
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "541"] <- 4
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "540"] <- "Cruise"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "541"] <- "Cruise"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "550"] <- 5
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "551"] <- 5
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "552"] <- 5
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "553"] <- 5
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "550"] <- "Descent"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "551"] <- "Descent"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "552"] <- "Descent"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "553"] <- "Descent"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "580"] <- 6
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "581"] <- 6
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "582"] <- 6
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "583"] <- 6
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "542"] <- 6
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "580"] <- "Maneuvering"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "581"] <- "Maneuvering"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "582"] <- "Maneuvering"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "583"] <- "Maneuvering"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "542"] <- "Maneuvering"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "560"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "561"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "562"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "563"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "564"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "566"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "567"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "568"] <- 7
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "569"] <- 7
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "560"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "561"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "562"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "563"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "564"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "566"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "567"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "568"] <- "Approach"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "569"] <- "Approach"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "565"] <- 8
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "565"] <- "Go-Around"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "570"] <- 9
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "571"] <- 9
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "572"] <- 9
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "573"] <- 9
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "570"] <- "Landing"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "571"] <- "Landing"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "572"] <- "Landing"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "573"] <- "Landing"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "574"] <- 10
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "575"] <- 10
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "576"] <- 10
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "574"] <- "Emergency Landing"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "575"] <- "Emergency Landing"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "576"] <- "Emergency Landing"

accidentdata$flight_phase_no[accidentdata$phase_of_flight == "600"] <- 11
accidentdata$flight_phase_no[accidentdata$phase_of_flight == "610"] <- 11
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "600"] <- "Other/Unknown"
accidentdata$flight_phase_str[accidentdata$phase_of_flight == "610"] <- "Other/Unknown"

accidentdata$flight_phase_name <- factor(accidentdata$flight_phase_str)

# Define subsets of dataset used to produce my graphics, tables, and empirical tests
# Note: occdata includes only U.S. registered aircraft and accidents that have entries for occurrence code and number of fatalities, which are well populated through end of 2007
acc_countdata <- subset(accidentdata, !is.na(inj_tot_f))
acc_countdata$ev_id <- factor(acc_countdata$ev_id)

# create data frame of acc_countdata event ids by their aircraft keys
aircraft_keys <- as.data.frame.matrix(table(acc_countdata$ev_id,acc_countdata$aircraft_key))
names(aircraft_keys)[1] <- "aircraft1"
names(aircraft_keys)[2] <- "aircraft2"
names(aircraft_keys)[3] <- "aircraft3"
aircraft_keys$ev_id <- row.names(aircraft_keys)
aircraft_keys <- aircraft_keys[c("ev_id", "aircraft1", "aircraft2", "aircraft3")]

# correct errors in aircraft keys by filtering data to Part 91 airplanes
aircraft_keys$error1 <- 0
aircraft_keys$error1[aircraft_keys$aircraft1 == 0 & aircraft_keys$aircraft2 == 1 & aircraft_keys$aircraft3 == 0] <- 1

aircraft_keys$error2 <- 0
aircraft_keys$error2[aircraft_keys$aircraft1 == 0 & aircraft_keys$aircraft2 == 1 & aircraft_keys$aircraft3 == 1] <- 1
aircraft_keys$error2[aircraft_keys$aircraft1 == 0 & aircraft_keys$aircraft2 == 0 & aircraft_keys$aircraft3 == 1] <- 1

aircraft_keys$error3 <- 0
aircraft_keys$error3[aircraft_keys$aircraft1 == 1 & aircraft_keys$aircraft2 == 0 & aircraft_keys$aircraft3 == 1] <- 1

aircraft_key_acc_errors <- subset(aircraft_keys, error1 == 1 | error2 == 1 | error3 == 1)
aircraft_key_acc_errors$ev_id <- factor(aircraft_key_acc_errors$ev_id)

error1_ids <- aircraft_key_acc_errors$ev_id[aircraft_key_acc_errors$error1 == 1]
error2_ids <- aircraft_key_acc_errors$ev_id[aircraft_key_acc_errors$error2 == 1]
error3_ids <- aircraft_key_acc_errors$ev_id[aircraft_key_acc_errors$error3 == 1]

for(id in error1_ids) {
    acc_countdata$aircraft_key[acc_countdata$aircraft_key == 2 & acc_countdata$ev_id == id] <- 1
}

for(id in error2_ids) {
    acc_countdata$aircraft_key[acc_countdata$aircraft_key == 3 & acc_countdata$ev_id == id] <- 1
}

for(id in error3_ids) {
    acc_countdata$aircraft_key[acc_countdata$aircraft_key == 3 & acc_countdata$ev_id == id] <- 2
}

occdata <- subset(acc_countdata, !is.na(occurrence_code) & ev_year <= "2007")
occdata$ev_id <- factor(occdata$ev_id)

# clean up aircraft_key errors created by removing accident aircraft with NULL occurrence codes
aircraft_keys <- as.data.frame.matrix(table(occdata$ev_id,occdata$aircraft_key))
names(aircraft_keys)[1] <- "aircraft1"
names(aircraft_keys)[2] <- "aircraft2"
names(aircraft_keys)[3] <- "aircraft3"
aircraft_keys$ev_id <- row.names(aircraft_keys)
aircraft_keys <- aircraft_keys[c("ev_id", "aircraft1", "aircraft2", "aircraft3")]

# denote classes of errors in aircraft keys that will need to be fixed
aircraft_keys$error1 <- 0
aircraft_keys$error1[aircraft_keys$aircraft1 == 0 & aircraft_keys$aircraft2 == 1 & aircraft_keys$aircraft3 == 0] <- 1

aircraft_keys$error2 <- 0
aircraft_keys$error2[aircraft_keys$aircraft1 == 0 & aircraft_keys$aircraft2 == 1 & aircraft_keys$aircraft3 == 1] <- 1
aircraft_keys$error2[aircraft_keys$aircraft1 == 0 & aircraft_keys$aircraft2 == 0 & aircraft_keys$aircraft3 == 1] <- 1

aircraft_keys$error3 <- 0
aircraft_keys$error3[aircraft_keys$aircraft1 == 1 & aircraft_keys$aircraft2 == 0 & aircraft_keys$aircraft3 == 1] <- 1

aircraft_key_acc_errors <- subset(aircraft_keys, error1 == 1 | error2 == 1 | error3 == 1)
aircraft_key_acc_errors$ev_id <- factor(aircraft_key_acc_errors$ev_id)

error1_ids <- aircraft_key_acc_errors$ev_id[aircraft_key_acc_errors$error1 == 1]
error2_ids <- aircraft_key_acc_errors$ev_id[aircraft_key_acc_errors$error2 == 1]
error3_ids <- aircraft_key_acc_errors$ev_id[aircraft_key_acc_errors$error3 == 1]

for(id in error1_ids) {
    occdata$aircraft_key[occdata$aircraft_key == 2 & occdata$ev_id == id] <- 1
}

for(id in error2_ids) {
    occdata$aircraft_key[occdata$aircraft_key == 3 & occdata$ev_id == id] <- 1
}

for(id in error3_ids) {
    occdata$aircraft_key[occdata$aircraft_key == 3 & occdata$ev_id == id] <- 2
}
