select * from employees;

-- Display all information where job title President, Sales Manager, Finance Manager
select * from jobs
where job_title = 'President' or job_title = 'Sales Manager' or job_title = 'Finance Manager';

select * from jobs
where job_title IN ('President', 'Sales Manager', 'Finance Manager');


-- Display all Department that does not have manager_id in departments table
select * from DEPARTMENTS
where MANAGER_ID is null;

-- Display all locations in US or UK from locations table
select * from LOCATIONS
where COUNTRY_ID IN ('US', 'UK');

-- Display all locations NOT in US or UK from locations table
select * from LOCATIONS
where COUNTRY_ID NOT IN ('US', 'UK');

-- Display all Countries in Region_ID of 1 and Country_Name not Belgium
select * from COUNTRIES
where REGION_ID=1 and COUNTRY_NAME <> 'Belgium'; -- <> is same as !=

-- 19. Display all employees who does not work in any one of these dept 90, 60, 100, 130, 110
select * from EMPLOYEES
where DEPARTMENT_ID not in (90, 60, 100, 110, 130);


-- NEW TOPIC --

/*
 ORDER BY keyword: will sort our data based on provided column
 Default: asc: Ascending order --> 0-9 and A-Z
 dsc: Descending Order --> 9-0 and A-Z
 */

-- Display all info based on who is making more salary to low salary
select * from EMPLOYEES
order by salary desc;

-- Display all info based on who is making low salary to high
select * from EMPLOYEES
order by salary;

select * from EMPLOYEES
order by salary asc;

-- Also we can sort based on index number of the COLUMN NAME: Salary
select * from EMPLOYEES
order by 8 asc;

select email from EMPLOYEES
order by 1 asc; --This cannot be run because for index number, info comes from the * sign
                -- index number needs to be as least as the column number

-- Display all info from employees where employee_id < 110 based on firstname in alphabetical order
select * from EMPLOYEES
where EMPLOYEE_ID<110
order by FIRST_NAME asc; -- no need to put asc, because it's already the default

-- Display all info from employees based on firstname asc and last name desc
select * from EMPLOYEES
order by FIRST_NAME asc, LAST_NAME desc; -- ascends the firstname, descends the lastname


/*
 LIKE
 -- wildcard characters

 _ --> any character (refers only one char) --> so B_ can only be 2 letters
 % --> any sequence (refers 0 or more chars) --> B% this can be any length

    --contains
    --startsWith
    --endsWith

 ILIKE : same function without case sensitivity
 */

-- Display all employees whose firstname starts with B
select * from EMPLOYEES
where FIRST_NAME LIKE 'B%';

-- Display all employees whose firstname starts with B and has 5 letters
select * from EMPLOYEES
where FIRST_NAME LIKE 'B____';

-- Display 5 letter names where the middle char is z
select * from EMPLOYEES
where FIRST_NAME LIKE '__z__';

-- ^
select * from EMPLOYEES
where FIRST_NAME LIKE '%z%';

--Display all records whose lat name has 5 letter
select * from EMPLOYEES
where LAST_NAME LIKE '_____';

--Display first name where second char is a
select * from EMPLOYEES
where FIRST_NAME LIKE '_a%';

--Display all emps whose firstname ends with l
select * from EMPLOYEES
where FIRST_NAME LIKE '%l';

--Display any job info with JOB_TITLE end with Manager
select * from JOBS
where JOB_TITLE LIKE '%Manager';

/*
 AGGREGATE Functions --MULTI ROW Functions
 -- Takes multiple input and gives back only ony output (result)

 1) COUNT keyword : put whatever info you want inside ()
 -- Aggregates don't see null values

 */

-- how many employees do we have?
select count(*) from EMPLOYEES;

-- how many unique firstnames do we have?
select count(distinct FIRST_NAME) from EMPLOYEES;

-- how many employees work as 'IT_PROG' or 'SA_REP'
select count(FIRST_NAME) from EMPLOYEES
where JOB_ID IN ('IT_PROG', 'SA_REP');

-- how many employees we have with dept id is null
select count(*) from EMPLOYEES
where DEPARTMENT_ID is null;

-- aggregates will ignore null values
select count(DEPARTMENT_ID) from EMPLOYEES
where DEPARTMENT_ID is null;

-- MIN
-- get me min salary from employees
select min(SALARY) from EMPLOYEES;

-- MAX
-- get me max salary from employees
select max(SALARY) from EMPLOYEES;

-- AVERAGE
-- get me avg salary from employees
select AVG(SALARY) from EMPLOYEES; -- use aggregate function ROUND for a result with no decimal value
select round(AVG(SALARY),1) from EMPLOYEES; --6461.8
select round(AVG(SALARY),2) from EMPLOYEES; --6461.83
select round(AVG(SALARY),3) from EMPLOYEES; --6461.832

-- SUM
-- get me total salary from employees
select SUM(SALARY) from EMPLOYEES;





select distinct JOB_ID from EMPLOYEES;

-- Display average salary for 'IT_PROG'
select AVG(SALARY) from EMPLOYEES
where JOB_ID='IT_PROG';

-- Display average salary for 'SA_REP'
select AVG(SALARY) from EMPLOYEES
where JOB_ID='SA_REP';

-- Display average salary for 'MK_MAN'
select AVG(SALARY) from EMPLOYEES
where JOB_ID='MK_MAN';

select * from EMPLOYEES;

-- Display average salary for each job ID
select JOB_ID, AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) from EMPLOYEES
group by JOB_ID;

-- Display sum(salary) of each department in Employees Table
select DEPARTMENT_ID, SUM(SALARY) from EMPLOYEES
group by DEPARTMENT_ID;

-- Display sum(salary) and max(salary) of each department in Employees Table
select DEPARTMENT_ID, SUM(SALARY), max(SALARY) from EMPLOYEES
group by DEPARTMENT_ID;

-- Display sum(salary) and avg(salary) and min(salary) of each department in Employees Table
select DEPARTMENT_ID, SUM(SALARY), ROUND( AVG(SALARY) ), MIN(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID;

-- Display job_ids and avg salaries where their salary is more than 5K
select JOB_ID, AVG(SALARY) from EMPLOYEES
where SALARY > 5000
group by JOB_ID;

-- BAD PRACTICE
select JOB_ID, AVG(SALARY) from EMPLOYEES
where SALARY > 5000
group by JOB_ID;

-- CORRECT PRACTICE: HAVING function --> sorts after the math is done
select JOB_ID, AVG(SALARY) from EMPLOYEES
GROUP BY JOB_ID
HAVING avg(SALARY) > 5000;


-- Display department_id where employees count bigger than 5
select DEPARTMENT_ID, count(*) from EMPLOYEES
group by DEPARTMENT_ID
having  count(*)>5;

-- Display duplicate names in employee table
select FIRST_NAME, count(*) from EMPLOYEES
group by FIRST_NAME
having count(*)>1;
