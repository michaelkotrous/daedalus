# Create directory to place chisquare test output
dir.create("exports/chisquare", showWarnings = FALSE)

# Run Chi-square tests to see if airplanes in PLOC, Encounter with Weather, and in-flight collision accidents 
# significantly fly more often in IMC or at night than airplanes in accidents attributed to other occurrences.
## Number of PLOC, Encounter with Weather, or Inflight collision with terrain, water, or object accidents in VMC
codes_vmc <- length(which((occdata$occurrence_code >= 220 & occdata$occurrence_code <= 259) & occdata$wx_cond_basic == "VMC"))
## Number of other accidents in VMC
other_vmc <- length(which((occdata$occurrence_code < 220 | occdata$occurrence_code > 259) & occdata$wx_cond_basic == "VMC"))
# Number of PLOC, Encounter with Weather, or Inflight collision with terrain, water, or object accidents in IMC
codes_imc <- length(which((occdata$occurrence_code >= 220 & occdata$occurrence_code <= 259) & occdata$wx_cond_basic == "IMC"))
## Number of other accidents in IMC
other_imc <- length(which((occdata$occurrence_code < 220 | occdata$occurrence_code > 259) & occdata$wx_cond_basic == "IMC"))

wx_cond_chi2 <- matrix(c(codes_vmc, codes_imc, other_vmc, other_imc), ncol=2, nrow=2, byrow=TRUE)
colnames(wx_cond_chi2) <- c("VMC", "IMC")
rownames(wx_cond_chi2) <- c("220,230,240,250", "Other")

chisq <- chisq.test(wx_cond_chi2)

