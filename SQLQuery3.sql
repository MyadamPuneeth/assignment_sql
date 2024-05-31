use database_267_1

SELECT name AS tables
INTO dataBaseTables
FROM sys.tables;

SELECT * FROM dataBaseTables;

CREATE TABLE user_details(
	userName VARCHAR(50), 
	userId int);

IF EXISTS (SELECT * FROM sys.tables where name= 'USER_DETAILS')
	CREATE TABLE user_details_2(
	userName VARCHAR(50), 
	userId int);
ELSE CREATE TABLE USER_DETAILS(
	userName VARCHAR(50), 
	userId int);
	
select* from user_details_2;

select * from sys.tables;

select * from sys.indexes;

select * from sys.indexes where type_desc = 'HEAP';

select * from sys.objects where object_id = 1301579675;

select * from sys.objects;

create table testTable (
id int,
tname VARCHAR(20),
salary int);

select * from testTable;

INSERT INTO testTable 
VALUES 
(345678, 'ram', 4568962),
(8, 'hanuman', 634),
(47, 'laxman', 87654345);

INSERT INTO testTable
VALUES 
(1, 'A', 5),
(2, 'b', 6),
(3, 'c', 7);

alter table testTable alter column id int NOT NULL;

alter table testTable add constraint pk primary key (id);

select * into duplicateTestTable from testTable;

select * into newDuplicateTestTable from duplicateTestTable where 1 = 0;

insert into duplicateTestTable 
values 
(32, 'puns', 098765),
(23, 'punee', 345670);

alter table duplicateTestTable alter column id int NOT NULL;

select * into newDuplicateTestTable2 from duplicateTestTable where id = 123456789;

select * from newDuplicateTestTable2;

DBCC SHOWCONTIG('products') WITH TABLERESULTS;

create table arigato(
aname NVARCHAR(10),
aid INT,
bigintVar BIGINT,
floatVar FLOAT,
decimalVar DECIMAL(10,4));

INSERT INTO arigato
VALUES
(1, 12345678, 1236754322, 124567.9876, 124567.9876),
(1, 12345678, 1236754322, 124567.98786, 124567.98786);

select * from arigato;

select * into arigato2 from arigato;

select distinct aid, bigintVar from arigato;

delete from arigato where aid = (select distinct aid from arigato);

select * from sys.tables;

select * from testTable;

Select tname,
'salary_info' = case 
when salary>500 and salary<6000000 then 'salary less than 500 but greater than 60000000'
end
into empSalary
from testTable;

select * from employeeTable;

create table employeeTable (
emp_id int primary key,
emp_name nvarchar(1000),
emp_salary money,
emp_date date,
emp_experience int
);

alter table employeeTable alter column emp_experience int not null;

create table computedColumnTable (column1 int, column2 int);

declare @i int;
declare @j int;
set @j = 1000;
set @i = 1;

while @i >= 1 and @i <=1000
begin
	insert into computedColumnTable values (@i, @j);
	set @i= @i+1
	set @j= @j-1
end

select * from computedColumnTable;

alter table computedColumnTable add computed_cloumn as column1*column2;
alter table computedColumnTable add computed_cloumn_add as column1+column2;
alter table computedColumnTable add computed_cloumn_sub as column1-column2;

select * from computedColumnTable
order by computed_cloumn asc, column1 desc;

SELECT SYSDATETIMEOFFSET() AS CurrentDateTimeWithOffset;

SELECT GETDATE() AS CurrentDateTime;

select abs(-1234.987654);

select floor(87458*0.32483);
select (87458*0.32483);

select ISNUMERIC('pkjh');

select charindex ('hey', 'hello hi hiiii hey how are you?');

select convert ('8765' as int) as errorType;

SELECT PARSE('12/25/2023' AS DATE USING 'en-US') AS ParsedDate;

SELECT DATEPART(year, GETDATE()) AS CurrentYear;


