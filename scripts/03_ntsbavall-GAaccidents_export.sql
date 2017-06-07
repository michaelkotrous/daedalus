SELECT 'Clean data to correct for coding errors and generate variables for analysis';
-- NTSB does not enter zeroes for event total fatalities and total injuries,
-- but variable `ev_highest_injury` lets us distinguish which events actually
-- had zero injuries or zero fatalities, and which are actually NULL. 
UPDATE `aircraft` SET `inj_tot_f` = 0 WHERE `ev_highest_injury` IS NOT NULL AND `inj_tot_f` IS NULL
UPDATE `aircraft` SET `inj_tot_t` = 0 WHERE `ev_highest_injury` = 'NONE'

-- Create binary variable indicating if pilot has airplane instrument rating, or not.
ALTER TABLE `aircraft` ADD COLUMN `pilot_rat_instrum_apln` TINYINT DEFAULT NULL AFTER `pilot_rat_instrum`
UPDATE `aircraft` SET `pilot_rat_instrum_apln` = 1 WHERE INSTR(`pilot_rat_instrum`, 'APLN') > 0
UPDATE `aircraft` SET `pilot_rat_instrum_apln` = 0 WHERE INSTR(`pilot_rat_instrum`, 'APLN') = 0 OR INSTR(`pilot_rat_instrum`, 'NONE') > 0
-- Some entries are miscoded, listing "NONE" rating with another rating, which is not possible
-- We will set these entries to NULL, lest they muddy up our analysis
UPDATE `aircraft` SET `pilot_rat_instrum_apln` = NULL WHERE INSTR(`pilot_rat_instrum`, ',NONE') > 0 OR INSTR(`pilot_rat_instrum`, 'NONE,') > 0

-- Record if pilot is rated for single-engine, multi-engine, both, or no airplanes 
ALTER TABLE `aircraft` ADD COLUMN `pilot_rat_airpln_engine` CHAR(4) DEFAULT NULL AFTER `pilot_rat_airpln`
UPDATE `aircraft` SET `pilot_rat_airpln_engine` = "SENG" WHERE INSTR(`pilot_rat_airpln`, 'SEL') > 0 OR INSTR(`pilot_rat_airpln`, 'SES') > 0
UPDATE `aircraft` SET `pilot_rat_airpln_engine` = "MENG" WHERE INSTR(`pilot_rat_airpln`, 'MEL') > 0 OR INSTR(`pilot_rat_airpln`, 'MES') > 0
UPDATE `aircraft` SET `pilot_rat_airpln_engine` = "BOTH" WHERE (INSTR(`pilot_rat_airpln`, 'SEL') > 0 OR INSTR(`pilot_rat_airpln`, 'SES') > 0) AND (INSTR(`pilot_rat_airpln`, 'MEL') > 0 OR INSTR(`pilot_rat_airpln`, 'MES') > 0)
UPDATE `aircraft` SET `pilot_rat_airpln_engine` = "NONE" WHERE (INSTR(`pilot_rat_airpln`, 'SEL') = 0 AND INSTR(`pilot_rat_airpln`, 'SES') = 0 AND INSTR(`pilot_rat_airpln`, 'MEL') = 0 AND INSTR(`pilot_rat_airpln`, 'MES') = 0) OR INSTR(`pilot_rat_instrum`, 'NONE') > 0
-- Some entries are miscoded, listing "NONE" rating with another rating, which is not possible
-- We will set these entries to NULL, lest they muddy up our analysis
UPDATE `aircraft` SET `pilot_rat_airpln_engine` = NULL WHERE INSTR(`pilot_rat_airpln`, ',NONE') > 0 OR INSTR(`pilot_rat_airpln`, 'NONE,') > 0


SELECT 'Select final aircraft data for GA accidents';
DROP VIEW IF EXISTS `aircraft_ga_accidents`;
CREATE VIEW aircraft_ga_accidents as (
  SELECT
    `aircraft_id`,
    `far_part`,
    `damage`,
    `acft_fire`,
    `acft_expl`,
    `acft_make`,
    `acft_model`,
    `acft_category`,
    `acft_reg_cls`,
    `homebuilt`,
    `num_eng`,
    `fixed_retractable`,
    `type_last_insp`,
    `date_last_insp`,
    `afm_hrs_last_insp`,
    `afm_hrs`,
    `afm_hrs_since`,
    `type_fly`,
    `ev_id`,
    `ev_type`,
    `ev_dow`,
    `ev_date`,
    `ev_time`,
    `ev_tmzn`,
    `ev_state`,
    `ev_country`,
    `ev_highest_injury`,
    `inj_tot_f`,
    `inj_tot_t`,
    `light_cond`,
    `sky_cond_nonceil`,
    `sky_cond_ceil`,
    `vis_sm`,
    `wind_vel_kts`,
    `wind_vel_ind`,
    `wx_int_precip`,
    `wx_cond_basic`,
    `wx_cond`,
    `pilot_id`,
    `pilot_age`,
    `pilot_sex`,
    `pilot_med_certf`,
    `pilot_med_crtf_vldty`,
    `pilot_date_lst_med`,
    `pilot_seatbelts_used`,
    `pilot_inj_level`,
    `pilot_bfr`,
    `pilot_bfr_date`,
    `pilot_cert_code`,
    `pilot_rat_airpln`,
    `pilot_rat_airpln_engine`,
    `pilot_rat_instrum`,
    `pilot_rat_instrum_apln`,
    `pilot_flight_hours_l90d_all`,
    `pilot_flight_hours_pic_all`,
    `pilot_flight_hours_totl_all`,
    `pilot_flight_hours_l90d_make`,
    `pilot_flight_hours_pic_make`,
    `pilot_flight_hours_totl_make`,
    `occurrence_no`,
    `occurrence_code`,
    `phase_of_flight`,
    `seq_event_no`,
    `group_code`,
    `subj_code`,
    `cause_factor`,
    `modifier_code`,
    `person_code`
  FROM `aircraft`
  WHERE `far_part` = '091' AND `ev_type` = 'ACC' AND `ev_country` = 'USA' AND `acft_category` = 'AIR' AND (`fixed_retractable` = 'FIXD' OR `fixed_retractable` IS NULL) AND `commercial_space_flight` = 0 AND `unmanned` = 0
);

SELECT 'Export aircraft data for GA accidents to csv';
SELECT * FROM `aircraft_ga_accidents` 
INTO OUTFILE '/tmp/aircraft-GAaccidents.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\n';
