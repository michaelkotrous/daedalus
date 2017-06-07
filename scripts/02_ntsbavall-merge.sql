SELECT 'Merging events table with detailed events data';
DROP VIEW IF EXISTS `dt_events_extended`;
CREATE VIEW dt_events_extended as (
  SELECT
    dt_events.*,
    case when col_name = "prop_dmg" then code end as prop_dmg,
    case when col_name = "vis_restrct" then code end as vis_restrct,
    case when col_name = "wx_brief_mthd" then code end as wx_brief_mthd,
    case when col_name = "wx_brief_src" then code end as wx_brief_src,
    case when col_name = "wx_cond" then code end as wx_cond
  FROM dt_events
);
DROP VIEW IF EXISTS `dt_events_pivoted`;
CREATE VIEW dt_events_pivoted as (
  SELECT
    ev_id,
    group_concat(prop_dmg) as prop_dmg,
    group_concat(vis_restrct) as vis_restrct,
    group_concat(wx_brief_mthd) as wx_brief_mthd,
    group_concat(wx_brief_src) as wx_brief_src,
    group_concat(wx_cond) as wx_cond
  from dt_events_extended
  group by ev_id
);

UPDATE `events`
INNER JOIN `dt_events_pivoted` ON events.ev_id = dt_events_pivoted.ev_id
SET
  events.prop_dmg = dt_events_pivoted.prop_dmg,
  events.vis_restrct = dt_events_pivoted.vis_restrct,
  events.wx_brief_mthd = dt_events_pivoted.wx_brief_mthd,
  events.wx_brief_src = dt_events_pivoted.wx_brief_src,
  events.wx_cond = dt_events_pivoted.wx_cond;


SELECT 'Merging flight crew table with detailed crew data';
DROP VIEW IF EXISTS `dt_flight_crew_extended`;
CREATE VIEW dt_flight_crew_extended as (
  SELECT
    dt_flight_crew.*,
    case when col_name = "crew_cert_code" then code end as crew_cert_code,
    case when col_name = "crew_rat_airpln" then code end as crew_rat_airpln,
    case when col_name = "crew_rat_instruct" then code end as crew_rat_instruct,
    case when col_name = "crew_rat_instrum" then code end as crew_rat_instrum,
    case when col_name = "crew_rat_roto" then code end as crew_rat_roto
  FROM dt_flight_crew
);
DROP VIEW IF EXISTS `dt_flight_crew_pivoted`;
CREATE VIEW dt_flight_crew_pivoted as (
  SELECT
    crew_id,
    group_concat(crew_cert_code) as crew_cert_code,
    group_concat(crew_rat_airpln) as crew_rat_airpln,
    group_concat(crew_rat_instruct) as crew_rat_instruct,
    group_concat(crew_rat_instrum) as crew_rat_instrum,
    group_concat(crew_rat_roto) as crew_rat_roto
  FROM dt_flight_crew_extended
  GROUP BY crew_id
);

UPDATE `flight_crew`
INNER JOIN `dt_flight_crew_pivoted` ON flight_crew.crew_id = dt_flight_crew_pivoted.crew_id
SET
  flight_crew.crew_cert_code = dt_flight_crew_pivoted.crew_cert_code,
  flight_crew.crew_rat_airpln = dt_flight_crew_pivoted.crew_rat_airpln,
  flight_crew.crew_rat_instruct = dt_flight_crew_pivoted.crew_rat_instruct,
  flight_crew.crew_rat_instrum = dt_flight_crew_pivoted.crew_rat_instrum,
  flight_crew.crew_rat_roto = dt_flight_crew_pivoted.crew_rat_roto;

