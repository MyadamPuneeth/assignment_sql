--1. Select all departments in all locations where the Total Salary of a Department is Greater than twice the Average Salary for the department. And max basic for the department is at least thrice the Min basic for the department.

create table question1A2Table (
emp_name nvarchar(50),
emp_id int primary key,
emp_sal money,
emp_dept nvarchar(50),
emp_location nvarchar(50),
emp_basic money);

drop table question2A2;

insert into question1A2Table values
('Alice', 1, 90000, 'HR', 'NY', 25000),
('Bob', 2, 85000, 'HR', 'NY', 28000),
('Charlie', 3, 70000, 'HR', 'NY', 30000),
('David', 4, 65000, 'HR', 'NY', 32000),
('Eve', 5, 50000, 'HR', 'NY', 15000),
('Frank', 6, 120000, 'IT', 'SF', 45000),
('Grace', 7, 115000, 'IT', 'SF', 42000),
('Heidi', 8, 110000, 'IT', 'SF', 40000),
('Ivan', 9, 30000, 'Sales', 'LA', 10000),
('Judy', 10, 35000, 'Sales', 'LA', 3000);

select 
	emp_location,
	emp_dept,
	sum(emp_sal) as total_sal,
	avg(emp_sal) as avg_sal,
	max(emp_basic) as max_basic,
	min(emp_basic) as min_basic
from 
	question1A2Table
group by emp_location,emp_dept 
having sum(emp_sal)>= 2*avg(emp_sal) and max(emp_basic) >= 3*min(emp_basic);

--------------------------------------------------------------------------------------------------------

--2. As per the companies rule if an employee has put up service of 1 Year 3 Months and 15 days in office, Then She/he would be eligible for a Bonus. the Bonus would be Paid on the first of the Next month after which a person has attained eligibility. Find out the eligibility date for all the employees. And also find out the age of the Employee On the date of Payment of the First bonus. Display the Age in Years, Months, and Days. Also Display the weekday Name, week of the year, Day of the year and week of the month of the date on which the person has attained the eligibility.

create table question2A2 (
emp_id int primary key,
emp_name nvarchar(20),
emp_dob date,
emp_jd date);

alter table question2A2 add eligibility nvarchar(1);

insert into question2A2 values
(1, 'Alice', '1980-05-15', '2024-03-01'),
(2, 'Bob', '1985-08-20', '2023-07-15'),
(3, 'Charlie', '1990-12-01', '2022-06-30'),
(4, 'David', '1983-11-25', '2023-09-20'),
(5, 'Eve', '1992-02-14', '2016-01-10'),
(6, 'Frank', '1978-07-07', '2023-12-12'),
(7, 'Grace', '1986-03-23', '2023-04-18'),
(8, 'Heidi', '1994-06-17', '2020-10-05'),
(9, 'Ivan', '1981-09-09', '2023-08-23'),
(10, 'Judy', '1988-01-30', '2022-11-11');

declare @eligibility_date date;
select @eligibility_date = dateadd(day, 455, emp_jd) from question2A2;


select 
emp_name, 
dateadd(day, 455, emp_jd) as eligibility_date,
concat (
datediff(month, emp_dob, dateadd(day, 455, emp_jd))/12, ' years, ',
datediff(month, emp_dob, dateadd(day, 455, emp_jd))%12, ' months, ',
abs(DATEDIFF(day, DATEADD(month, DATEDIFF(month, emp_dob, dateadd(day, 455, emp_jd)), emp_dob), dateadd(day, 455, emp_jd))),' days') AS emp_age,
datename(weekday, dateadd(day, 455, emp_jd)) as weekday_of_year,
datepart(week, dateadd(day, 455, emp_jd)) as week_of_year,
datepart(DAYOFYEAR, dateadd(day, 455, emp_jd)) as day_of_year,
(datepart(day,dateadd(day, 455, emp_jd))-1)/7 + 1 as week_of_month
from question2A2;

--------------------------------------------------------------------------------------------------------

/*
3. Company Has decided to Pay a bonus to all its employees. The criteria is as follows
1. Service Type 1. Employee Type 1. Minimum service is 10. Minimum service left should be 15 Years. Retirement age will be 60
Years
2. Service Type 1. Employee Type 2. Minimum service is 12. Minimum service left should be 14 Years . Retirement age will be 55
Years
3. Service Type 1. Employee Type 3. Minimum service is 12. Minimum service left should be 12 Years . Retirement age will be 55
Years
3. for Service Type 2,3,4 Minimum Service should Be 15 and Minimum service left should be 20 Years . Retirement age will be 65
Years
Write a query to find out the employees who are eligible for the bonus.
*/

create table question3A2(
emp_name nvarchar(50),
emp_id int,
emp_ser nvarchar(10),
emp_type nvarchar(10),
emp_jd date,
emp_dob date);

select * from question3A2;

drop table question3A2;

insert into question3A2 values 
('John Doe', 101, 'IT', 'FullTime', '2010-01-15', '1980-05-22'),
('Jane Smith', 102, 'IT', 'PartTime', '2018-03-22', '1985-07-11'),
('Alice Johnson', 103, 'HR', 'Contract', '2021-05-12', '1970-02-20'),
('Bob Brown', 104, 'HR', 'Intern', '2015-07-01', '2000-09-15'),
('Charlie Davis', 105, 'MARKETING', 'FullTime', '2019-09-17', '1968-11-30'),
('David Wilson', 106, 'MARKETING', 'FullTime', '2011-11-30', '1976-03-15'),
('Eva Green', 107, 'MARKETING', 'PartTime', '2019-02-14', '1968-06-28'),
('Franklin Lee', 108, 'IT', 'Contract', '2022-08-01', '1991-12-10'),
('Grace Kim', 109, 'HR', 'Intern', '2013-01-15', '2001-04-22'),
('Henry White', 110, 'IT', 'FullTime', '2008-06-25', '1969-10-05');

