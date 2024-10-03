DROP DATABASE IF EXISTS LamDavid;

CREATE DATABASE LamDavid;

USE LamDavid;

/* Drop and create tables */
DROP TABLE IF EXISTS lives;
CREATE TABLE lives
  (person_id SMALLINT(4) ZEROFILL,
  person_name VARCHAR(30),
  street VARCHAR(30),
  city VARCHAR(30),
  CONSTRAINT people_living PRIMARY KEY (person_id)
);

DROP TABLE IF EXISTS works;
CREATE TABLE works
  (person_id SMALLINT(4) ZEROFILL,
  person_name VARCHAR(30),
  company_id SMALLINT(4) ZEROFILL,
  company_name VARCHAR(30),
  salary INT,
  CONSTRAINT people_working PRIMARY KEY (person_id)
);

DROP TABLE IF EXISTS located_in;
CREATE TABLE located_in
  (company_name VARCHAR(30),
  city VARCHAR(30),
  CONSTRAINT located PRIMARY KEY (company_name)
);

DROP TABLE IF EXISTS manages;
CREATE TABLE manages
  (person_name VARCHAR(30),
  manager_name VARCHAR(30),
  CONSTRAINT manages PRIMARY KEY (person_name)
);

/* Insert values into tables */

-- Insert values into the lives table
INSERT INTO lives
  (person_id, person_name, street, city)
  VALUES (0001, 'George Washington', '13th', 'New York City');

INSERT INTO lives
  (person_id, person_name, street, city)
  VALUES (0002, 'John Adams', 'Decatur', 'Las Vegas');
  
INSERT INTO lives
  (person_id, person_name, street, city)
  VALUES (0003, 'Thomas Jefferson', 'Gilespie', 'Seattle');

-- Insert values into works table
INSERT INTO works
  (person_id, person_name, company_id, company_name, salary)
  VALUES (0001, 'George Washington', 0001, 'TreeCorp', 54000);

INSERT INTO works
  (person_id, person_name, company_id, company_name, salary)
  VALUES (0002, 'John Adams', 0002, 'Fountain Pens', 40000);

INSERT INTO works
  (person_id, person_name, company_id, company_name, salary)
  VALUES (0003, 'Thomas Jefferson', 0003, 'Fountain Pens', 43000);

-- Insert values into located_in
INSERT INTO located_in
  (company_name, city)
  VALUES ('Tree Corp', 'New York City');

INSERT INTO located_in
  (company_name, city)
  VALUES ('Fountain Pens', 'New Orleans');

INSERT INTO located_in
  (company_name, city)
  VALUES ('Urns R Us', 'Las Vegas');

-- Insert values into manages
INSERT INTO manages
  (person_name, manager_name)
  VALUES ('John Adams', 'Thomas Jefferson');

SHOW DATABASES;
SHOW TABLES;
SELECT * FROM lives;
SELECT * FROM works;
SELECT * FROM located_in;
SELECT * FROM manages;
