CREATE TABLE birdstrikes 
(id INTEGER NOT NULL,
aircraft VARCHAR(32),
flight_date DATE NOT NULL,
damage VARCHAR(16) NOT NULL,
airline VARCHAR(255) NOT NULL,
state VARCHAR(255),
phase_of_flight VARCHAR(32),
reported_date DATE,
bird_size VARCHAR(16),
cost INTEGER NOT NULL,
speed INTEGER,PRIMARY KEY(id));

SHOW VARIABLES LIKE "secure_file_priv";

TRUNCATE birdstrikes;

LOAD DATA INFILE 'c:/Program Files/MySQL/Uploads/birdstrikes.csv' 
INTO TABLE birdstrikes 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(id, aircraft, flight_date, damage, airline, state, phase_of_flight, @v_reported_date, bird_size, cost, @v_speed)
SET
reported_date = nullif(@v_reported_date, ''),
speed = nullif(@v_speed, '');

SELECT * FROM birdstrikes;


-- What state figures in the 145th line of our database? --

SELECT * FROM birdstrikes LIMIT 144,1;
-- Tennessee --


-- What is flight_date of the latest birstrike in this database? -- 
SELECT * FROM birdstrikes 
ORDER BY flight_date DESC;
-- 2000.04.18 -- 

-- What was the cost of the 50th most expensive damage? --
SELECT DISTINCT cost FROM birdstrikes
ORDER BY cost 
LIMIT 49,1; 
-- 86864 -- 

-- What state figures in the 2nd record, if you filter out all records which have no state and no bird_size specified? -- 
SELECT * FROM birdstrikes;
SELECT state,bird_size 
FROM birdstrikes
WHERE state is NOT NULL 
AND bird_size is NOT NULL;
-- Empty string -- 

-- How many days elapsed between the current date and the flights happening in week 52, for incidents from Colorado? -- 

SELECT now();
SELECT WEEKOFYEAR(now());
SELECT state, flight_date
FROM birdstrikes 
WHERE state = "Colorado";

 SELECT DATEDIFF("2000-02-23","2000-01-01");
-- i try to find out the week number of flihts from Colorado by substitution the values in DATEDIFF function. It mention above. --
-- I did this, in order to find which flight was in 52-d week. --
-- However, if I took  SELECT DATEDIFF("2000-01-01", "2000-02-23"); --> 53 while the closing date from left (2000-02-15) gave result  45 --  
-- If accept week 53--
SELECT DATEDIFF("2020-10-06","2000-01-01");
 -- 7584 days-- 

