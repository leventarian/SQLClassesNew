            --DISTINCT--
-- get me UNIQUE firstname from employees
select distinct FIRST_NAME from EMPLOYEES;

            --WHERE--
-- using case sensitive ''
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where FIRST_NAME = 'David' and LAST_NAME = 'Lee';

--conditional operators: =, <, >, <> (not equal), != (not equal), AND, OR
select EMAIL from EMPLOYEES
where SALARY<=6000;

select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where SALARY>=3000 and SALARY<=6000;

            -- BETWEEN-- lower AND higher
-- get me firstname, lastname who is making salary more than 3000 and less than 6000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
where SALARY between 3000 and 6000;

-- OR logic
select * from EMPLOYEES
where JOB_ID='IT_PROG' or JOB_ID='SA_REP';

            --IN CLAUSES-- it uses OR logic with comma
select * from EMPLOYEES
where JOB_ID IN ('IT_PROG','SA_REP');

            --NOT IN--
select * from EMPLOYEES
where JOB_ID NOT IN ('IT_PROG','SA_REP');

            --NULL and NOT NULL clauses--
select * from EMPLOYEES
where DEPARTMENT_ID IS NOT NULL;

            --ORDER BY--
select * from EMPLOYEES
order by salary;

select * from EMPLOYEES
order by salary desc;

-- Also we can sort based on index number of the COLUMN NAME: Salary
select * from EMPLOYEES
order by 8 asc;

select email from EMPLOYEES
order by 1 asc; --This cannot be run because for index number, info comes from the * sign
                --index number needs to be as least as the column number

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

--Display first name where second char is a
select * from EMPLOYEES
where FIRST_NAME LIKE '_a%';


/*
 AGGREGATE Functions --MULTI ROW Functions
 -- Takes multiple input and gives back only ony output (result)

 1) COUNT keyword : put whatever info you want inside ()
 -- Aggregates don't see null values

 */

-- how many unique names work as 'IT_PROG' or 'SA_REP'
select count(distinct FIRST_NAME) from EMPLOYEES
where JOB_ID IN ('IT_PROG', 'SA_REP');

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

-- Display average salary for 'SA_REP'
select AVG(SALARY) from EMPLOYEES
where JOB_ID='SA_REP';

            --GROUP BY--
--The group by clause divides the rows retrieved from select statement into group based on the row we provide
--GROUP BY can only be used along with group / aggregate / multi row functions.
--It groups all same data into one row
--Queries groups all the record based on their job id so that we can implement aggregate functions to each group
--EACH is the KEYWORD

-- Display average salary for each job ID
select JOB_ID, AVG(SALARY), MIN(SALARY), MAX(SALARY), COUNT(*) from EMPLOYEES
group by JOB_ID;

-- Display sum(salary) and max(salary) of each department in Employees Table
select DEPARTMENT_ID, SUM(SALARY), max(SALARY) from EMPLOYEES
group by DEPARTMENT_ID;

-- Display sum(salary) and avg(salary) and min(salary) of each department in Employees Table
select DEPARTMENT_ID, SUM(SALARY), ROUND( AVG(SALARY) ), MIN(SALARY) from EMPLOYEES
group by DEPARTMENT_ID;

-- Display job_ids and avg salaries where their salary is more than 5K
-- BAD PRACTICE
select JOB_ID, AVG(SALARY) from EMPLOYEES
where SALARY > 5000 -- Sums up salaries over 5000 first, then gives you the average --> (7500 + 7500) / 2 = 7500
group by JOB_ID;

SELECT JOB_ID, SALARY from EMPLOYEES;

-- CORRECT PRACTICE: HAVING function --> sorts after the math is done
select JOB_ID, AVG(SALARY) from EMPLOYEES
GROUP BY JOB_ID
HAVING avg(SALARY) > 5000; -- Finds the average of these job_id categories first, then gives you --> 28800 / 5 = 5760


-- Display department_id where employees count bigger than 5
select DEPARTMENT_ID, count(*) from EMPLOYEES
group by DEPARTMENT_ID
having  count(*)>5; -- does the math first

-- Display duplicate names in employee table
select FIRST_NAME, count(*) from EMPLOYEES
group by FIRST_NAME
having count(*)>1; -- does the math first

-- 23. display total salary for each department except department_id 50, and where total salary >30000
select DEPARTMENT_ID, sum(SALARY) from EMPLOYEES
where DEPARTMENT_ID != 50
group by DEPARTMENT_ID
having sum(SALARY) > 30000;



            --SUBQUERY--

-- Display all employees who are making above the average salary
--find average salary
select avg(SALARY)
from EMPLOYEES;
--get all employees who is making > avg
select * from EMPLOYEES
where SALARY = (6462);
--make it dynamic
select * from EMPLOYEES
where SALARY = (select avg(SALARY) from EMPLOYEES);

            --ROWNUM--

-- Display first 5 highest salary employees info in the company (INTERVIEW QUESTION)

-- BAD PRACTICE: cuts the table before ordering
select * from EMPLOYEES
where ROWNUM < 6
order by SALARY desc;

-- CORRECT WAY:
select *
from (select * from EMPLOYEES
      order by SALARY desc)
where ROWNUM < 6;


