 
--1. Read report

SELECT *
FROM crime_scene_report
WHERE city = "SQL City" 
AND date = 20180115


--2. New information (2 witnesses). 

-- One lives on  last house on "Northwestern Dr"
FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 1;

-- Secod witness, “Annabel” lives on “Franklin Ave”
SELECT *
FROM person
WHERE name  like "A%"
AND address_street_name = "Franklin Ave";


--3. Now I need to read the police report of the witnesses

SELECT p.id, p.name, i.transcript
FROM person AS p
INNER JOIN interview AS i 
ON p.id = i.person_id
WHERE p.name IN ("Morty Schapiro", "Annabel Miller")

/*
She recognized the killer from her gym when working out last week on January 9th.
Let us check who participated in that class.

Morty Schapiro:
- Killer had "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z
- Car with a plate that included "H42W"*/

--4. Gym lead

SELECT m.name,c.membership_id,m.membership_start_date, c.check_in_date,
c.check_in_time, c.check_out_time
FROM get_fit_now_member AS m
INNER JOIN get_fit_now_check_in AS c
ON m.id = c.membership_id
WHERE c.check_in_date = 20180109 AND
c.membership_id LIKE '48Z%'


--5. Car lead

SELECT p.id, p.name, d.age, d.height,
d.eye_color, d.hair_color, d.gender,
d.plate_number, d.car_make, d.car_model
FROM person AS p
INNER JOIN drivers_license AS d 
ON p.license_id = d.id
WHERE p.name IN ("Joe Germuska", "Jeremy Bowers")
AND plate_number LIKE '%H42W%';


--6. Who paid the killer?

--Read crime report

SELECT p.id, p.name, i.transcript
FROM person AS p
INNER JOIN interview AS i 
ON p.id = i.person_id
WHERE p.name = "Jeremy Bowers"

--Find the brains behind the crime using the clues from the report

SELECT p.name, d.height, d.hair_color, d.gender,
d.car_make, d.car_model,f.event_name, f.date
FROM person AS p
INNER JOIN drivers_license AS d ON p.license_id = d.id
INNER JOIN facebook_event_checkin AS f ON p.id = f.person_id
WHERE gender = "female" 
AND height BETWEEN 65 AND 67
AND hair_color = "red"
AND car_make = "Tesla"
AND car_model = "Model S"


