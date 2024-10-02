DROP DATABASE IF EXISTS corp_example;

CREATE DATABASE corp_example;

USE corp_example;

DROP TABLE IF EXISTS corporation;

CREATE TABLE corporation
  (corp_id SMALLINT,
  name VARCHAR(30),
  CONSTRAINT pk_corporation PRIMARY KEY (corp_id)
);

INSERT INTO corporation
  (corp_id, NAME)
  VALUES (1717, 'Botan');

SHOW DATABASES;
SHOW TABLES;
SELECT * FROM corporation;