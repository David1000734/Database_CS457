DROP DATABASE if EXISTS cs457;
CREATE DATABASE cs457;
USE cs457;

CREATE TABLE lives (
	person_id SMALLINT UNSIGNED,
	person_name VARCHAR(50),
	street VARCHAR(50),
	city VARCHAR(50),
	PRIMARY KEY (person_id)
);


CREATE TABLE works (
	person_id SMALLINT UNSIGNED,
	person_name VARCHAR(50),
	company_name VARCHAR(50),
	salary INT,
	PRIMARY KEY (person_id)
);


CREATE TABLE located_in (
	company_name VARCHAR(50),
	city VARCHAR(50), 
	PRIMARY KEY (company_name, city)
);


CREATE TABLE manages (
	person_name VARCHAR(50),
	manager_name VARCHAR(50),
	PRIMARY KEY (person_name, manager_name)
);
	