USE cs457;

-- Part 1: Cleaning up the database
START TRANSACTION;
	-- Savepoint for null names or places
	SAVEPOINT del_name_or_place;

	-- Delete from lives table
	DELETE FROM lives
		WHERE person_name IS NULL
		OR    city IS NULL
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

SELECT * FROM lives;
SELECT * FROM located_in;
SELECT * FROM manages;
SELECT * FROM works;
