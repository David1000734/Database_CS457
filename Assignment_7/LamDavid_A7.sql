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
	SELECT city, AVG(salary)
	FROM workers_by_city AS tb
	GROUP BY city
	ORDER BY salary DESC
;
SELECT * FROM avg_city_salary;


SELECT * FROM lives;
SELECT * FROM works;
SELECT * FROM located_in;
SELECT * FROM manages;
