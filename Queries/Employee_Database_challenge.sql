-- Challenge Module 7 Challenge Pewlett-Hackard-Analysis

-- Deliverable 1: The Number of Retiring Employees by Title


-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- Retrieve the title, from_date, and to_date columns from the Titles table.
-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
-- Export the Retirement Titles table from the previous step as retirement_titles.csv

SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM dep_emp;


SELECT 	e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Retrieve the employee number, first and last name, and title columns from the Retirement Titles table
-- Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'
-- Create a Unique Titles table using the INTO clause
-- Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
-- Export the Unique Titles table as unique_titles.csv


SELECT DISTINCT ON (emp_no)		emp_no,
								first_name,
								last_name,
								title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;


-- Retrieve the number of titles from the Unique Titles table.
-- Create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.
-- Export the Retiring Titles table as retiring_titles.csv

SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


-- Deliverable 2: The Employees Eligible for the Mentorship Program


-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Create a new table using the INTO clause.
-- Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key.
-- Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
-- Order the table by the employee number.
-- Export the Mentorship Eligibility table as mentorship_eligibilty.csv

SELECT DISTINCT ON (emp_no)	e.emp_no,
							e.first_name,
							e.last_name,
							e.birth_date,
							d.from_date,
							d.to_date,
							t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dep_emp AS d
ON (e.emp_no = d.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (d.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;