-- WITHOUT THE DUP SALARY -- THE GOOD PRACTICE --
-- Display all info from employee who is making the 5th highest salary
-- FIRST: find the 5th highest salary
select distinct SALARY
from EMPLOYEES
order by SALARY desc;

select min(SALARY)
from (select distinct SALARY
      from EMPLOYEES
      order by SALARY desc)
where ROWNUM < 6;

-- SECOND: find the info of the 5th highest
select *
from EMPLOYEES
where SALARY = 13000;

--THIRD: make it dynamic
select *
from EMPLOYEES
where SALARY = (select min(SALARY)
                from (select distinct SALARY from EMPLOYEES
                      order by SALARY desc)
                where ROWNUM < 6);



-- ALIAS: how can we rename our column in the query result?
            -- AS --
select FIRST_NAME as given_name from EMPLOYEES; -- UPPER CASE
select FIRST_NAME as "Given name" from EMPLOYEES; -- STRING ITSELF


            -- SINGLE ROW FUNCTIONS: Concatenation --
            -- Java: firstname+" "+lastname
            -- SQL: firstname||' '||lastname

-- Task: add @gmail.com domain to emails and display as full_email
select EMAIL || '@gmail.com' as "full_email" from EMPLOYEES;
select lower(EMAIL || '@gmail.com') as full_email from EMPLOYEES;


            --INITCAP
select initcap(EMAIL) from EMPLOYEES; -- FIRST LETTER CAP: upper case


            -- LENGTH
-- Task3: Display all the employees firstname and order by based on length of firstname
select FIRST_NAME, length(FIRST_NAME) from EMPLOYEES
order by length(FIRST_NAME) desc; -- can also put 2 as in index

-- Display the result as below by concatenating
-- First_name Makes XXXX Salary
select FIRST_NAME || ' makes ' || SALARY as "Employees Salary" from EMPLOYEES;

            --SUBSTR (colName, beginIndex, lastIndex)
-- Display all employees initials
select substr(FIRST_NAME, 0, 1) || '.' || substr(LAST_NAME, 0, 1) as initials from EMPLOYEES;


CREATE VIEW SDETS AS
select substr(FIRST_NAME, 0, 1) || '.' || substr(LAST_NAME, 0, 1) as "initials",
       FIRST_NAME || ' makes ' || SALARY                          as "Employees Salary"
from EMPLOYEES;

select *
from SDETS; -- Now this is REUSABLE forever and easier to call
select "initials"
from SDETS;
select "Employees Salary"
from SDETS;


            --CREATE TABLE--
CREATE TABLE scrumteam
(
    empid     INTEGER PRIMARY KEY,
    firstname varchar(30) not null,
    jobtitle  varchar(20) not null,
    age       Integer,
    salary    INTEGER
);

            --INSERT INTO-- --VALUES--
/*
 INSERT
 INTO tablename (column1, column2, ...)
 VALUES (value1, value2, ...);
 */

INSERT INTO scrumteam (empid, firstname, jobtitle, age, salary)
values (1, 'Mike', 'Tester', 25, 120000);

commit;

            --UPDATE--
UPDATE scrumteam
set salary=salary + 5000;

UPDATE scrumteam
SET salary=salary + 50000
where firstname = 'Raymond';

            --DELETE--
DELETE from scrumteam
where firstname = 'Raymond';

commit;

            -- ALTER TABLE --
-- add new column
ALTER TABLE scrumteam
ADD gender varchar(20);

UPDATE scrumteam
set gender='Male';

-- RENAME COLUMN --
ALTER TABLE scrumteam
RENAME COLUMN SALARY TO annual_salary;

-- DELETE -- DROP COLUMN --
ALTER TABLE scrumteam
DROP COLUMN gender;


            -- TRUNCATE --
--truncate, if we want to delete all data from the table, but still keep the table structure, we use truncate
TRUNCATE TABLE scrumteam;
            --DROP--
--if we want to delete the table and data together
DROP TABLE scrumteam;


            --JOINS--

--inner join
select first_name, DEPARTMENT_NAME
from EMPLOYEES e inner join DEPARTMENTS d
    on e.DEPARTMENT_ID=d.department_ID;
--left outer
select first_name, DEPARTMENT_NAME
from EMPLOYEES e left outer join DEPARTMENTS d --LEFT
    on e.DEPARTMENT_ID=d.department_ID;
--right outer
select first_name, DEPARTMENT_NAME
from EMPLOYEES e right outer join DEPARTMENTS d --RIGHT
    on e.DEPARTMENT_ID=d.department_ID;
--full outer
select first_name, DEPARTMENT_NAME
from EMPLOYEES e full outer join DEPARTMENTS d --RIGHT
    on e.DEPARTMENT_ID=d.department_ID;

--SELF JOIN--
select workers.first_name,managers.first_name
from employees workers inner join employees managers
    on workers.manager_id=managers.EMPLOYEE_ID;

select workers.first_name,managers.first_name
from employees workers left outer join employees managers
    on workers.manager_id=managers.EMPLOYEE_ID;

            --UNION--
select * from DEVELOPERS
UNION
select * from TESTERS; -- UNION removes the duplicates, but even if salary is dif, it will add it

            --UNION ALL-
select * from DEVELOPERS
UNION all
select * from TESTERS;

            --MINUS--
select names from DEVELOPERS
MINUS
select names from TESTERS;

            --INTERSECT--
select names from developers
intersect
select names from testers;




