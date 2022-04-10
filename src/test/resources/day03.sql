-- Display all employees where firstname starts with H and ends with l
select * from employees
where FIRST_NAME LIKE 'H%l';

-- Display all employees whose job_ID contains 'IT'
select * from EMPLOYEES
where JOB_ID LIKE '%IT%';

-- get me all unique manager_ids
select * from EMPLOYEES;
select distinct MANAGER_ID from EMPLOYEES; -- 19 in total: this one counted the NULL value from the table

-- get me how many different manager ID we have
select count(distinct MANAGER_ID) from EMPLOYEES; -- 18: COUNT does NOT count the null values

-- how many employees we have for each manager
select MANAGER_ID, count(*) from EMPLOYEES
group by MANAGER_ID;

-- how many employees we have for each manager order by desc based on number of employees
select MANAGER_ID, count(*) from EMPLOYEES
group by MANAGER_ID
order by 2 desc;

-- 23. Display total salary for EACH department except department_id 50,
-- and where total salary > 30000
select DEPARTMENT_ID, sum(SALARY) from EMPLOYEES
where DEPARTMENT_ID<>50
group by DEPARTMENT_ID
HAVING sum(SALARY) > 30000;



/*
 SUBQUERY
 */

-- Display all info from employees who are making the highest salary in the company? (PIQ)
select MAX(SALARY) from EMPLOYEES; -- 24000

select * from EMPLOYEES
where SALARY=24000;

-- Dynamic Answer:
select * from EMPLOYEES
where SALARY=(select MAX(SALARY) from EMPLOYEES);

-- Display the second highest salary in the company?
        -- find max salary
        select MAX(SALARY) from EMPLOYEES;
        -- find second max
        select MAX(SALARY) from EMPLOYEES
        where SALARY<24000;
        --make it dynamic
        select MAX(SALARY) from EMPLOYEES
        where SALARY<(select MAX(SALARY) from EMPLOYEES);

-- Display all info for third highest?
select  * from EMPLOYEES
where SALARY=17000;

    --make it dynamic
    select  * from EMPLOYEES
    where SALARY= (select MAX(SALARY) from EMPLOYEES
    where SALARY<(select MAX(SALARY) from EMPLOYEES));

-- Display all employees who are making above the average salary
    --find average salary
    select avg(SALARY) from EMPLOYEES;
    --get all employees who is making > avg
    select * from EMPLOYEES
    where SALARY=(6462);
    --make it dynamic
    select * from EMPLOYEES
    where SALARY=(select avg(SALARY) from EMPLOYEES);




--NEW TOPIC--

select * from EMPLOYEES
where ROWNUM<11;  -- ROWNUM keyword DOES NOT work with = sign, limit works in MYSQL-POSTGRES


-- Display first 5 highest salary employees info in the company (INTERVIEW QUESTION)
-- The whole table for reference in descending order:
select * from EMPLOYEES
order by SALARY desc;

-- BAD PRACTICE: cuts the table before ordering
select * from EMPLOYEES
where ROWNUM<6
order by SALARY desc;

-- CORRECT WAY:
select * from (select * from EMPLOYEES
               order by SALARY desc)
where ROWNUM < 6;



-- Display first 52 highest salary employees info in the company
select  * from (select * from EMPLOYEES
                order by SALARY desc)
where ROWNUM < 53;

-- Display first 90 highest salary employees info in the company
select  * from (select * from EMPLOYEES
                order by SALARY desc)
where ROWNUM < 91;

-- WITH DUP SALARY -- THE BAD PRACTICE --
-- Display all info from employee who is making the 5th highest salary
-- FIRST: find the 5th highest salary
select * from EMPLOYEES
order by SALARY desc;

select min(SALARY) from (select * from EMPLOYEES
                        order by SALARY desc)
where ROWNUM < 6;

-- SECOND: find the info of the 5th highest
select * from EMPLOYEES
where SALARY=13500;

--THIRD: make it dynamic
select * from EMPLOYEES
where SALARY = (select min(SALARY) from (select * from EMPLOYEES
                                        order by SALARY desc)
               where ROWNUM < 6);



-- WITHOUT THE DUP SALARY -- THE GOOD PRACTICE --
-- Display all info from employee who is making the 5th highest salary
-- FIRST: find the 5th highest salary
select distinct SALARY from EMPLOYEES
order by SALARY desc;

select min(SALARY) from (select distinct SALARY from EMPLOYEES
                         order by SALARY desc)
where ROWNUM < 6;

-- SECOND: find the info of the 5th highest
select * from EMPLOYEES
where SALARY=13000;

--THIRD: make it dynamic
select * from EMPLOYEES
where SALARY= (select min(SALARY) from (select distinct SALARY from EMPLOYEES
                                        order by SALARY desc)
               where ROWNUM < 6);


-- Task: Display all info from employee who is making 52nd highest salary
select * from EMPLOYEES
where SALARY= (select min(SALARY) from (select distinct SALARY from EMPLOYEES
                                        order by SALARY desc)
               where ROWNUM < 53);