SELECT 'Merging flight crew table with detailed flight hours data';
DROP VIEW IF EXISTS `flight_time_extended`;
CREATE VIEW flight_time_extended as (
  SELECT
    flight_time.*,
    case when flight_type = "L24H" and flight_craft = "ALL" then flight_hours end as flight_hours_l24h_all,
    case when flight_type = "L30D" and flight_craft = "ALL" then flight_hours end as flight_hours_l30d_all,
    case when flight_type = "L90D" and flight_craft = "ALL" then flight_hours end as flight_hours_l90d_all,
    case when flight_type = "PIC" and flight_craft = "ALL" then flight_hours end as flight_hours_pic_all,
    case when flight_type = "TOTL" and flight_craft = "ALL" then flight_hours end as flight_hours_totl_all,
    case when flight_type = "L24H" and flight_craft = "MAKE" then flight_hours end as flight_hours_l24h_make,
    case when flight_type = "L30D" and flight_craft = "MAKE" then flight_hours end as flight_hours_l30d_make,
    case when flight_type = "L90D" and flight_craft = "MAKE" then flight_hours end as flight_hours_l90d_make,
    case when flight_type = "PIC" and flight_craft = "MAKE" then flight_hours end as flight_hours_pic_make,
    case when flight_type = "TOTL" and flight_craft = "MAKE" then flight_hours end as flight_hours_totl_make
  FROM flight_time
);
DROP VIEW IF EXISTS `flight_time_pivoted`;
CREATE VIEW flight_time_pivoted as (
  SELECT
    crew_id,
    sum(flight_hours_l24h_all) as flight_hours_l24h_all,
    sum(flight_hours_l30d_all) as flight_hours_l30d_all,
    sum(flight_hours_l90d_all) as flight_hours_l90d_all,
    sum(flight_hours_pic_all) as flight_hours_pic_all,
    sum(flight_hours_totl_all) as flight_hours_totl_all,
    sum(flight_hours_l24h_make) as flight_hours_l24h_make,
    sum(flight_hours_l30d_make) as flight_hours_l30d_make,
    sum(flight_hours_l90d_make) as flight_hours_l90d_make,
    sum(flight_hours_pic_make) as flight_hours_pic_make,
    sum(flight_hours_totl_make) as flight_hours_totl_make
  FROM flight_time_extended
  GROUP BY crew_id
);

UPDATE `flight_crew`
INNER JOIN `flight_time_pivoted` ON flight_crew.crew_id = flight_time_pivoted.crew_id
SET
  flight_crew.flight_hours_l24h_all = flight_time_pivoted.flight_hours_l24h_all,
  flight_crew.flight_hours_l30d_all = flight_time_pivoted.flight_hours_l30d_all,
  flight_crew.flight_hours_l90d_all = flight_time_pivoted.flight_hours_l90d_all,
  flight_crew.flight_hours_pic_all = flight_time_pivoted.flight_hours_pic_all,
  flight_crew.flight_hours_totl_all = flight_time_pivoted.flight_hours_totl_all,
  flight_crew.flight_hours_l24h_make = flight_time_pivoted.flight_hours_l24h_make,
  flight_crew.flight_hours_l30d_make = flight_time_pivoted.flight_hours_l30d_make,
  flight_crew.flight_hours_l90d_make = flight_time_pivoted.flight_hours_l90d_make,
  flight_crew.flight_hours_pic_make = flight_time_pivoted.flight_hours_pic_make,
  flight_crew.flight_hours_totl_make = flight_time_pivoted.flight_hours_totl_make;

SELECT 'Merging occurrences table with sequence events identified as "cause of accident"';
DROP VIEW IF EXISTS `seq_of_events_cause`;
CREATE VIEW seq_of_events_cause as (
  SELECT * 
  FROM seq_of_events
  WHERE cause_factor = "C"
);

-- Occurrences are numbered in chronological order, 
-- so selecting minimum occurrence number corresponds 
-- with selecting earliest occurrence with identified 
-- "cause" in sequence.
DROP VIEW IF EXISTS `seq_of_events_collapsed`;
CREATE VIEW seq_of_events_collapsed as (
  SELECT
    min(occurrence_no) as occurrence_no,
    occurrence_id,
    group_concat(seq_event_no) as seq_event_no,
    group_concat(group_code) as group_code,
    group_concat(subj_code) as subj_code,
    group_concat(cause_factor) as cause_factor,
    group_concat(modifier_code) as modifier_code,
    group_concat(person_code) as person_code
  FROM seq_of_events_cause
  GROUP BY occurrence_id
);

