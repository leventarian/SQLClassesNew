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