--3,1

select 
emp_name,
emp_ser, 
emp_type,
datediff(year, emp_dob, getdate()) as age,
datediff(year, emp_jd, getdate()) as service_years,
60 - datediff(year, emp_dob, getdate()) as remaining_service_years
from question3A2 where (datediff(year, emp_jd, getdate())) > 10 and (60 - datediff(year, emp_dob, getdate()))>= 15;

--3,2

select 
emp_name,
emp_ser, 
emp_type,
datediff(year, emp_dob, getdate()) as age,
datediff(year, emp_jd, getdate()) as service_years,
55 - datediff(year, emp_dob, getdate()) as remaining_service_years
from question3A2 where (datediff(year, emp_jd, getdate())) > 12 and (60 - datediff(year, emp_dob, getdate()))>= 14;

--3,3

select 
emp_name,
emp_ser, 
emp_type,
datediff(year, emp_dob, getdate()) as age,
datediff(year, emp_jd, getdate()) as service_years,
55 - datediff(year, emp_dob, getdate()) as remaining_service_years
from question3A2 where (datediff(year, emp_jd, getdate())) > 12 and (60 - datediff(year, emp_dob, getdate()))>= 12;

-- 3,4

select 
emp_name,
emp_ser, 
emp_type,
datediff(year, emp_dob, getdate()) as age,
datediff(year, emp_jd, getdate()) as service_years,
65 - datediff(year, emp_dob, getdate()) as remaining_service_years
from question3A2 where (datediff(year, emp_jd, getdate())) > 15 and (60 - datediff(year, emp_dob, getdate()))>= 20;


-- assignment table 1

create table assignmentTable1(
emp_name nvarchar(10),
emp_id int primary key,
emp_age int,
emp_join_date date,
emp_service_type nvarchar(10),
emp_location nvarchar(20));

select * from assignmentTable1;

drop table assignmentTable1;

insert into assignmentTable1 values
('puneeth', 267, 21, '2024-05-01', 'delivery', 'New York'),
('purandhar', 264, 22, '2023-10-25', 'delivery', 'Los Angeles'),
('vijay', 265, 20, '2021-05-01', 'delivery', 'Chicago'),
('srinivas', 266, 23, '2020-01-16', 'delivery', 'New York'),
('rithvik', 268, 22, '2022-03-31', 'delivery', 'Los Angeles'),
('john', 269, 25, '2023-06-12', 'sales', 'Chicago'),
('jane', 270, 28, '2022-11-05', 'marketing', 'New York'),
('doe', 271, 30, '2021-09-17', 'hr', 'Los Angeles'),
('alex', 272, 24, '2020-12-20', 'finance', 'Chicago'),
('emma', 273, 29, '2019-07-30', 'it', 'New York'),
('liam', 274, 27, '2018-08-14', 'sales', 'Los Angeles'),
('olivia', 275, 26, '2017-03-22', 'marketing', 'Chicago'),
('noah', 276, 32, '2016-11-30', 'hr', 'New York'),
('ava', 277, 31, '2015-05-15', 'finance', 'Los Angeles'),
('isabella', 278, 33, '2014-04-18', 'it', 'Chicago'),
('mason', 279, 35, '2013-10-10', 'sales', 'New York'),
('sophia', 280, 34, '2012-08-08', 'marketing', 'Los Angeles'),
('ethan', 281, 29, '2011-06-04', 'hr', 'Chicago'),
('mia', 282, 28, '2010-07-27', 'finance', 'New York'),
('logan', 283, 26, '2009-02-19', 'it', 'Los Angeles'),
('amelia', 284, 27, '2008-01-11', 'sales', 'Chicago'),
('lucas', 285, 25, '2007-12-09', 'marketing', 'New York'),
('charlotte', 286, 24, '2006-03-07', 'hr', 'Los Angeles'),
('aiden', 287, 31, '2005-10-15', 'finance', 'Chicago'),
('ella', 288, 32, '2004-11-23', 'it', 'New York');


-- 4.write a query to Get Max, Min and Average age of employees, service of employees by service Type , Service Status for each Centre(display in years and Months)

declare @maxage int;
select @maxage = max(emp_age) from assignmentTable1;

select 
emp_service_type,
emp_location,
min(emp_age) as min_age,
max(emp_age) as max_age,
avg(emp_age) as avg_age,
max(datediff(year, emp_join_date, getdate())) as service_year_for_center
from assignmentTable1
group by emp_service_type, emp_location;

-----------------------------NOT YET COMPLETED ABOVE QUESTION-----------------------------------

--5. Write a query to list out all the employees where any of the words (Excluding Initials) in the Name starts and ends with the same character. (Assume there are not more than 5 characters in any name)

create table assignmentTable2 (
emp_name nvarchar(50));

drop table assignmentTable2;

select * from assignmentTable2;

insert into assignmentTable2 values
('M Puneeth'), 
('G Rithvik'), 
('V Vijay'), 
('M Jordan'), 
('J Josj'), 
('A Ana'), 
('Srinivas'), 
('Purandhar');

select 
	substring(emp_name, CHARINDEX(' ', emp_name )+1, len(emp_name)) as firstName 
	from assignmentTable2  where left(emp_name, 1) = right(emp_name, 1);

--------------------------------------------------------------------------------------------------------