UPDATE `occurrences`
INNER JOIN `seq_of_events_collapsed` ON occurrences.occurrence_id = seq_of_events_collapsed.occurrence_id
SET
  occurrences.seq_event_no = seq_of_events_collapsed.seq_event_no,
  occurrences.group_code = seq_of_events_collapsed.group_code,
  occurrences.subj_code = seq_of_events_collapsed.subj_code,
  occurrences.cause_factor = seq_of_events_collapsed.cause_factor,
  occurrences.modifier_code = seq_of_events_collapsed.modifier_code,
  occurrences.person_code = seq_of_events_collapsed.person_code;

SELECT 'Merging aircraft table with events data';
UPDATE `aircraft`
INNER JOIN `events` ON aircraft.ev_id = events.ev_id
SET
  aircraft.ev_type = events.ev_type,
  aircraft.ev_date = events.ev_date,
  aircraft.ev_dow = events.ev_dow,
  aircraft.ev_time = events.ev_time,
  aircraft.ev_tmzn = events.ev_tmzn,
  aircraft.ev_city = events.ev_city,
  aircraft.ev_state = events.ev_state,
  aircraft.ev_country = events.ev_country,
  aircraft.ev_site_zipcode = events.ev_site_zipcode,
  aircraft.ev_year = events.ev_year,
  aircraft.ev_month = events.ev_month,
  aircraft.mid_air = events.mid_air,
  aircraft.on_ground_collision = events.on_ground_collision,
  aircraft.latitude = events.latitude,
  aircraft.longitude = events.longitude,
  aircraft.latlong_acq = events.latlong_acq,
  aircraft.apt_name = events.apt_name,
  aircraft.ev_nr_apt_id = events.ev_nr_apt_id,
  aircraft.ev_nr_apt_loc = events.ev_nr_apt_loc,
  aircraft.apt_dist = events.apt_dist,
  aircraft.apt_dir = events.apt_dir,
  aircraft.apt_elev = events.apt_elev,
  aircraft.wx_brief_comp = events.wx_brief_comp,
  aircraft.wx_src_iic = events.wx_src_iic,
  aircraft.wx_obs_time = events.wx_obs_time,
  aircraft.wx_obs_dir = events.wx_obs_dir,
  aircraft.wx_obs_fac_id = events.wx_obs_fac_id,
  aircraft.wx_obs_elev = events.wx_obs_elev,
  aircraft.wx_obs_dist = events.wx_obs_dist,
  aircraft.wx_obs_tmzn = events.wx_obs_tmzn,
  aircraft.light_cond = events.light_cond,
  aircraft.sky_cond_nonceil = events.sky_cond_nonceil,
  aircraft.sky_nonceil_ht = events.sky_nonceil_ht,
  aircraft.sky_ceil_ht = events.sky_ceil_ht,
  aircraft.sky_cond_ceil = events.sky_cond_ceil,
  aircraft.vis_rvr = events.vis_rvr,
  aircraft.vis_rvv = events.vis_rvv,
  aircraft.vis_sm = events.vis_sm,
  aircraft.wx_temp = events.wx_temp,
  aircraft.wx_dew_pt = events.wx_dew_pt,
  aircraft.wind_dir_deg = events.wind_dir_deg,
  aircraft.wind_dir_ind = events.wind_dir_ind,
  aircraft.wind_vel_kts = events.wind_vel_kts,
  aircraft.wind_vel_ind = events.wind_vel_ind,
  aircraft.gust_ind = events.gust_ind,
  aircraft.gust_kts = events.gust_kts,
  aircraft.altimeter = events.altimeter,
  aircraft.wx_dens_alt = events.wx_dens_alt,
  aircraft.wx_int_precip = events.wx_int_precip,
  aircraft.ev_highest_injury = events.ev_highest_injury,
  aircraft.inj_f_grnd = events.inj_f_grnd,
  aircraft.inj_m_grnd = events.inj_m_grnd,
  aircraft.inj_s_grnd = events.inj_s_grnd,
  aircraft.inj_tot_f = events.inj_tot_f,
  aircraft.inj_tot_m = events.inj_tot_m,
  aircraft.inj_tot_n = events.inj_tot_n,
  aircraft.inj_tot_s = events.inj_tot_s,
  aircraft.inj_tot_t = events.inj_tot_t,
  aircraft.invest_agy = events.invest_agy,
  aircraft.ntsb_docket = events.ntsb_docket,
  aircraft.ntsb_notf_from = events.ntsb_notf_from,
  aircraft.ntsb_notf_date = events.ntsb_notf_date,
  aircraft.ntsb_notf_tm = events.ntsb_notf_tm,
  aircraft.fiche_number = events.fiche_number,
  aircraft.events_lchg_date = events.events_lchg_date,
  aircraft.events_lchg_userid = events.events_lchg_userid,
  aircraft.wx_cond_basic = events.wx_cond_basic,
  aircraft.faa_dist_office = events.faa_dist_office,
  aircraft.prop_dmg = events.prop_dmg,
  aircraft.vis_restrct = events.vis_restrct,
  aircraft.wx_brief_mthd = events.wx_brief_mthd,
  aircraft.wx_brief_src = events.wx_brief_src,
  aircraft.wx_cond = events.wx_cond;

