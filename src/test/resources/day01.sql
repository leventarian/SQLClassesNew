select * from employees;

SELECT * FROM EMPLOYEES;

-- This is single line commands
/*
Multi line commands
*/

/*
SELECT KEYWORD
-- SQL is case insensitive
-- refers all column all data from related table/s
*/


-- get me all departments table information
select * from departments;


-- get me first name from employees;
select first_name from employees;

-- get me firstname and salary from employees
select first_name, salary from employees;

-- get me firstname, lastname and salary from employees
select first_name, last_name, salary from employees;

/*
 0. Display all information from department table
 1. Display city names from locations
 2. Display country name and region id from countries
 3. Display job_id and job title from jobs
 4. Display street address and postal code from locations
 */

 --4. Display street address and postal code from locations
select STREET_ADDRESS, POSTAL_CODE from LOCATIONS;

/*
 DISTINCT KEYWORD: removes duplicates from your request results
 Original data(with DUPs still in Database)
 */
 -- get me unique firstname from eployees
 select distinct FIRST_NAME from EMPLOYEES;

-- get me unique job_ids from employees
select distinct JOB_ID from EMPLOYEES;

-- get me unique country ids from locations
select distinct COUNTRY_ID from LOCATIONS;

-- WHERE keyword
-- we use where to filter our results after getting response from database

-- get me firstname, lastname, salary where firstname is David
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where FIRST_NAME = 'David';

-- '' is case SENSITIVE

-- get me firstname, lastname, salary where firstname is David and lastname is Lee
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where FIRST_NAME = 'David' and LAST_NAME = 'Lee';

-- get me all information who is making salary more than 6000
select * from EMPLOYEES
where SALARY>6000;

-- get me all information who is making salary less than or equal to 6000
select * from EMPLOYEES
where SALARY<=6000;

--get me email who is making salary less than and equal 6000
select EMAIL from EMPLOYEES
where SALARY<=6000;

--Any relation between email and salary? NO

--Display firstname, salary, who is making salary more than 7000 and department id is 80
select FIRST_NAME, SALARY from EMPLOYEES
where SALARY>7000 and DEPARTMENT_ID=80;

-- get me firstname, lastname who is making salary more than 3000 and less than 6000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where SALARY>3000 and SALARY<6000;

-- get me firstname, lastname who is making salary more than 3000 and less than 6000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where SALARY>=3000 and SALARY<=6000;

-- BETWEEN lower AND higher
-- get me firstname, lastname who is making salary more than 3000 and less than 6000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where SALARY between 3000 and 6000;

-- get me all information who is working as 'IT_PROG' or 'SA_REP'
select * from EMPLOYEES
where JOB_ID='IT_PROG' or JOB_ID='SA_REP';


-- IN CLAUSES: it uses or logic with comma
select * from EMPLOYEES
where JOB_ID IN ('IT_PROG','SA_REP');


-- NOT IN
select * from EMPLOYEES
where JOB_ID NOT IN ('IT_PROG','SA_REP');


-- Display city of where country id, IT, US, UK
select city from LOCATIONS
where COUNTRY_ID IN('US', 'IT', 'UK');

-- Display all information where employee_id 134, 123, 145, 146
select * from EMPLOYEES
where EMPLOYEE_ID IN(123,134,145,146);

-- Display all information for employees whose dept id IS null
select * from EMPLOYEES
where DEPARTMENT_ID IS NULL;

-- Display all information for employees who dept IS NOT null
select * from EMPLOYEES
where DEPARTMENT_ID IS NOT NULL;








