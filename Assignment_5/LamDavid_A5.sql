USE cs457;

-- Q1.) Find the name of all people who work for ACME with
-- an annual salary over $50,00
SELECT person_name, salary FROM works
	WHERE salary > 50000
;

-- Q2.) Find the name, street, and city of all people who work 
-- for ACME Corporation and earn more than $50,000
SELECT lives.person_name, lives.street, lives.city, works.salary FROM lives, works
	WHERE lives.person_name = works.person_name
	AND works.company_name = "ACME Corporation"
	AND salary > 50000
;

-- Q3.) Find all people who live in the same city as the company
-- they work for
SELECT DISTINCT works.person_name FROM works, located_in, lives
	WHERE works.company_name = located_in.company_name
	AND located_in.city = lives.city
;

-- Q4.) Find all people who live in the same city and on the same
-- street as their manager
SELECT DISTINCT person.person_name FROM manages, lives manager, lives person
	NATURAL JOIN lives 
	WHERE manages.manager_name = manager.person_name
	AND manager.city = person.city
	AND manager.street = person.street
	AND person.person_name != manager.person_name
;

-- Q5.) Assume that there are people in the table lives who do not work
-- for any company. Find all people who do not work for ACME Corporation.
SELECT lives.person_name FROM lives
	WHERE lives.person_name NOT IN (
		SELECT person_name FROM works
		WHERE works.company_name = "ACME Corporation"
	)
;

-- Q6.) Find all people who earn more than every employee of ACME Corporation
SELECT * FROM works workplace
WHERE workplace.salary NOT IN (
		SELECT workplace.salary FROM works ACME
		WHERE workplace.salary < ACME.salary
		AND ACME.company_name = "ACME Corporation"
	)
;

-- Q7.) Assume the companies may be located in several cities. Find all companies
-- located in every city in which ACME Corporation is located. 
SELECT DISTINCT company_name FROM located_in
	EXCEPT
	SELECT DISTINCT company_name FROM located_in
	WHERE company_name = "ACME Corporation"
;


SELECT * FROM located_in AS sx
	WHERE NOT EXISTS (
		(SELECT city FROM located_in AS p
			WHERE city = p.city)
		EXCEPT
		(SELECT city FROM located_in AS sp
			WHERE sx.company_name = sp.company_name)
		)
;

-- https://www.geeksforgeeks.org/sql-division/

SELECT * FROM lives;
SELECT * FROM located_in;
SELECT * FROM manages;
SELECT * FROM works;