SELECT 'Merging aircraft table with occurrences data';
DROP VIEW IF EXISTS `occurrences_collapsed`;
CREATE VIEW occurrences_collapsed as (
  SELECT
    aircraft_id,
    occurrence_no,
    occurrence_code,
    phase_of_flight,
    altitude,
    occurrence_lchg_date,
    occurrence_lchg_userid,
    seq_event_no,
    group_code,
    subj_code,
    cause_factor,
    modifier_code,
    person_code
  FROM occurrences
  WHERE `cause_factor` IS NOT NULL
  GROUP BY aircraft_id
);

UPDATE `aircraft`
INNER JOIN `occurrences_collapsed` ON aircraft.aircraft_id = occurrences_collapsed.aircraft_id
SET
  aircraft.occurrence_no = occurrences_collapsed.occurrence_no,
  aircraft.occurrence_code = occurrences_collapsed.occurrence_code,
  aircraft.phase_of_flight = occurrences_collapsed.phase_of_flight,
  aircraft.altitude = occurrences_collapsed.altitude,
  aircraft.occurrence_lchg_date = occurrences_collapsed.occurrence_lchg_date,
  aircraft.occurrence_lchg_userid = occurrences_collapsed.occurrence_lchg_userid,
  aircraft.seq_event_no = occurrences_collapsed.seq_event_no,
  aircraft.group_code = occurrences_collapsed.group_code,
  aircraft.subj_code = occurrences_collapsed.subj_code,
  aircraft.cause_factor = occurrences_collapsed.cause_factor,
  aircraft.modifier_code = occurrences_collapsed.modifier_code,
  aircraft.person_code = occurrences_collapsed.person_code;

