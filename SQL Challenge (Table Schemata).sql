--Drop any existing tables
DROP TABLE IF EXISTS Departments,
	Department_Manager,
	Department_Employees,
	Salaries, 
	Employees,
	Titles;

--Create all the tables based on the .CSVs
CREATE TABLE Departments (
	dept_no varchar(4),
	dept_name varchar,
	PRIMARY KEY (dept_name)
);

---------------------------------------------------------------------------------------------------
CREATE TABLE Department_Manager (
	dept_no varchar(4),
	emp_no varchar(6),
	PRIMARY KEY (dept_no)
);

---------------------------------------------------------------------------------------------------
CREATE TABLE Titles (
	title_id varchar(5),
	title varchar,
	PRIMARY KEY (title_id)
);

---------------------------------------------------------------------------------------------------
CREATE TABLE Employees (
	emp_no varchar(6),
	emp_title_id varchar(5) REFERENCES Titles(title_id),
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar(1),
	hire_date date,
	PRIMARY KEY (emp_no)
);
	
---------------------------------------------------------------------------------------------------
CREATE TABLE Department_Employees (
	emp_no varchar(6) REFERENCES Employees(emp_no),
	dept_no varchar(4),
	PRIMARY KEY (emp_no)
);

---------------------------------------------------------------------------------------------------
CREATE TABLE Salaries (
	emp_no varchar(6) REFERENCES Employees(emp_no),
	salary integer,
	PRIMARY KEY (salary)
);
SELECT *
FROM Salaries;