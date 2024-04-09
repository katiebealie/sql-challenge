-- erd schema
employees
-
emp_no PK int 
emp_title_id string FK >- titles.title_id
birth_date string
first_name string
last_name string
sex varchar
hire_date varchar

departments
-
dept_no PK varchar
dept-name varchar

dept_emp
-
emp_no PK int FK >- employees.emp_no
dept_no PK varchar FK >- departments.dept_no

dept_manager
-
dept_no PK varchar FK >- departments.dept_no
emp_no PK int FK >- employees.emp_no

salaries
-
emp_no PK int FK >- employees.emp_no
salary int

titles
-
title_id PK varchar
title varchar