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


-------------------------------------------------------------------------------------------------
-- Join the multiple tables into one table for Data AnaLYSIS

--Columns: emp_no, last_name, first_name, sex, and salary of each employee
--Tables: Employees, Salaries
SELECT Employees.emp_no, 
	Employees.last_name, 
	Employees.first_name,  
	Employees.sex, 
	Salaries.salary
FROM Salaries
INNER JOIN Employees ON
	Employees.emp_no = Salaries.emp_no;
	
--Columns: first_name, last_name,and hire date for employees who were hired in 1986
--Tables: Employees 
--Do not use ""(SQL looks for column) only use ''(refers to value in column)
SELECT Employees.first_name, 
	Employees.last_name, 
	Employees.hire_date
FROM Employees
WHERE hire_date BETWEEN '01/01/1986' AND '12/31/1986'
ORDER BY hire_date;

--Columns: dept_manager, dept_no, dept_name, emp_no, last_name, and first_name
--Tables: Employees, Department Manager, Departments
SELECT Department_Manager.dept_no,
	Departments.dept_name, 
	Department_Manager.emp_no,
	Employees.last_name, 
	Employees.first_name
FROM Department_Manager
JOIN Employees ON
	Employees.emp_no = Department_Manager.emp_no
JOIN Departments ON
	Departments.dept_no = Department_Manager.dept_no
ORDER BY dept_name;

-- Columns: dept_no, emp_no, last_name, first_name, and dept_name
-- Tables:Department_Employees, Employees, Departments
SELECT Department_Employees.dept_no,
	Department_Employees.emp_no,
	Employees.last_name,
	Employees.first_name,
	Departments.dept_name
FROM Employees
JOIN Department_Employees ON
	Employees.emp_no = Department_Employees.emp_no
JOIN Departments ON
	Departments.dept_no = Department_Employees.dept_no;
	
-- Columns: first_name, last_name, sex of "Hercules" & last name that starts with "B"
-- Tables: Employees
SELECT Employees.first_name, 
	Employees.last_name,
	Employees.sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name;

-- Columns: dept_name, emp_no, last_name, and first_name
-- Tables: Departments=Sales, Employees, Department_Employees
SELECT Employees.emp_no,
	Employees.last_name,
	Employees.first_name
FROM Employees
JOIN Department_Employees ON
	Employees.emp_no = Department_Employees.emp_no
JOIN Departments ON
	Department_Employees.dept_no = Departments.dept_no
WHERE dept_name = 'Sales';

-- Columns: dept_name, emp_no, last_name, and first_name
-- Tables: Departments=Sales&Departments, Employees, Department_Employees
SELECT Employees.emp_no,
	Employees.last_name,
	Employees.first_name,
	Departments.dept_name
FROM Employees
JOIN Department_Employees ON
	Employees.emp_no = Department_Employees.emp_no
JOIN Departments ON
	Department_Employees.dept_no = Departments.dept_no
WHERE dept_name = 'Sales' OR dept_name ='Development'
ORDER BY Departments.dept_name;

--List the frequency counts in descending order of employees who share the same last name
SELECT last_name, count(first_name) as num_employees_same_name
FROM Employees
GROUP BY last_name
ORDER BY num_employees_same_name DESC;