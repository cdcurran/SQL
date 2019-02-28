/*This file is for learning MySQL Workbench and some basic queries*/

/*This query returns the name of each damn listed in the table dams1*/

SELECT dam_name
FROM exercises.dams1;

/*This query returns the name, state, county and inspection date*/
SELECT dam_name, state_name, county, insp_date
FROM exercises.dams1;

/*This query returns all fields for all records in the table dams1*/
SELECT *
FROM exercises.dams1;

/*This query returns all records in dams1, sorted by the dam name Z-A.*/
SELECT *
FROM exercises.dams1
ORDER BY dam_name desc;

/*This query returns all fields for all records in dams1 sorted by dam name from A-Z*/
SELECT *
FROM exercises.dams1
ORDER BY dam_name;

/*This query returns all fields in dams1, but only those dams located in Ashland County, Ohio, sorted by dam name from A-Z*/
SELECT *
FROM exercises.dams1
WHERE COUNTY = "ASHLAND"
ORDER BY dam_name;

/*Return all fields in dams1, but only those dams completed in 1969, sorted A-Z by name*/
SELECT *
FROM exercises.dams1
WHERE year_compl=1969
ORDER BY dam_name;

/*dams before 1969*/
SELECT *
FROM exercises.dams1
WHERE YEAR_COMPL <1969
ORDER BY YEAR_COMPL;


/*Returns all fields in dams1, but only thos in ashland, medina and perry counties in ohio, sorted by name form A-Z*/
SELECT *
FROM exercises.dams1
WHERE county IN ("ASHLAND" , "MEDINA", "PERRY")
ORDER BY dam_name;

/*filtering data stored as dates and times*/
/* return a list of all dams inspected on feb 23, 1995*/

SELECT *
FROM exercises.dams1
WHERE insp_date = "1995-02-23"
ORDER BY dam_name;


/* return a list of all dams inspected in 1995, ordered by dam name from a-z*/
SELECT *
FROM exercises.dams1
WHERE year (insp_date) =1995
ORDER BY dam_name;

/* return all records from 1995 in fulton county from a-z*/
SELECT *
FROM exercises.dams1
WHERE year (insp_date) = 1995 AND county ="FULTON"
ORDER BY dam_name;

/*All dams inspected in 1995 (regardless of county) OR if they were located in Fulton county*/
SELECT *
FROM exercises.dams1
WHERE year (insp_date) = 1995 OR county ="FULTON"
ORDER BY dam_name;

/*RETURN ONLY RECORDS WHERE NEAR_CITY starts with new*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY LIKE "NEW%"
ORDER BY dam_name;


/* return only records where near_city ends with burgh*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY LIKE "%BURGH"
ORDER BY dam_name;

/*return only records where near_city has "new" anywhere in a word*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY LIKE "%NEW%"
ORDER BY dam_name;

/*only cities that start with new and end with town*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY LIKE "NEW%TOWN"
ORDER BY dam_name;

/*starts with "new" ends with "town and has exactly one character between them*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY LIKE "NEW_TOWN"
ORDER BY dam_name;

/*not like operator (excludes records)*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY NOT LIKE "NEW%"
ORDER BY dam_name;

/*this query returns all records except those with NEAR_CITY equal to "NEWTOWN" or "NEWCOMERSTOWN".*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY NOT IN ("NEWTOWN", "NEWCOMERSTOWN")
ORDER BY dam_name;

/*single values, you can also use the "not equal to" operator,*/
SELECT *
FROM exercises.dams1
WHERE NEAR_CITY <> "NEWTOWN"
ORDER BY dam_name;

/*find records with missing -- or null -- values or exclude them*/
SELECT *
FROM exercises.dams1
WHERE YEAR_COMPL IS NOT NULL
ORDER BY dam_name;

/*this query returns all records where YEAR_COMPL is missing a value*/
SELECT *
FROM exercises.dams1
WHERE YEAR_COMPL IS NULL
ORDER BY dam_name;