SELECT 'Collapsing flight crew table to include only pilots';
DROP VIEW IF EXISTS `flight_crew_pilot_binary`;
CREATE VIEW flight_crew_pilot_binary as (
  SELECT 
    flight_crew.*, 
    case when crew_category = "PLT" then crew_id end as pilot_id,
    case when crew_category = "PLT" then crew_category end as pilot_binary,
    case when crew_category = "PLT" then crew_no end as pilot_no,
    case when crew_category = "PLT" then crew_age end as pilot_age,
    case when crew_category = "PLT" then crew_sex end as pilot_sex,
    case when crew_category = "PLT" then crew_city end as pilot_city,
    case when crew_category = "PLT" then crew_res_state end as pilot_res_state,
    case when crew_category = "PLT" then crew_res_country end as pilot_res_country,
    case when crew_category = "PLT" then med_certf end as pilot_med_certf,
    case when crew_category = "PLT" then med_crtf_vldty end as pilot_med_crtf_vldty,
    case when crew_category = "PLT" then date_lst_med end as pilot_date_lst_med,
    case when crew_category = "PLT" then crew_rat_endorse end as pilot_rat_endorse,
    case when crew_category = "PLT" then crew_inj_level end as pilot_inj_level,
    case when crew_category = "PLT" then seatbelts_used end as pilot_seatbelts_used,
    case when crew_category = "PLT" then shldr_harn_used end as pilot_shldr_harn_used,
    case when crew_category = "PLT" then crew_tox_perf end as pilot_tox_perf,
    case when crew_category = "PLT" then seat_occ_pic end as pilot_seat_occ_pic,
    case when crew_category = "PLT" then pc_profession end as pilot_pc_profession,
    case when crew_category = "PLT" then bfr end as pilot_bfr,
    case when crew_category = "PLT" then bfr_date end as pilot_bfr_date,
    case when crew_category = "PLT" then ft_as_of end as pilot_ft_as_of,
    case when crew_category = "PLT" then flight_crew_lchg_date end as pilot_flight_crew_lchg_date,
    case when crew_category = "PLT" then flight_crew_lchg_userid end as pilot_flight_crew_lchg_userid,
    case when crew_category = "PLT" then seat_occ_row end as pilot_seat_occ_row,
    case when crew_category = "PLT" then infl_rest_inst end as pilot_infl_rest_inst,
    case when crew_category = "PLT" then infl_rest_depl end as pilot_infl_rest_depl,
    case when crew_category = "PLT" then child_restraint end as pilot_child_restraint,
    case when crew_category = "PLT" then med_crtf_limit end as pilot_med_crtf_limit,
    case when crew_category = "PLT" then mr_faa_med_certf end as pilot_mr_faa_med_certf,
    case when crew_category = "PLT" then pilot_flying end as pilot_pilot_flying,
    case when crew_category = "PLT" then available_restraint end as pilot_available_restraint,
    case when crew_category = "PLT" then restraint_used end as pilot_restraint_used,
    case when crew_category = "PLT" then crew_cert_code end as pilot_cert_code,
    case when crew_category = "PLT" then crew_rat_airpln end as pilot_rat_airpln,
    case when crew_category = "PLT" then crew_rat_instruct end as pilot_rat_instruct,
    case when crew_category = "PLT" then crew_rat_instrum end as pilot_rat_instrum,
    case when crew_category = "PLT" then crew_rat_roto end as pilot_rat_roto,
    case when crew_category = "PLT" then flight_hours_l24h_all end as pilot_flight_hours_l24h_all,
    case when crew_category = "PLT" then flight_hours_l30d_all end as pilot_flight_hours_l30d_all,
    case when crew_category = "PLT" then flight_hours_l90d_all end as pilot_flight_hours_l90d_all,
    case when crew_category = "PLT" then flight_hours_pic_all end as pilot_flight_hours_pic_all,
    case when crew_category = "PLT" then flight_hours_totl_all end as pilot_flight_hours_totl_all,
    case when crew_category = "PLT" then flight_hours_l24h_make end as pilot_flight_hours_l24h_make,
    case when crew_category = "PLT" then flight_hours_l30d_make end as pilot_flight_hours_l30d_make,
    case when crew_category = "PLT" then flight_hours_l90d_make end as pilot_flight_hours_l90d_make,
    case when crew_category = "PLT" then flight_hours_pic_make end as pilot_flight_hours_pic_make,
    case when crew_category = "PLT" then flight_hours_totl_make end as pilot_flight_hours_totl_make
  FROM flight_crew
);

