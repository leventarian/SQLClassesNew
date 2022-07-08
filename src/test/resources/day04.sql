select *
from EMPLOYEES;

-- Review --

-- 2. display all information of the employee who has the minimum salary in employees table
--select min(salary) from EMPLOYEES; --2100
select *
from EMPLOYEES
where salary = (select min(salary) from EMPLOYEES);

-- 3. display the second minimum salary from the employees
--select min(SALARY) from EMPLOYEES;--2100
select min(SALARY)
from EMPLOYEES
where SALARY > (select min(SALARY) from EMPLOYEES);

-- 4. display all information of the employee who has the second minimum
select *
from EMPLOYEES
where SALARY = (select min(SALARY)
                from EMPLOYEES
                where SALARY > (select min(SALARY) from EMPLOYEES));

-- 12. find the 3rd minimum salary from the employees table (do not  include duplicates)
select distinct salary
from EMPLOYEES
order by salary asc;

select max(SALARY)
from (select distinct salary
      from EMPLOYEES
      order by salary asc)
where ROWNUM < 4;

-- 15. find the 10th maximum salary from the employees table (do not include duplicates)
select distinct salary
from EMPLOYEES
order by SALARY desc;

select min(SALARY)
from (select distinct salary
      from EMPLOYEES
      order by SALARY desc)
where ROWNUM < 11;

-- NEW TOPIC: JOINS --

CREATE TABLE address
(
    address_id Integer PRIMARY KEY,
    address    VARCHAR(50) NOT NULL,
    phone      Integer     NOT NULL
);

INSERT INTO address (address_id, address, phone)
VALUES (5,
        '1913 Hanoi Way', 28303384);
INSERT INTO address (address_id, address, phone)
VALUES (7,
        '692 Joliet Street', 44847719);
INSERT INTO address (address_id, address, phone)
VALUES (8,
        '1566 Inegl Manor', 70581400);
INSERT INTO address (address_id, address, phone)
VALUES (10,
        '1795 Santiago', 86045262);
INSERT INTO address (address_id, address, phone)
VALUES (11,
        '900 Santiago', 16571220);

CREATE TABLE customer
(
    customer_id Integer PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    address_id  Integer REFERENCES address (address_id)
);

INSERT INTO customer (customer_id, first_name, last_name,
                      address_id)
VALUES (1, 'Mary', 'Smith', 5);
INSERT INTO customer (customer_id, first_name, last_name,
                      address_id)
VALUES (2, 'Patricia', 'Johnson', NULl);
INSERT INTO customer (customer_id, first_name, last_name,
                      address_id)
VALUES (3, 'Linda', 'Williams', 7);
INSERT INTO customer (customer_id, first_name, last_name,
                      address_id)
VALUES (4, 'Barbara', 'Jones', 8);
INSERT INTO customer (customer_id, first_name, last_name,
                      address_id)
VALUES (5, 'Elizabeth', 'Brown', NULL);

commit work;

SELECT *
from customer;

select *
from address;

-- JOIN --

/*
 -- INNER JOIN --
 Only matching portion of the tables. Inner join eliminates if there's no match
 IF YOU TYPE ONLY JOIN AS A DEFAULT IT IS INNER JOIN.
 */

select first_name, last_name, address, phone from customer
inner join address
on customer.address_id = address.address_id;

select first_name, last_name, c.address_id, a.address_id, address, phone from customer c
inner join address a
    on c.address_id = a.address_id;


/*
 -- LEFT OUTER JOIN --
 Matching part + only unique for left table
 */
select first_name, last_name, c.address_id, a.address_id, address, phone
from customer c left outer join address a
    on c.address_id = a.address_id;

/*
-- LEFT OUTER JOIN WITH WHERE --

 */
select first_name, last_name, c.address_id, a.address_id, address, phone
from customer c left outer join address a
    on c.address_id = a.address_id
where a.address_id is null;

/*
-- FULL OUTER JOIN WITH WHERE --
only unique for right and left
 */
select first_name, last_name, c.address_id, a.address_id, address, phone
from customer c full outer join address a
    on c.address_id = a.address_id
where c.address_id is null or a.address_id is null;


/*
 -- RIGHT OUTER JOIN --
Matching part + only unique for right table
 */
select first_name, last_name, c.address_id, a.address_id, address, phone
from customer c
         right outer join address a
                         on c.address_id = a.address_id;


/*
 -- FULL OUTER JOIN --
Matching part + only unique for right and left table
 */
select first_name, last_name, c.address_id, a.address_id, address, phone
from customer c
         full outer join address a
                         on c.address_id = a.address_id;


