/*Create Table*/
CREATE TABLE `time_dimension_month` (
  `Id` int(11) NOT NULL,
  `year` int(10) DEFAULT NULL,
  `month` int(10) DEFAULT NULL,
  `month_name` varchar(9) DEFAULT NULL,
  `Month_Start` date DEFAULT NULL,
  `Month_End` date DEFAULT NULL,
  `Day_Count` int(11) DEFAULT NULL,
  `Hour_Count` int(11) DEFAULT NULL,
  `Weekend_Day_Count` int(11) DEFAULT NULL,
  `Weekend_Hours` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

/*INSERT Cluase*/
INSERT INTO time_dimension_month
SELECT
	MIN(id),
	year,
	month,
	month_name,
	MIN(db_date),
	MAX(db_date),
	COUNT(DISTINCT db_date),
	COUNT(DISTINCT db_date) * 24,
	SUM(weekend_flag),
	SUM(weekend_flag) * 24
FROM time_dimension
GROUP BY 2,3