DROP VIEW IF EXISTS `flight_crew_collapsed`;
CREATE VIEW flight_crew_collapsed as (
  SELECT
    ev_id,
    aircraft_id,
    group_concat(pilot_id) as pilot_id,
    group_concat(pilot_no) as pilot_no,
    group_concat(pilot_binary) as pilot_binary,
    group_concat(pilot_age) as pilot_age,
    group_concat(pilot_sex) as pilot_sex,
    group_concat(pilot_city) as pilot_city,
    group_concat(pilot_res_state) as pilot_res_state,
    group_concat(pilot_res_country) as pilot_res_country,
    group_concat(pilot_med_certf) as pilot_med_certf,
    group_concat(pilot_med_crtf_vldty) as pilot_med_crtf_vldty,
    group_concat(pilot_date_lst_med) as pilot_date_lst_med,
    group_concat(pilot_rat_endorse) as pilot_rat_endorse,
    group_concat(pilot_inj_level) as pilot_inj_level,
    group_concat(pilot_seatbelts_used) as pilot_seatbelts_used,
    group_concat(pilot_shldr_harn_used) as pilot_shldr_harn_used,
    group_concat(pilot_tox_perf) as pilot_tox_perf,
    group_concat(pilot_seat_occ_pic) as pilot_seat_occ_pic,
    group_concat(pilot_pc_profession) as pilot_pc_profession,
    group_concat(pilot_bfr) as pilot_bfr,
    group_concat(pilot_bfr_date) as pilot_bfr_date,
    group_concat(pilot_ft_as_of) as pilot_ft_as_of,
    group_concat(pilot_flight_crew_lchg_date) as pilot_flight_crew_lchg_date,
    group_concat(pilot_flight_crew_lchg_userid) as pilot_flight_crew_lchg_userid,
    group_concat(pilot_seat_occ_row) as pilot_seat_occ_row,
    group_concat(pilot_infl_rest_inst) as pilot_infl_rest_inst,
    group_concat(pilot_infl_rest_depl) as pilot_infl_rest_depl,
    group_concat(pilot_child_restraint) as pilot_child_restraint,
    group_concat(pilot_med_crtf_limit) as pilot_med_crtf_limit,
    group_concat(pilot_mr_faa_med_certf) as pilot_mr_faa_med_certf,
    group_concat(pilot_pilot_flying) as pilot_pilot_flying,
    group_concat(pilot_available_restraint) as pilot_available_restraint,
    group_concat(pilot_restraint_used) as pilot_restraint_used,
    group_concat(pilot_cert_code) as pilot_cert_code,
    group_concat(pilot_rat_airpln) as pilot_rat_airpln,
    group_concat(pilot_rat_instruct) as pilot_rat_instruct,
    group_concat(pilot_rat_instrum) as pilot_rat_instrum,
    group_concat(pilot_rat_roto) as pilot_rat_roto,
    group_concat(pilot_flight_hours_l24h_all) as pilot_flight_hours_l24h_all,
    group_concat(pilot_flight_hours_l30d_all) as pilot_flight_hours_l30d_all,
    group_concat(pilot_flight_hours_l90d_all) as pilot_flight_hours_l90d_all,
    group_concat(pilot_flight_hours_pic_all) as pilot_flight_hours_pic_all,
    group_concat(pilot_flight_hours_totl_all) as pilot_flight_hours_totl_all,
    group_concat(pilot_flight_hours_l24h_make) as pilot_flight_hours_l24h_make,
    group_concat(pilot_flight_hours_l30d_make) as pilot_flight_hours_l30d_make,
    group_concat(pilot_flight_hours_l90d_make) as pilot_flight_hours_l90d_make,
    group_concat(pilot_flight_hours_pic_make) as pilot_flight_hours_pic_make,
    group_concat(pilot_flight_hours_totl_make) as pilot_flight_hours_totl_make
  FROM flight_crew_pilot_binary
  GROUP BY aircraft_id
);

DROP VIEW IF EXISTS `aircraft_single_pilot`;
CREATE VIEW aircraft_single_pilot as (
  SELECT flight_crew_collapsed.* 
  FROM `flight_crew_collapsed`
  WHERE `pilot_binary` = 'PLT'
);

