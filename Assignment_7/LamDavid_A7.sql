USE cs457;

-- Part 1
-- Drop view if any
DROP VIEW IF EXISTS workers_by_city;

-- Create a new view "workers_by_city" showing
-- person_name, city, and salary. Do this by 
-- joining the lives and works table
CREATE VIEW workers_by_city AS
	SELECT DISTINCT lives.person_name, lives.city, salary
	FROM lives AS tb_lives, works
	NATURAL JOIN lives
;
SELECT * FROM workers_by_city;

-- Now find average salary in each city
DROP VIEW IF EXISTS avg_city_salary;

-- Find the average salary by city.
-- Previous table has every one listed already,
-- Simply find the average and order by city.
CREATE VIEW avg_city_salary AS
	SELECT city, AVG(salary) AS salary
	FROM workers_by_city AS tb
	GROUP BY city
	ORDER BY salary DESC
;
SELECT * FROM avg_city_salary;

-- Part 2: Using Cursor
-- Go through avg_city_salary to display
-- "Average salary in <city> is <salary>.
-- https://www.mysqltutorial.org/mysql-stored-procedure/sql-cursor-in-stored-procedures/
-- https://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-cursor/
DROP PROCEDURE IF EXISTS find_avg_salarys;

DELIMITER $$
CREATE PROCEDURE find_avg_salarys (
	OUT salary_list TEXT
)

BEGIN
	DECLARE done BOOL DEFAULT FALSE;
	DECLARE c VARCHAR(50) DEFAULT "";
	DECLARE temp_string TEXT DEFAULT "";
	DECLARE s INT DEFAULT 0;

	DECLARE cursor_avg_salary CURSOR FOR
		SELECT city, salary FROM avg_city_salary;
	
	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET done = TRUE;
	
	OPEN cursor_avg_salary;

	FETCH NEXT FROM cursor_avg_salary INTO
		c,
		s
	;
	
	process_loop : LOOP
		IF done = TRUE THEN
			LEAVE process_loop;
		END IF;

		SET temp_string = CONCAT(temp_string, "Average salary in ", c, " is ", s, ".\n");

		FETCH NEXT FROM cursor_avg_salary INTO
			c,
			s
		;
	END loop;
	SET salary_list = temp_string;
	
	CLOSE cursor_avg_salary;
END$$

DELIMITER ;
CALL `find_avg_salarys`(@salary_list);
SELECT @salary_list AS print;

-- Part 3 Create change_city procedure
-- Function will go into the lives table and change
-- the current city to new_city for those that
-- matches the person_id
DROP PROCEDURE IF EXISTS change_city;

DELIMITER $$
CREATE PROCEDURE change_city (
	IN person_id INTEGER,
	IN new_city VARCHAR(30)
)
BEGIN
	UPDATE lives
		SET city = new_city
		WHERE lives.person_id = person_id
	;
END$$
DELIMITER ;
CALL `change_city`(1, "Chicago");
SELECT * FROM lives;

CALL `change_city`(1, "Las Vegas");

SELECT * FROM lives;
SELECT * FROM works;
SELECT * FROM located_in;
SELECT * FROM manages;
