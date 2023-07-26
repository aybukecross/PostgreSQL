CREATE TABLE sairler(
	id int,
	name varchar(30),
	email varchar(30)
);

INSERT INTO sairler VALUES(
	1001,
	'Can Yücel',
	'sairler@gmail.com'
);

SELECT * FROM sairler

INSERT INTO sairler VALUES(
	1002,
	'Selma Yücel',
	'selma@gmail.com'
);

SELECT * FROM sairler

INSERT INTO sairler VALUES(
	1003,
	'',
	'untitle@gmail.com'
);

SELECT * FROM sairler

INSERT INTO sairler(name) VALUES(
	'Null Values'
);

SELECT * FROM sairler

-----------------------------------

CREATE TABLE developers(
	id SERIAL,
	name VARCHAR(50),
	email VARCHAR(50) UNIQUE,
	salary REAL,
	prog_lang VARCHAR(50)
);

SELECT * FROM developers

INSERT INTO developers(name,email,salary,prog_lang) VALUES(
	'Mehmet',
	'mehmet@gmail.com',
	4999.99,
	'JAVA'
);

SELECT * FROM developers

INSERT INTO developers(name,email,salary,prog_lang) VALUES(
	'Ekim',
	'ekim@gmail.com',
	3999.99,
	'C#'
);

SELECT * FROM developers

INSERT INTO developers(name,email,salary,prog_lang) VALUES(
	'Tezcan',
	'tezcan@gmail.com',
	2999.99,
	'Python'
);

SELECT * FROM developers

CREATE TABLE doctors(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) UNIQUE,
	salary REAL
);

INSERT INTO doctors(name,email,salary) VALUES(
	'Sedat',
	'sedat@gmail.com',
	6999.99
);

SELECT * FROM doctors

-----------------------------------------------

CREATE TABLE students(
	id int PRIMARY KEY,
	name varchar(50),
	grade real,
	register_date date
);

SELECT * FROM students

CREATE TABLE students2(
	id int,
	name varchar(50) NOT NULL,
	grade real,
	register_date date,
	CONSTRAINT std_pk PRIMARY KEY(id)
);

SELECT * FROM students2

CREATE TABLE students3(
	id int,
	name varchar(50) NOT NULL,
	grade real,
	register_date date,
	CONSTRAINT std1_pk PRIMARY KEY(id,name)
);

SELECT * FROM students3

CREATE TABLE students(
	id int PRIMARY KEY,
	name varchar(50),
	grade real,
	register_date date
);

SELECT * FROM students

CREATE TABLE students2(
	id int,
	name varchar(50) NOT NULL,
	grade real,
	register_date date,
	CONSTRAINT std_pk PRIMARY KEY(id)
);

SELECT * FROM students2

CREATE TABLE students4(
	id int,
	name varchar(50) NOT NULL,
	grade real,
	register_date date,
	CONSTRAINT std3_pk PRIMARY KEY(id)
);

SELECT * FROM students3

CREATE TABLE address4(
	address_id int,
	street varchar(50),
	city varchar(50),
	student_id int,
	CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students4(id)	
);

SELECT * FROM address4

-------------------------------------------------------------

CREATE TABLE personel(
	id int,
	name varchar(50) NOT NULL CHECK(name <> ''),
	salary real CHECK(salary>5000),
	age int CHECK(age>0)
);

--INSERT INTO personel VALUES(1,'',10000,25);
--INSERT INTO personel VALUES(2,'name',1000,25);
--INSERT INTO personel VALUES(3,'name',10000,-5);
INSERT INTO personel VALUES(4,'Ali Can',10000,25);

SELECT * FROM personel