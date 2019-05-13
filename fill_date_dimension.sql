/*MySQL Routine to create a date table*/

/*Create Table*/
CREATE TABLE `time_dimension` (
  `id` int(10) NOT NULL,
  `db_date` date NOT NULL,
  `year` int(10) NOT NULL,
  `month` int(10) NOT NULL,
  `day` int(10) NOT NULL,
  `quarter` int(10) NOT NULL,
  `week_of_year` int(10) NOT NULL,
  `week_m0` int(10) NOT NULL,
  `week_m1` int(10) NOT NULL,
  `week_m2` int(10) NOT NULL,
  `week_m3` int(10) NOT NULL,
  `week_m4` int(10) NOT NULL,
  `week_m5` int(10) NOT NULL,
  `week_m6` int(10) NOT NULL,
  `week_m7` int(10) NOT NULL,
  `day_name` varchar(9) NOT NULL,
  `weekday` int(1) NOT NULL,
  `month_name` varchar(9) NOT NULL,
  `holiday_flag` binary(1) DEFAULT '0',
  `weekend_flag` binary(1) DEFAULT '0',
  `event` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `db_date` (`db_date`),
  KEY `Year` (`year`),
  KEY `Month` (`month`),
  KEY `Day` (`day`),
  KEY `Quarter` (`quarter`),
  KEY `Week_of_year` (`week_of_year`),
  KEY `Week_m0` (`week_m0`),
  KEY `Week_m1` (`week_m1`),
  KEY `Week_m2` (`week_m2`),
  KEY `Week_m3` (`week_m3`),
  KEY `Week_m4` (`week_m4`),
  KEY `Week_m5` (`week_m5`),
  KEY `Week_m6` (`week_m6`),
  KEY `Week_m7` (`week_m7`),
  KEY `day_name` (`day_name`),
  KEY `WeekDay` (`weekday`),
  KEY `month_name` (`month_name`),
  KEY `weekend_flag` (`weekend_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

/*Procedure*/
CREATE DEFINER=`[USERNAME]`@`%` PROCEDURE `fill_date_dimension`(
	IN `startdate` DATE,
	IN `stopdate` DATE
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Fills time_dimension table between dates input by user. Week columns are broken up by the mode in WEEK function or standard WEEKOFYEAR'
BEGIN
    DECLARE currentdate DATE;
    SET currentdate = startdate;
    WHILE currentdate < stopdate DO
        INSERT INTO time_dimension VALUES (
                        YEAR(currentdate)*10000+MONTH(currentdate)*100 + DAY(currentdate),
                        currentdate,
                        YEAR(currentdate),
                        MONTH(currentdate),
                        DAY(currentdate),
                        QUARTER(currentdate),
                        WEEKOFYEAR(currentdate),
                        WEEK(currentdate,0),
                        WEEK(currentdate,1),
                        WEEK(currentdate,2),
                        WEEK(currentdate,3),
                        WEEK(currentdate,4),
                        WEEK(currentdate,5),
                        WEEK(currentdate,6),
                        WEEK(currentdate,7),
                        DATE_FORMAT(currentdate,'%W'),
                        WEEKDAY(currentdate),
                        DATE_FORMAT(currentdate,'%M'),
                        0,
                        CASE DAYOFWEEK(currentdate) WHEN 1 THEN 1 WHEN 7 then 1 ELSE 0 END,
                        NULL);
        SET currentdate = ADDDATE(currentdate,INTERVAL 1 DAY);
    END WHILE;
END