DROP VIEW IF EXISTS `aircraft_single_pilot_crew_one`;
CREATE VIEW aircraft_single_pilot_crew_one as (
  SELECT flight_crew_collapsed.* 
  FROM `flight_crew_collapsed`
  WHERE `pilot_binary` = 'PLT' AND `pilot_no` = 1
);

DROP VIEW IF EXISTS `aircraft_multiple_pilots`;
CREATE VIEW aircraft_multiple_pilots as (
  SELECT flight_crew_collapsed.* 
  FROM `flight_crew_collapsed` 
  WHERE LOCATE(',', `pilot_binary`) > 0
);

DROP VIEW IF EXISTS `aircraft_null_pilots`;
CREATE VIEW aircraft_null_pilots as (
  SELECT flight_crew_collapsed.* 
  FROM `flight_crew_collapsed` 
  WHERE `pilot_binary` IS NULL 
);

SELECT 'Merging aircraft table with data from pilots identified as first crew member';
-- According to NTSB's data dictionary, "[Crew] numbers are assigned sequentially 
-- starting with 1, which usually represents the pilot."
UPDATE `aircraft`
INNER JOIN `aircraft_single_pilot_crew_one` ON aircraft.aircraft_id = aircraft_single_pilot_crew_one.aircraft_id
SET
  aircraft.pilot_id = aircraft_single_pilot_crew_one.pilot_id,
  aircraft.pilot_no = aircraft_single_pilot_crew_one.pilot_no,
  aircraft.pilot_age = aircraft_single_pilot_crew_one.pilot_age,
  aircraft.pilot_sex = aircraft_single_pilot_crew_one.pilot_sex,
  aircraft.pilot_city = aircraft_single_pilot_crew_one.pilot_city,
  aircraft.pilot_res_state = aircraft_single_pilot_crew_one.pilot_res_state,
  aircraft.pilot_res_country = aircraft_single_pilot_crew_one.pilot_res_country,
  aircraft.pilot_med_certf = aircraft_single_pilot_crew_one.pilot_med_certf,
  aircraft.pilot_med_crtf_vldty = aircraft_single_pilot_crew_one.pilot_med_crtf_vldty,
  aircraft.pilot_date_lst_med = aircraft_single_pilot_crew_one.pilot_date_lst_med,
  aircraft.pilot_rat_endorse = aircraft_single_pilot_crew_one.pilot_rat_endorse,
  aircraft.pilot_inj_level = aircraft_single_pilot_crew_one.pilot_inj_level,
  aircraft.pilot_seatbelts_used = aircraft_single_pilot_crew_one.pilot_seatbelts_used,
  aircraft.pilot_shldr_harn_used = aircraft_single_pilot_crew_one.pilot_shldr_harn_used,
  aircraft.pilot_tox_perf = aircraft_single_pilot_crew_one.pilot_tox_perf,
  aircraft.pilot_seat_occ_pic = aircraft_single_pilot_crew_one.pilot_seat_occ_pic,
  aircraft.pilot_pc_profession = aircraft_single_pilot_crew_one.pilot_pc_profession,
  aircraft.pilot_bfr = aircraft_single_pilot_crew_one.pilot_bfr,
  aircraft.pilot_bfr_date = aircraft_single_pilot_crew_one.pilot_bfr_date,
  aircraft.pilot_ft_as_of = aircraft_single_pilot_crew_one.pilot_ft_as_of,
  aircraft.pilot_flight_crew_lchg_date = aircraft_single_pilot_crew_one.pilot_flight_crew_lchg_date,
  aircraft.pilot_flight_crew_lchg_userid = aircraft_single_pilot_crew_one.pilot_flight_crew_lchg_userid,
  aircraft.pilot_seat_occ_row = aircraft_single_pilot_crew_one.pilot_seat_occ_row,
  aircraft.pilot_infl_rest_inst = aircraft_single_pilot_crew_one.pilot_infl_rest_inst,
  aircraft.pilot_infl_rest_depl = aircraft_single_pilot_crew_one.pilot_infl_rest_depl,
  aircraft.pilot_child_restraint = aircraft_single_pilot_crew_one.pilot_child_restraint,
  aircraft.pilot_med_crtf_limit = aircraft_single_pilot_crew_one.pilot_med_crtf_limit,
  aircraft.pilot_mr_faa_med_certf = aircraft_single_pilot_crew_one.pilot_mr_faa_med_certf,
  aircraft.pilot_pilot_flying = aircraft_single_pilot_crew_one.pilot_pilot_flying,
  aircraft.pilot_available_restraint = aircraft_single_pilot_crew_one.pilot_available_restraint,
  aircraft.pilot_restraint_used = aircraft_single_pilot_crew_one.pilot_restraint_used,
  aircraft.pilot_cert_code = aircraft_single_pilot_crew_one.pilot_cert_code,
  aircraft.pilot_rat_airpln = aircraft_single_pilot_crew_one.pilot_rat_airpln,
  aircraft.pilot_rat_instruct = aircraft_single_pilot_crew_one.pilot_rat_instruct,
  aircraft.pilot_rat_instrum = aircraft_single_pilot_crew_one.pilot_rat_instrum,
  aircraft.pilot_rat_roto = aircraft_single_pilot_crew_one.pilot_rat_roto,
  aircraft.pilot_flight_hours_l24h_all = aircraft_single_pilot_crew_one.pilot_flight_hours_l24h_all,
  aircraft.pilot_flight_hours_l30d_all = aircraft_single_pilot_crew_one.pilot_flight_hours_l30d_all,
  aircraft.pilot_flight_hours_l90d_all = aircraft_single_pilot_crew_one.pilot_flight_hours_l90d_all,
  aircraft.pilot_flight_hours_pic_all = aircraft_single_pilot_crew_one.pilot_flight_hours_pic_all,
  aircraft.pilot_flight_hours_totl_all = aircraft_single_pilot_crew_one.pilot_flight_hours_totl_all,
  aircraft.pilot_flight_hours_l24h_make = aircraft_single_pilot_crew_one.pilot_flight_hours_l24h_make,
  aircraft.pilot_flight_hours_l30d_make = aircraft_single_pilot_crew_one.pilot_flight_hours_l30d_make,
  aircraft.pilot_flight_hours_l90d_make = aircraft_single_pilot_crew_one.pilot_flight_hours_l90d_make,
  aircraft.pilot_flight_hours_pic_make = aircraft_single_pilot_crew_one.pilot_flight_hours_pic_make,
  aircraft.pilot_flight_hours_totl_make = aircraft_single_pilot_crew_one.pilot_flight_hours_totl_make;

SELECT 'Drop views created as helpers';
DROP VIEW IF EXISTS `dt_events_extended`;
DROP VIEW IF EXISTS `dt_events_pivoted`;
DROP VIEW IF EXISTS `dt_flight_crew_extended`;
DROP VIEW IF EXISTS `dt_flight_crew_pivoted`;
DROP VIEW IF EXISTS `flight_time_extended`;
DROP VIEW IF EXISTS `flight_time_pivoted`;
DROP VIEW IF EXISTS `flight_crew_pilot_binary`;
DROP VIEW IF EXISTS `flight_crew_collapsed`;
DROP VIEW IF EXISTS `aircraft_single_pilot`;
DROP VIEW IF EXISTS `aircraft_single_pilot_crew_one`;
DROP VIEW IF EXISTS `aircraft_multiple_pilots`;
DROP VIEW IF EXISTS `aircraft_null_pilots`;
-- DROP VIEW IF EXISTS `seq_of_events_cause`;
-- DROP VIEW IF EXISTS `seq_of_events_collapsed`;
-- DROP VIEW IF EXISTS `occurrences_collapsed`;
