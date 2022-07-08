-- Part 1 -- Select - Distinct - Where - Order By - Like - Group By - Having

-- 1. List all the employees first and last name with their salary in employees table
select FIRST_NAME, LAST_NAME, SALARY from employees;

-- 2. How many employees have salary less than 5000?
select count(SALARY) from EMPLOYEES
where SALARY<5000;

-- 3. How many employees have salary between 6000 and 7000?
select Count(SALARY) from EMPLOYEES
where SALARY>6000 and SALARY<7000;

-- 4. List all the different region_ids in countries table
-- select * from COUNTRIES;
select REGION_ID from COUNTRIES;

-- 5. display the salary of the employee Grant Douglas (lastName: Grant, firstName: Douglas)
select SALARY from EMPLOYEES
where FIRST_NAME='Douglas' and LAST_NAME='Grant';

-- 6. display all department information from departments table
-- if the department name values are as below
-- IT , Public Relations , Sales , Executive
select * from DEPARTMENTS
where DEPARTMENT_NAME='IT' or DEPARTMENT_NAME='Public Relations' or
      DEPARTMENT_NAME='Sales' or DEPARTMENT_NAME='Executive';

-- 7. display the maximum salary in employees table
select Max(SALARY) from EMPLOYEES;

-- 8. display the the minimum salary in employees table
select MIN(SALARY) from EMPLOYEES;

-- 9. display the average salary of the employees;
select ROUND( AVG(SALARY) ) from EMPLOYEES;

-- 10. count the total numbers of the departments in departs table
select Count(DEPARTMENT_NAME) from DEPARTMENTS; --27

-- 11. sort the start_date in ascending order in job_history's table
select START_DATE from JOB_HISTORY
order by START_DATE asc;

-- 12. sort the start_date in descending order in job_history's table
select START_DATE from JOB_HISTORY
order by START_DATE desc;

-- 13. display all records whose last name contains 2 lowercase 'a's
select * from EMPLOYEES
where LAST_NAME LIKE '%a%a%';

-- 14. display all the employees whose first name starts with 'A'
select * from EMPLOYEES
where FIRST_NAME LIKE 'A%';

-- 15. display all the employees whose job_ID contains 'IT'
select * from EMPLOYEES
where JOB_ID LIKE '%IT%';

-- 16. display all unique job_id that end with CLERK in employee table
select distinct JOB_ID from EMPLOYEES
where JOB_ID LIKE '%CLERK';

-- 17.display all employees first name starts with A and have exactly 4 characters Total
select * from EMPLOYEES
where FIRST_NAME LIKE 'A___';

-- 18. display all the employees whose department id in 50, 80, 100
select * from EMPLOYEES
where DEPARTMENT_ID=50 or DEPARTMENT_ID=80 or DEPARTMENT_ID=100
order by DEPARTMENT_ID desc;

-- 19. display all employees who does not work in any one of these department id 90, 60,  100, 130, 120
select * from EMPLOYEES
where DEPARTMENT_ID NOT IN (90, 60, 100, 130, 120)
order by DEPARTMENT_ID desc;

-- 20. divide employees into groups by using thier job id
-- 1 display the maximum salaries in each groups
-- 2 display the minimum salaries in each groups
-- 3 display the average salary of each group
-- 4 how many employees are there in each group that have minimum  salary of 5000 ?
-- 5 display the total budgets of each groups

-- 21. display all job_id and average salary who work as any of these jobs IT_PROG, SA_REP, FI_ACCOUNT, AD_VP


-- 22. display max salary  for each department
select DEPARTMENT_ID, max(SALARY) from EMPLOYEES
group by DEPARTMENT_ID;

-- 23. display total salary for each department except department_id 50, and where total salary >30000
select DEPARTMENT_ID, sum(SALARY) from EMPLOYEES
where DEPARTMENT_ID != 50
group by DEPARTMENT_ID
having sum(SALARY) > 30000;