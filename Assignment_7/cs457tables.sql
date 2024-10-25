DROP DATABASE if EXISTS cs457;
CREATE DATABASE cs457;
USE cs457;

CREATE TABLE lives (
	person_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	person_name VARCHAR(50) NOT NULL,
	street VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	PRIMARY KEY (person_id)
);


CREATE TABLE works (
	person_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	person_name VARCHAR(50) NOT NULL,
	company_name VARCHAR(50) NOT NULL,
	salary INT,
	PRIMARY KEY (person_id)
);


CREATE TABLE located_in (
	company_name VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL, 
	PRIMARY KEY (company_name, city)
);


CREATE TABLE manages (
	person_name VARCHAR(50) NOT NULL,
	manager_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (person_name, manager_name)
);
	