-- ALIAS: how can we rename our column in the query result?
-- with AS keyword --
select FIRST_NAME as given_name from EMPLOYEES; -- UPPER CASE
select FIRST_NAME as "Given name" from EMPLOYEES; -- STRING ITSELF

-- Task: Display annual salary for all employees as annual salary column
-- salary*12
select SALARY*12 as "Annual salary" from EMPLOYEES;


-- SINGLE ROW FUNCTIONS: Concatenation --
-- Java: firstname+" "+lastname
-- SQL: firstname||' '||lastname

-- Task: add @gmail.com domain to emails and display as full_email
select EMAIL||'@gmail.com' as "full_email" from EMPLOYEES;
select EMAIL||'@gmail.com' as full_email from EMPLOYEES;

select lower(EMAIL||'@gmail.com') as full_email from EMPLOYEES;
select upper(EMAIL||'@gmail.com') as full_email from EMPLOYEES;

--INITCAP
select email from EMPLOYEES;
select initcap(EMAIL) from EMPLOYEES; -- FIRST LETTER CAP: upper case

-- LENGTH
-- Task3: Display all the employees firstname and order by based on length of firstname
select FIRST_NAME, length(FIRST_NAME) from EMPLOYEES
order by length(FIRST_NAME) desc; -- can also put 2 as in index

-- Display the result as below by concatenating
-- First_name Makes XXXX Salary
select FIRST_NAME||' makes '||SALARY as "Employees Salary" from EMPLOYEES;
select FIRST_NAME||' makes '||SALARY||' '||JOB_ID as "Employees Salary" from EMPLOYEES;


--SUBSTR (colName, beginIndex, lastIndex)
-- Display all employees initials
select substr(FIRST_NAME, 0, 1)||'.'||substr(LAST_NAME,0,1) as initials from EMPLOYEES;



-- Display all the employees first_name with 6 chars
select FIRST_NAME from EMPLOYEES
where length(FIRST_NAME)=6;

select count(FIRST_NAME) from EMPLOYEES
where count(FIRST_NAME)= like '______';

select FIRST_NAME from EMPLOYEES
where FIRST_NAME like '______';



CREATE VIEW SDETS AS
select substr(FIRST_NAME,0,1)||'.'||substr(LAST_NAME,0,1) as "initials",
FIRST_NAME||' makes '||SALARY as "Employees Salary"
from EMPLOYEES;

select * from SDETS; -- Now this is REUSABLE forever and easier to call
select "initials" from SDETS;
select "Employees Salary" from SDETS;

drop view SDETS; -- We delete the table with this command




/*
create table syntax:
    create table TableName(
        colName1 DataType Constraints,
        colName2 DataType Constraints(optional)
        colName3 DataType Constraints,
        ...
    );
*/

CREATE TABLE scrumteam(
    empid INTEGER PRIMARY KEY,
    firstname varchar(30) not null,
    jobtitle varchar(20) not null,
    age Integer,
    salary INTEGER
);

select * from scrumteam;

/*
 INSERT
 INTO tablename (column1, column2, ...)
 VALUES (value1, value2, ...);
 */

INSERT INTO scrumteam (empid, firstname, jobtitle, age, salary)
values (1, 'Mike', 'Tester', 25, 120000);

INSERT INTO scrumteam (empid, firstname, jobtitle, age, salary)
values (2, 'John', 'Tester', 25, 125000);

INSERT INTO scrumteam
values (3, 'Steve', 'Developer', 30, 200000);

INSERT INTO scrumteam
values (4, 'Dembe', 'Developer', 40, 220000);

INSERT INTO scrumteam
values (4, 'Dembe', 'Developer', 40, 220000);

INSERT INTO scrumteam
values (5, 'Henry', 'Developer', 37, 230000);

INSERT INTO scrumteam
values(6,'Raymond','Developerr',40,220000);

INSERT INTO scrumteam
values(7,'Harold','Tester',43,220000);

commit;


/*
 UPDATE table_name
 SET column1 = value1,
     column2 = value2, ...
 WHERE condition;
 */

-- Increase salaries by 5000


UPDATE scrumteam
set salary=salary+5000;

UPDATE scrumteam
SET salary=salary+50000
where firstname='Raymond';

select * from scrumteam;

--Delete from table
/*
DELETE FROM table_name
WHERE condition;
*/

DELETE from scrumteam
where firstname='Raymond';

commit;


/*
    ALTER
    - To change existing table structure, you use ALTER TABLE statement.
 */

-- ADD NEW COLUMN --
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

-- RENAME TABLE --
ALTER TABLE scrumteam
RENAME TO agileteam;

-- TRUNCATE --
--truncate, if we want to delete all data from the table, but still keep the table structure, we use truncate
TRUNCATE TABLE agileteam;

--if we want to delete the table and data together
DROP TABLE  agileteam;


select * from agileteam;