wx_cond_chi2_out <- matrix(as.numeric(c(wx_cond_chi2, chisq$statistic, "", chisq$p.value, "", chisq$parameter, "")), ncol=5, nrow=2, byrow=FALSE)
colnames(wx_cond_chi2_out) <- c("VMC", "IMC", "Chi square", "P-value", "d.f.")
rownames(wx_cond_chi2_out) <- c("220,230,240,250", "Other")
write.csv(wx_cond_chi2_out, file = "exports/chisquare/wx_cond_chi2_out.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

## Number of PLOC, Encounter with Weather, or Inflight collision with terrain, water, or object accidents in VMC
codes_day <- length(which((occdata$occurrence_code >= 220 & occdata$occurrence_code <= 259) & (occdata$light_cond == "DAWN" | occdata$light_cond == "DAYL" | occdata$light_cond == "DUSK")))
## Number of other accidents in VMC
other_day <- length(which((occdata$occurrence_code < 220 | occdata$occurrence_code > 259) & (occdata$light_cond == "DAWN" | occdata$light_cond == "DAYL" | occdata$light_cond == "DUSK")))
## Number of PLOC, Encounter with Weather, or Inflight collision with terrain, water, or object accidents in IMC
codes_night <- length(which((occdata$occurrence_code >= 220 & occdata$occurrence_code <= 259) & (occdata$light_cond == "NBRT" | occdata$light_cond == "NITE" | occdata$light_cond == "NDRK")))
## Number of other accidents in IMC
other_night <- length(which((occdata$occurrence_code < 220 | occdata$occurrence_code > 259) & (occdata$light_cond == "NBRT" | occdata$light_cond == "NITE" | occdata$light_cond == "NDRK")))

light_cond_chi2 <- matrix(c(codes_day, codes_night, other_day, other_night), ncol=2, nrow=2, byrow=TRUE)
colnames(light_cond_chi2) <- c("Day", "Night")
rownames(light_cond_chi2) <- c("220,230,240,250", "Other")

chisq <- chisq.test(light_cond_chi2)

light_cond_chi2_out <- matrix(as.numeric(c(light_cond_chi2, chisq$statistic, "", chisq$p.value, "", chisq$parameter, "")), ncol=5, nrow=2, byrow=FALSE)
colnames(light_cond_chi2_out) <- c("Day", "Night", "Chi square", "P-value", "d.f.")
rownames(light_cond_chi2_out) <- c("220,230,240,250", "Other")
write.csv(light_cond_chi2_out, file = "exports/chisquare/light_cond_chi2_out.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

## Another chi2 test
instrum_240 <- length(which(occdata$occurrence_code == 240 & occdata$pilot_rat_instrum_apln == 1))
instrum_other <- length(which(occdata$occurrence_code != 240 & occdata$pilot_rat_instrum_apln == 1))
noinstrum_240 <- length(which(occdata$occurrence_code == 240 & occdata$pilot_rat_instrum_apln == 0))
noinstrum_other <- length(which(occdata$occurrence_code != 240 & occdata$pilot_rat_instrum_apln == 0))

instrum_240_chi2 <- matrix(c(instrum_240, noinstrum_240, instrum_other, noinstrum_other), ncol=2, nrow=2, byrow=TRUE)
colnames(instrum_240_chi2) <- c("Instrum APLN", "No")
rownames(instrum_240_chi2) <- c("240", "Other")

chisq <- chisq.test(instrum_240_chi2)

instrum_240_chi2_out <- matrix(as.numeric(c(instrum_240_chi2, chisq$statistic, "", chisq$p.value, "", chisq$parameter, "")), ncol=5, nrow=2, byrow=FALSE)
colnames(instrum_240_chi2_out) <- c("Instrum APLN", "No", "Chi square", "P-value", "d.f.")
rownames(instrum_240_chi2_out) <- c("240", "Other")
write.csv(instrum_240_chi2_out, file = "exports/chisquare/instrum_240_chi2_out.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

## Fatal/Nonfatal accident events by weather and light conditions
f_vmc <- length(which(occdata$wx_cond_basic == "VMC" & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1))
f_imc <- length(which(occdata$wx_cond_basic == "IMC" & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1))
nf_vmc <- length(which(occdata$wx_cond_basic == "VMC" & occdata$inj_tot_f == 0 & occdata$aircraft_key == 1))
nf_imc <- length(which(occdata$wx_cond_basic == "IMC" & occdata$inj_tot_f == 0 & occdata$aircraft_key == 1))

fatal_wx_chi2 <- matrix(c(f_vmc, f_imc, nf_vmc, nf_imc), ncol=2, nrow=2, byrow=TRUE)
colnames(fatal_wx_chi2) <- c("VMC", "IMC")
rownames(fatal_wx_chi2) <- c("Fatal", "Nonfatal")

chisq <- chisq.test(fatal_wx_chi2)

fatal_wx_chi2_out <- matrix(as.numeric(c(fatal_wx_chi2, chisq$statistic, "", chisq$p.value, "", chisq$parameter, "")), ncol=5, nrow=2, byrow=FALSE)
colnames(fatal_wx_chi2_out) <- c("VMC", "IMC", "Chi square", "P-value", "d.f.")
rownames(fatal_wx_chi2_out) <- c("Fatal", "Nonfatal")
write.csv(fatal_wx_chi2_out, file = "exports/chisquare/fatal_wx_chi2_out.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

## Another chi2 test description
f_day <- length(which((occdata$light_cond == "DAWN" | occdata$light_cond == "DAYL" | occdata$light_cond == "DUSK") & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1))
f_night <- length(which((occdata$light_cond == "NBRT" | occdata$light_cond == "NITE" | occdata$light_cond == "NDRK") & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1))
nf_day <- length(which((occdata$light_cond == "DAWN" | occdata$light_cond == "DAYL" | occdata$light_cond == "DUSK") & occdata$inj_tot_f == 0 & occdata$aircraft_key == 1))
nf_night <- length(which((occdata$light_cond == "NBRT" | occdata$light_cond == "NITE" | occdata$light_cond == "NDRK") & occdata$inj_tot_f == 0 & occdata$aircraft_key == 1))

fatal_light_chi2 <- matrix(c(f_day, f_night, nf_day, nf_night), ncol=2, nrow=2, byrow=TRUE)
colnames(fatal_light_chi2) <- c("Day", "Night")
rownames(fatal_light_chi2) <- c("Fatal", "Nonfatal")

chisq <- chisq.test(fatal_light_chi2) 

fatal_light_chi2_out <- matrix(as.numeric(c(fatal_light_chi2, chisq$statistic, "", chisq$p.value, "", chisq$parameter, "")), ncol=5, nrow=2, byrow=FALSE)
colnames(fatal_light_chi2_out) <- c("Day", "Night", "Chi square", "P-value", "d.f.")
rownames(fatal_light_chi2_out) <- c("Fatal", "Nonfatal")
fatal_light_chi2_out
write.csv(fatal_light_chi2_out, file = "exports/chisquare/fatal_light_chi2_out.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

# Write tables for analyis but not for chisquare tests
## Create Chisquare style table with 220, 230, and 250 accidents by weather conditions to separate in-flight weather encounters from other accident types
codes_vmc <- length(which((occdata$occurrence_code >= 220 & occdata$occurrence_code <= 259 & occdata$occurrence_code != 240) & occdata$wx_cond_basic == "VMC"))
## Number of other accidents in VMC
other_vmc <- length(which((occdata$occurrence_code < 220 | occdata$occurrence_code > 259 | occdata$occurrence_code == 240) & occdata$wx_cond_basic == "VMC"))
# Number of PLOC, Encounter with Weather, or Inflight collision with terrain, water, or object accidents in IMC
codes_imc <- length(which((occdata$occurrence_code >= 220 & occdata$occurrence_code <= 259 & occdata$occurrence_code != 240) & occdata$wx_cond_basic == "IMC"))
## Number of other accidents in IMC
other_imc <- length(which((occdata$occurrence_code < 220 | occdata$occurrence_code > 259 | occdata$occurrence_code == 240) & occdata$wx_cond_basic == "IMC"))

wx_cond_l240_chi2 <- matrix(c(codes_vmc, codes_imc, other_vmc, other_imc), ncol=2, nrow=2, byrow=TRUE)
colnames(wx_cond_l240_chi2) <- c("VMC", "IMC")
rownames(wx_cond_l240_chi2) <- c("220,230,250", "Other")

write.csv(wx_cond_l240_chi2, file = "exports/chisquare/wx_cond_l240_chi2.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

## Create Chisquare style table with 220, 230, and 250 accidents by weather conditions to separate in-flight weather encounters from other accident types
codes_vmc <- length(which(occdata$occurrence_code == 240 & occdata$wx_cond_basic == "VMC"))
## Number of other accidents in VMC
other_vmc <- length(which(occdata$occurrence_code != 240 & occdata$wx_cond_basic == "VMC"))
## Number of PLOC, Encounter with Weather, or Inflight collision with terrain, water, or object accidents in IMC
codes_imc <- length(which(occdata$occurrence_code == 240 & occdata$wx_cond_basic == "IMC"))
## Number of other accidents in IMC
other_imc <- length(which(occdata$occurrence_code != 240 & occdata$wx_cond_basic == "IMC"))

wx_cond_240_chi2 <- matrix(c(codes_vmc, codes_imc, other_vmc, other_imc), ncol=2, nrow=2, byrow=TRUE)
colnames(wx_cond_240_chi2) <- c("VMC", "IMC")
rownames(wx_cond_240_chi2) <- c("240", "Other")

write.csv(wx_cond_240_chi2, file = "exports/chisquare/wx_cond_240_chi2.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")

## Count fatalities by basic weather conditions and whether in-flight weather encounter or not
codes_fat_vmc <- sum(occdata$inj_tot_f[which(occdata$occurrence_code == 240 & occdata$wx_cond_basic == "VMC" & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1)])
other_fat_vmc <- sum(occdata$inj_tot_f[which(occdata$occurrence_code != 240 & occdata$wx_cond_basic == "VMC" & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1)])
codes_fat_imc <- sum(occdata$inj_tot_f[which(occdata$occurrence_code == 240 & occdata$wx_cond_basic == "IMC" & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1)])
other_fat_imc <- sum(occdata$inj_tot_f[which(occdata$occurrence_code != 240 & occdata$wx_cond_basic == "IMC" & occdata$inj_tot_f > 0 & occdata$aircraft_key == 1)])

wx_cond_240fat_chi2 <- matrix(c(codes_fat_vmc, codes_fat_imc, other_fat_vmc, other_fat_imc), ncol=2, nrow=2, byrow=TRUE)
colnames(wx_cond_240fat_chi2) <- c("VMC", "IMC")
rownames(wx_cond_240fat_chi2) <- c("240 fatalities", "Other Fatalities")

write.csv(wx_cond_240fat_chi2, file = "exports/chisquare/wx_cond_240fat_chi2.csv", quote = TRUE, eol = "\n", na = "", row.names = TRUE, fileEncoding = "utf8")
