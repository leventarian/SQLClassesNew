---- 1. display full addresses from locations table in a single column
select STREET_ADDRESS||', '||CITY||', '||STATE_PROVINCE||', '||POSTAL_CODE as "Full Address" from LOCATIONS;

-- 2. display all information of the employee who has the minimum salary in employees table
select * from EMPLOYEES
order by SALARY asc;

select * from employees
where salary = ( select min(salary) from employees );

-- 3. display the second minimum salary from the employees
select * from EMPLOYEES
order by SALARY asc; --1

select min(SALARY) from (select * from EMPLOYEES
                         order by SALARY asc); --2

select SALARY from EMPLOYEES
where SALARY = (select max(SALARY)
                from (select * from EMPLOYEES
                      order by SALARY asc)
                where ROWNUM < 3); --3

select min(salary) from employees
where salary > ( select min(salary) from employees ); --Correct answer


-- 4. display all information of the employee who has the second minimum salary
select * from EMPLOYEES
where SALARY = (select max(SALARY)
                from (select * from EMPLOYEES
                      order by SALARY asc)
                where ROWNUM < 3);                  --My answer

select * from EMPLOYEES
where SALARY = (select min(salary) from employees
                where salary > ( select min(salary) from employees )); --Correct answer

-- 5. list all the employees who are making above the average salary;
select * from EMPLOYEES
where SALARY>(select AVG(SALARY) from EMPLOYEES)
order by SALARY;                                    --CORRECT

-- 6. list all the employees who are making less than the average salary
select * from EMPLOYEES
where SALARY<(select AVG(SALARY) from EMPLOYEES)
order by SALARY;                                 --CORRECT

-- 7. display manager name of 'Neena'
select MANAGER_ID from EMPLOYEES
where FIRST_NAME = 'Neena';

select FIRST_NAME, LAST_NAME from EMPLOYEES
where EMPLOYEE_ID = (select MANAGER_ID from EMPLOYEES
                      where FIRST_NAME = 'Neena');

-- 8. find the 3rd maximum salary from the employees table (do not include duplicates)
select distinct salary from EMPLOYEES
order by SALARY desc;

select min(SALARY) from (select distinct salary from EMPLOYEES
                         order by SALARY desc)
where ROWNUM<4;

-- 9. find the 5th maximum salary from the employees table (do not include duplicates)
select min(SALARY) from (select distinct salary from EMPLOYEES
                         order by SALARY desc)
where ROWNUM<6;

-- 10. find the 7th maximum salary from the employees table (do not include duplicates)
select min(SALARY) from (select distinct salary from EMPLOYEES
                         order by SALARY desc)
where ROWNUM<8; --12000

-- 11. find the 10th maximum salary from the employees table (do not include duplicates)
select min(SALARY) from (select distinct salary from EMPLOYEES
                         order by SALARY desc)
where ROWNUM<11; --10500

-- 12. find the 3rd minimum salary from the employees table (do not include duplicates)
select distinct SALARY from EMPLOYEES
order by Salary asc;

select MAX(SALARY) from (select distinct SALARY from EMPLOYEES
                         order by Salary asc)
where ROWNUM<4; --2400

-- 13. find the 5th minimum salary from the employees table (do not include duplicates)
select MAX(SALARY) from (select distinct SALARY from EMPLOYEES
                         order by Salary asc)
where ROWNUM<6; --2600

-- 14. find the 7th maximum salary from the employees table (do not include duplicates)
select MAX(SALARY) from (select distinct SALARY from EMPLOYEES
                         order by Salary asc)
where ROWNUM<8; --2800

-- 15. find the 10th maximum salary from the employees table (do not include duplicates)
select MAX(SALARY) from (select distinct SALARY from EMPLOYEES
                         order by Salary asc)
where ROWNUM<11; --3100
