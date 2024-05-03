CREATE TABLE Departments( 
	dept_no VARCHAR(10) PRIMARY KEY,
	dept_name VARCHAR (50)  NOT NULL
);


CREATE TABLE Titles (
  title_id VARCHAR(10) PRIMARY KEY,
  title VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Employees (
  emp_no INT PRIMARY KEY,
  emp_title_id VARCHAR(10)NOT NULL,
  birth_date DATE NOT NULL,
  first_name VARCHAR(20)NOT NULL,
  last_name VARCHAR(20)NOT NULL,
  sex VARCHAR(5)NOT NULL,
  hire_date DATE NOT NULL,
  FOREIGN KEY (emp_title_id) REFERENCES Titles (title_id)
);



CREATE TABLE Dept_emp(
	emp_no INT, 
	dept_no VARCHAR(50) NOT NULL, 
	PRIMARY KEY (emp_no, dept_no),
  	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
  	FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
);


CREATE TABLE Dept_manager (
  dept_no VARCHAR(10),
  emp_no INT PRIMARY KEY,
  FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
);

	
CREATE TABLE Salaries (
  emp_no INT,
  salary INT NOT NULL,
  PRIMARY KEY (emp_no),
  FOREIGN KEY (emp_no) REFERENCES Employees (emp_no) 
);
----List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, sal.salary 
	FROM employees  AS e
	JOIN Salaries AS sal
	ON e.emp_no =   sal.emp_no;
-----List the first name, last name, and hire date for the employees who were hired in 1986.		
SELECT  first_name, last_name, hire_date
	FROM employees
	WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';


--List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.	
SELECT dptm.dept_no,dpt.dept_name,dptm.emp_no,e.last_name,e.first_name
	FROM dept_manager AS dptm
	JOIN departments AS dpt
	ON dptm.dept_no = dpt.dept_no
	Join employees AS e
	ON dptm.emp_no = e.emp_no;


--List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name
SELECT dpte.dept_no,dpte.emp_no,e.last_name,e.first_name,dpt.dept_name
	FROM dept_emp AS dpte
	JOIN employees AS e
	ON dpte.emp_no = e.emp_no
	JOIN departments AS dpt
	ON dpte.dept_no = dpt.dept_no;	
	
	
--List first name, last name, and sex of each employee whose first name is Hercules and	
--whose last name begins with the letter B.	
SELECT  first_name, last_name, sex 
	from employees 		
	Where first_name = 'Hercules'	
	AND last_name lIKE 'B%'


--List each employee in the Sales department, including their employee number,
--last name, and first name.

SELECT dpte.emp_no,e.last_name,e.first_name
	FROM dept_emp AS dpte
	JOIN employees AS e
	ON dpte.emp_no = e.emp_no
	JOIN departments AS dpt
	ON dpte.dept_no = dpt.dept_no
	WHERE dpt.dept_name = 'Sales';

--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT dpte.emp_no,e.last_name,e.first_name,dpt.dept_name
	FROM dept_emp AS dpte
	JOIN employees AS e
	ON dpte.emp_no = e.emp_no
	JOIN departments AS dpt
	ON dpte.dept_no = dpt.dept_no
	WHERE dpt.dept_name = 'Sales' OR dpt.dept_name ='Development';

--List the frequency counts, in descending order, of all the employee last names! 
--(that is, how many employees share each last name).

SELECT last_name, COUNT(*) as freq_count
	FROM Employees
	GROUP BY last_name
	ORDER BY freq_count DESC;	
	
