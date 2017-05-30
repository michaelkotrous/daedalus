SELECT 'Select final aircraft data for GA accidents';
DROP VIEW IF EXISTS `aircraft_ga_accidents`;
CREATE VIEW aircraft_ga_accidents as (
  SELECT * 
  FROM `aircraft`
  WHERE `far_part` = '091' AND `ev_type` = 'ACC' AND `acft_category` = 'AIR' AND (`fixed_retractable` = 'FIXD' OR `fixed_retractable` IS NULL) AND `commercial_space_flight` = 0 AND `unmanned` = 0
);

SELECT 'Export aircraft data for GA accidents to csv';
SELECT * FROM `aircraft_ga_accidents` 
INTO OUTFILE '/tmp/aircraft-GAaccidents.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY ''
LINES TERMINATED BY '\n';