--Display firstname, department from employees table
select * from EMPLOYEES;

select * from DEPARTMENTS;


select first_name, DEPARTMENT_NAME
from EMPLOYEES e inner join DEPARTMENTS d
    on e.DEPARTMENT_ID=d.department_ID;

select first_name, DEPARTMENT_NAME
from EMPLOYEES e left outer join DEPARTMENTS d --LEFT
    on e.DEPARTMENT_ID=d.department_ID;

select first_name, DEPARTMENT_NAME
from EMPLOYEES e right outer join DEPARTMENTS d --RIGHT
    on e.DEPARTMENT_ID=d.department_ID;

select first_name, DEPARTMENT_NAME
from EMPLOYEES e full outer join DEPARTMENTS d --RIGHT
    on e.DEPARTMENT_ID=d.department_ID;

/*
SELF JOIN
*/

select * from EMPLOYEES;

select workers.first_name,managers.first_name
from employees workers inner join employees managers
    on workers.manager_id=managers.EMPLOYEE_ID;

select workers.first_name,managers.first_name
from employees workers left outer join employees managers
    on workers.manager_id=managers.EMPLOYEE_ID;


-- Display first_name,department name from employees table

select * from employees;

select * from departments;

select first_name,department_name
from employees e inner join departments d
on e.department_id=d.department_id;

--left
select first_name,department_name
from employees e left outer join departments d
on e.department_id=d.department_id;

-- Right
select first_name,department_name
from departments d right outer join employees e
on d.department_id=e.department_id;






select * from employees;

--Display All cities and related country names from hr database
select l.CITY, c.COUNTRY_NAME
from LOCATIONS l inner join COUNTRIES c
on l.COUNTRY_ID = c.COUNTRY_ID;

--Display all first_name and department_name including the departments without employee names
select * from EMPLOYEES;
select * from DEPARTMENTS;

select e.FIRST_NAME, d.DEPARTMENT_NAME
from EMPLOYEES e right outer join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

select FIRST_NAME, DEPARTMENT_NAME
from DEPARTMENTS d left outer join EMPLOYEES e
on d.DEPARTMENT_ID = e.DEPARTMENT_ID;

--Display all first_name and department_name
-- including the  department without employee  and  employees       without departments
select FIRST_NAME, DEPARTMENT_NAME
from DEPARTMENTS d full outer join EMPLOYEES e
on d.DEPARTMENT_ID = e.DEPARTMENT_ID;

--Display first_name,last_name and department_name,city for all employees
select FIRST_NAME, LAST_NAME, d.DEPARTMENT_NAME, CITY
from EMPLOYEES e inner join DEPARTMENTS d
        on e.DEPARTMENT_ID = d.DEPARTMENT_ID
    inner join locations l
        on l.LOCATION_ID = d.LOCATION_ID;

--Display first_name,last_name and department_name,city,country_name for all employees
select FIRST_NAME, LAST_NAME, d.DEPARTMENT_NAME, CITY, COUNTRY_NAME from EMPLOYEES e
    inner join DEPARTMENTS d
        on e.DEPARTMENT_ID = d.DEPARTMENT_ID
    inner join locations l
        on l.LOCATION_ID = d.LOCATION_ID
    inner join COUNTRIES c
        on c.COUNTRY_ID = l.COUNTRY_ID;







create table Developers(
                           Id_Number Integer primary key,
                           Names varchar(30),
                           Salary Integer
);
create table Testers(
                        Id_Number Integer primary key,
                        Names varchar(30),
                        Salary Integer
);

insert into developers values (1, 'Mike', 155000);
insert into developers values (2, 'John', 142000);
insert into developers values (3, 'Steven', 850000);
insert into developers values (4, 'Maria', 120000);
insert into testers values (1, 'Steven', 110000);
insert into testers values(2, 'Adam', 105000);
insert into testers values (3, 'Lex', 100000);

commit work;

/* UNION
 -- REMOVES DUPLICATES
 -- Ascending order
 */

select * from DEVELOPERS
UNION
select * from TESTERS; -- UNION removes the duplicates, but even if salary is dif, it will add it

select names from DEVELOPERS
UNION
select names from TESTERS; --  all the duplicates are removed now that we don't have the salary column anymore

/* UNION ALL
 -- DOES NOT REMOVE DUPLICATES
 -- Does not sort in any order
 */

select * from DEVELOPERS
UNION all
select * from TESTERS;

select names from DEVELOPERS
UNION ALL
select names from TESTERS;


-- MINUS --
select names from DEVELOPERS
MINUS
select names from TESTERS;


-- INTERSECT --
select names from developers
intersect
select names from testers;












