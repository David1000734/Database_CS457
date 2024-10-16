USE cs457;

-- Part 1: Cleaning up the database
START TRANSACTION;
	-- Savepoint for null names or places
	SAVEPOINT del_name_or_place;

	-- Delete from lives table
	DELETE FROM lives
		WHERE person_name IS NULL
		OR    city IS NULL
		OR    street IS NULL
	;
	
	-- Delete from Manages
	DELETE FROM manages
		WHERE person_name IS NULL
		OR manager_name IS NULL
	;
	
	-- Delete from works
	DELETE FROM works
		WHERE person_name IS NULL
	;
	-- Assume company_name does not have this problem

	-- Done with deleting names and places
	-- Check for negative salaries
	SAVEPOINT del_neg_salary;
	
	-- Only works table has salaries. 0 is allowed...
	DELETE FROM works
		WHERE salary < 0
	;
	-- Done with salaries
	
	-- Check to see if people are in the right company
	SAVEPOINT del_company_name;
	DELETE FROM works
		WHERE company_name NOT IN (
			"ACME Corporation",
			"Bank of America",
			"Chase",
			"Capital One",
			"UniCredit"
		)
	;
	
	DELETE FROM located_in
		WHERE company_name NOT IN (
			"ACME Corporation",
			"Bank of America",
			"Chase",
			"Capital One",
			"UniCredit"
		)
	;
COMMIT;

-- Part 2: Adding constraints
START TRANSACTION;
	SAVEPOINT NullNames;
	
	-- Not null for people and places
	ALTER TABLE lives
		MODIFY person_name VARCHAR(50) NOT NULL,
		MODIFY street VARCHAR(50) NOT NULL,
		MODIFY city VARCHAR(50) NOT NULL 
	;

/*
	INSERT INTO lives VALUE
	(44, NULL, "Not NULL", "Vegas");

	INSERT INTO lives VALUE
	(44, "name", NULL, "Vegas");
	
	INSERT INTO lives VALUE
	(44, "name", "City", NULL);
	
	DELETE FROM lives WHERE person_id = 44;
*/

	-- Constraint for salary must be greater than 0
	SAVEPOINT ZeroSalary;
	-- Salary is greater than 0
	ALTER TABLE works
		ADD CONSTRAINT NonZeroSalary CHECK (salary > 0)
	;

/*
	INSERT INTO works VALUE
	(44, "name", "company", 0);
	
	DELETE FROM works WHERE person_id = 44;
*/

	-- Constraint for company names
	SAVEPOINT company_names;
	ALTER TABLE works
		ADD CONSTRAINT RecognizedCompanys CHECK (
			company_name IN (
				"ACME Corporation",
				"Bank of America",
				"Chase",
				"Capital One",
				"UniCredit"
			)
		)
	;

	ALTER TABLE located_in
		ADD CONSTRAINT RecognizedCompanies CHECK (
			company_name IN (
				"ACME Corporation",
				"Bank of America",
				"Chase",
				"Capital One",
				"UniCredit"
			)
		)
	;

/*
	INSERT INTO works VALUE
	(44, "some dude", "Not ACME", 20);
	
	DELETE FROM works WHERE person_id = 44;

	INSERT INTO located_in VALUE
	("Some Company", "City");
	
	DELETE FROM located_in WHERE company_name = "Some Company";
*/
COMMIT;

-- Create a trigger to catch salary values of 0 and set to 3000
DELIMITER //
	CREATE TRIGGER ContractorSalary
	BEFORE INSERT ON works
	FOR EACH ROW
	BEGIN
		if NEW.salary = 0 then
			SET NEW.salary = 3000;
		END if;
	END; //
DELIMITER ;

INSERT INTO works VALUES
(44, "George Washington", "ACME Corporation", 0);

DELETE FROM works WHERE person_id = 44;

SELECT * FROM lives;
SELECT * FROM located_in;
SELECT * FROM manages;
SELECT * FROM works;
