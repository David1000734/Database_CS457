USE cs457;

-- Q1.) Find the name of all people who work for ACME with
-- an annual salary over $50,00
SELECT person_name, salary
FROM works
	-- Find anyone with a salary higher than 50,000
	WHERE salary > 50000
;

-- Q2.) Find the name, street, and city of all people who work 
-- for ACME Corporation and earn more than $50,000
SELECT lives.person_name, street, city, salary, company_name
FROM lives, works
	-- Find someone who lives and works
	WHERE lives.person_name = works.person_name
	-- Check to see if they work for ACME
	AND works.company_name = "ACME Corporation"
	-- Check to see if they have a salary higher than 50,000
	AND salary > 50000
;

-- Q3.) Find all people who live in the same city as the company
-- they work for
SELECT DISTINCT works.person_name, located_in.city AS "Company", lives.city AS "Person"
FROM works, located_in, lives
	-- Find the company someone is working for
	WHERE works.company_name = located_in.company_name
	-- Locate where that person lives
	AND works.person_name = lives.person_name
	-- Check to see if they are located in the same city
	AND located_in.city = lives.city
;

-- Q4.) Find all people who live in the same city and on the same
-- street as their manager
SELECT DISTINCT lives.person_name, manager.city AS "M-city", manager.street AS "M-street",
					person.city AS "P-city", person.street AS "P-Street"
FROM manages, lives manager, lives person
	-- First we must join the manages table with the lives one
	-- on the person_name variable
	NATURAL JOIN lives
	-- First we find the manager
	WHERE manages.manager_name = manager.person_name
	-- Ensure that the manager and the person's city are the same
	AND manager.city = person.city
	-- Ensure the streets are the same
	AND manager.street = person.street
	-- And ensure that we do not have the same person
	AND person.person_name != manager.person_name
;

-- Q5.) Assume that there are people in the table lives who do not work
-- for any company. Find all people who do not work for ACME Corporation.
SELECT lives.person_name
FROM lives
-- Get the entire "lives" table minus...
	WHERE lives.person_name NOT IN (
	-- Get all people's name not in this table
		SELECT person_name FROM works
		-- Get all people who works in ACME
		WHERE works.company_name = "ACME Corporation"
	)
;
-- Thus, from the table of everyone, minus all people who work at ACME

-- Q6.) Find all people who earn more than every employee of ACME Corporation
SELECT person_name, company_name, salary
FROM works workplace
-- From the entire "works" table, minus below
WHERE workplace.salary NOT IN (
	-- Select all salary matching belows conditions
	SELECT workplace.salary FROM works ACME
		-- Find the max of ACME employees by comparing it
		-- with the global table of salaries
		WHERE workplace.salary < ACME.salary
		AND ACME.company_name = "ACME Corporation"
	)
;

-- Q7.) Assume the companies may be located in several cities. Find all companies
-- located in every city in which ACME Corporation is located. 
SELECT DISTINCT sx.company_name
FROM located_in AS sx
-- Select from the entire table, minus the ones below
	WHERE NOT EXISTS (
	-- Select all cities where ACME Corporation resides in
		SELECT city FROM located_in AS p
		WHERE p.city IN (
		-- Find cities with "ACME Corporation"
			SELECT DISTINCT city FROM located_in
				WHERE company_name = "ACME Corporation"
			)
	-- AND, don't allow duplicates
		AND NOT EXISTS (
			SELECT city FROM located_in AS sp
				WHERE sp.city = p.city
		)
	)
;

SELECT * FROM lives;
SELECT * FROM located_in;
SELECT * FROM manages;
SELECT * FROM works;
