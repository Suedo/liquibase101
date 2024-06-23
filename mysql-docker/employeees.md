## Employee Table

| employee_id | first_name | last_name | email                       | phone_number | hire_date  | job_id | salary   | manager_id | department_id |
| ----------- | ---------- | --------- | --------------------------- | ------------ | ---------- | ------ | -------- | ---------- | ------------- |
| 1           | John       | Doe       | john.doe@example.com        | 123-456-7890 | 2020-01-15 | DEV    | 60000.00 |            | 1             |
| 2           | Jane       | Smith     | jane.smith@example.com      | 234-567-8901 | 2019-03-23 | HR     | 75000.00 |            | 2             |
| 3           | Robert     | Brown     | robert.brown@example.com    | 345-678-9012 | 2021-11-04 | DEV    | 50000.00 | 1          | 1             |
| 4           | Emily      | Davis     | emily.davis@example.com     | 456-789-0123 | 2018-07-19 | MKT    | 55000.00 |            | 3             |
| 5           | Michael    | Wilson    | michael.wilson@example.com  | 567-890-1234 | 2020-02-12 | FIN    | 70000.00 | 2          | 4             |
| 6           | Jessica    | Taylor    | jessica.taylor@example.com  | 678-901-2345 | 2019-09-30 | HR     | 68000.00 | 2          | 2             |
| 7           | David      | Anderson  | david.anderson@example.com  | 789-012-3456 | 2017-12-21 | DEV    | 75000.00 | 3          | 1             |
| 8           | Sarah      | Thomas    | sarah.thomas@example.com    | 890-123-4567 | 2021-05-10 | MKT    | 60000.00 |            | 3             |
| 9           | James      | Martinez  | james.martinez@example.com  | 901-234-5678 | 2018-04-14 | FIN    | 72000.00 | 4          | 4             |
| 10          | Laura      | Hernandez | laura.hernandez@example.com | 012-345-6789 | 2020-06-09 | DEV    | 58000.00 | 1          | 1             |
| 11          | Chris      | Moore     | chris.moore@example.com     | 123-456-7890 | 2019-01-25 | HR     | 65000.00 | 2          | 2             |
| 12          | Ashley     | Jackson   | ashley.jackson@example.com  | 234-567-8901 | 2017-11-18 | MKT    | 70000.00 |            | 3             |
| 13          | Brian      | White     | brian.white@example.com     | 345-678-9012 | 2021-08-07 | FIN    | 75000.00 | 5          | 4             |
| 14          | Emma       | Harris    | emma.harris@example.com     | 456-789-0123 | 2018-03-02 | DEV    | 64000.00 | 3          | 1             |
| 15          | Daniel     | Martin    | daniel.martin@example.com   | 567-890-1234 | 2019-06-15 | HR     | 68000.00 | 2          | 2             |
| 16          | Olivia     | Lee       | olivia.lee@example.com      | 678-901-2345 | 2020-10-22 | MKT    | 60000.00 |            | 3             |
| 17          | Matthew    | Walker    | matthew.walker@example.com  | 789-012-3456 | 2017-09-12 | FIN    | 70000.00 | 6          | 4             |
| 18          | Sophia     | Hall      | sophia.hall@example.com     | 890-123-4567 | 2018-12-05 | DEV    | 75000.00 | 1          | 1             |
| 19          | Andrew     | Allen     | andrew.allen@example.com    | 901-234-5678 | 2021-03-28 | HR     | 72000.00 | 2          | 2             |
| 20          | Ava        | Young     | ava.young@example.com       | 012-345-6789 | 2020-07-19 | MKT    | 68000.00 |            | 3             |

## Intermediate level commands

```sql
-- -----------------------------------------------------
-- case statements
-- -----------------------------------------------------

-- simple
SELECT e.employee_id , e.department_id, e.salary,
case
	when e.salary < 64000 then 'low'
	when e.salary between 64000 and 70000 then 'mid'
	when e.salary > 70000 then 'high'
end salaryGroup
from employees e ;


-- give developers 10% hike, and finance 12%
SELECT e.employee_id , e.first_name , e.salary old_salary,
CASE
	when e.job_id = 'DEV' then salary * 1.1
	when e.job_id = 'FIN' then salary * 1.12
	else e.salary
END new_salary
from employees e ;


-- -----------------------------------------------------
-- string functions
-- -----------------------------------------------------

SELECT TRIM('   abcd   ') val
union
SELECT LTRIM('   abcd   ') val
union
SELECT RTRIM('   abcd   ') val;


SELECT first_name, last_name, LEFT(first_name, 3), RIGHT(last_name, 3), CONCAT(first_name, last_name) comb, SUBSTRING(CONCAT(first_name, last_name), 2, 5)
from employees;



SELECT first_name , REPLACE(first_name, 'a', 'z')
from employees;


SELECT first_name , LOCATE('a', first_name)
from employees;


-- -----------------------------------------------------
-- window functions
-- -----------------------------------------------------

-- Assigns a unique sequential integer to rows within each department based on the hire date.
SELECT employee_id, first_name, last_name, department_id, hire_date,
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date) rowNumber
FROM employees;

-- Assigns ranks to employees within each department based on their salary, with gaps for ties.
SELECT employee_id, first_name, last_name, department_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salaryrank
FROM employees;

-- DENSE_RANK Assigns ranks to employees within each department based on their salary, without gaps for ties
SELECT employee_id, first_name, last_name, department_id, salary,
	RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS gaprank,
	DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS denserank
FROM employees;

-- NTILE: Divides employees within each department into four roughly equal groups based on hire date.
SELECT employee_id, first_name, last_name, department_id, hire_date,
       NTILE(4) OVER (PARTITION BY department_id ORDER BY hire_date) AS bucket
FROM employees;

-- LAG: Retrieves the salary of the previous employee within the same department, based on hire date.
-- LEAD: Retrieves the salary of the next employee within the same department, based on hire date.
SELECT employee_id, first_name, last_name, department_id, hire_date, salary,
       LAG(salary, 1, 0) OVER (PARTITION BY department_id ORDER BY hire_date) AS salarylag,
       LEAD(salary, 1, 0) OVER (PARTITION BY department_id ORDER BY hire_date) AS salarylead
FROM employees;


-- FIRST_VALUE: Returns the first salary in each department when ordered by hire date.
SELECT employee_id, first_name, last_name, department_id, hire_date, salary,
       FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS firstvalue
FROM employees;

-- LAST_VALUE: Returns the last salary in each department when ordered by hire date.
SELECT employee_id, first_name, last_name, department_id, hire_date, salary,
       LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lastvalue1,
       -- LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS lastvalue2 -- does nothing
FROM employees;

-- NTH_VALUE: Returns the second salary within each department when ordered by hire date.
SELECT employee_id, first_name, last_name, department_id, hire_date, salary,
       NTH_VALUE(salary, 2) OVER (PARTITION BY department_id ORDER BY hire_date) AS nthvalue
FROM employees;


-- find the top 3 highest salary getter per department
-- nth value per department
WITH ranked AS (
    SELECT employee_id, first_name, last_name, department_id, salary,
        DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
    FROM employees
)
SELECT employee_id, first_name, last_name, department_id, salary, salary_rank
FROM ranked
WHERE salary_rank <= 3;

```
