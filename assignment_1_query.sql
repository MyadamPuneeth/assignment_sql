-- Question 1

-- 1. Write a script to extracts all the numerics from Alphanumeric String

--string = 'hi1 I2 am3 work4ing 5at cogni6ne'

declare @string NVARCHAR(MAX);
set @string = 'hi1 I2 am3 work4ing 5at cogni6ne';

--Using a table

create TABLE charTable (pos INT identity(1,1), charters NVARCHAR(1));

WHILE len(@string)>0
begin
	insert into charTable 
	values (LEFT(@string,1))

	set @string = SUBSTRING (@string, 2, len(@string));

end

select * from charTable;

drop table num1Table;

select string_agg(charters, '') as numString from charTable where charters like '[0-9]';

/* Without using a table and return the numerics as a string and a number.

declare @string NVARCHAR(MAX);
set @string = 'hi1 I2 am3 work4ing 5at cogni6ne';

declare @numstring NVARCHAR(MAX);
declare @intNumString int;
declare @tempStorage NVARCHAR(1);

while len(@string) > 0
begin
	set @tempStorage = left(@string, 1);

	if @tempStorage like '[0-9]'
	begin
		set @numstring = @numstring + @tempStorage;
	end
	set @string = SUBSTRING (@string, 2, len(@string));
end

select @numstring as numericCharacters; */

-----------------------------------------------------------------------------------------------------------

-- 2. Write a script to calculate age based on the Input DOB

declare @dob date = '2003-01-16';
declare @todayDate Date = getdate();
declare @age int;

set @age = datediff(year, @dob, @todayDate);

select @age as age;

-----------------------------------------------------------------------------------------------------------

--3. Create a column in a table and that should throw an error when we do SELECT * or SELECT of that column. If we select other columns then we should see results.

drop table errorColumnTable;

create table errorColumnTable (
ect_id int primary key,
ect_name NVARCHAR(10),
ect_age int,
error as (ect_age/0));

insert into errorColumnTable
values
(1, 'a', 15),
(2, 'b', 30),
(3, 'c', 67),
(4, 'd', 99),
(5, 'e', 20);

select * from errorColumnTable;
select error from errorColumnTable;


-----------------------------------------------------------------------------------------------------------

/* 4. Display Calendar Table based on the input year. If I give the year 2017 then populate data for 2017 only

Date e.g.  1/1/2017 

DayofYear 1 – 365/366 (Note 1)

Week 1-52/53

DayofWeek 1-7

Month 1-12

DayofMonth 1-30/31 (Note 2)

Note 1: DayofYear varies depending on the number of days in the given year.

Note 2: DayofMonth varies depending on number of days in the given month

Weekly calculations are always for a 7 day period Sunday to Saturday.*/

create table tableOfDates (
    [Date] DATE,
    DayOfYear INT,
    [Week] INT,
    DayOfWeek INT,
    [Month] INT,
    DayOfMonth INT
);

select * from tableOfDates;

declare @inpYear int = 2017;
declare @startDate date = DATEFROMPARTS(@inpYear, 1, 1);
declare @endDate date = DATEFROMPARTS(@inpYear, 12, 31);

with dates_for_calender as(
	select 
	@startDate as [date],
	1 as dayofyear,
		DATEPART(WEEK, @startDate) AS [Week],
        DATEPART(WEEKDAY, @startDate) AS DayOfWeek,
        DATEPART(MONTH, @startDate) AS [Month],
        DATEPART(DAY, @startDate) AS DayOfMonth
	union all
	select
		DATEADD(DAY, 1, [date]),
        DATEPART(DAYOFYEAR, DATEADD(DAY, 1, [date])),
        DATEPART(WEEK, DATEADD(DAY, 1, [date])),
        DATEPART(WEEKDAY, DATEADD(DAY, 1, [date])),
        DATEPART(MONTH, DATEADD(DAY, 1, [date])),
        DATEPART(DAY, DATEADD(DAY, 1, [date]))
	from
		dates_for_calender
	where
		DATEADD(DAY, 1, [date]) <= @endDate
)

INSERT INTO tableOfDates
select * from dates_for_calender
option (maxrecursion 366);

select * from tableOfDates
order by [date];

drop table tableOfDates;

-----------------------------------------------------------------------------------------------------------

--5.Display Emp and Manager Hierarchies based on the input till the topmost hierarchy. (Input would be empid) Output: Empid, empname, managername, heirarchylevel

drop table employeeTable;

create table employeeTable(
emp_id int primary key,
emp_name nvarchar(50),
manager_id int);

insert into employeeTable
values
(1, 'A', null),
(2, 'b', 1),
(3, 'c', 1),
(4, 'd', 2),
(5, 'e', 2),
(6, 'f', 2);

WITH cte AS (
    SELECT e.emp_id, e.emp_name, CAST('ceo' AS VARCHAR(20)) AS manager_name, 1 AS emp_level
    FROM employeeTable AS e
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.emp_id, e.emp_name, m.emp_name AS manager_name, (emp_level + 1) AS hierarchy_level
    FROM employeeTable AS e
    INNER JOIN cte m ON m.emp_id = e.manager_id
)
SELECT * FROM cte ORDER BY emp_level;
