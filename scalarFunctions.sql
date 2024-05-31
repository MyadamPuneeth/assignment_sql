--Scalar Functions / Create function

create function dbo.calculateAge1 (@birthday date)
returns int
as

BEGIN

declare @age int
set @age = DATEDIFF(year ,@birthday, GETDATE());

return @age

END

select dbo.calculateAge1('1762-04-14') as age;

select * from peopleAndDobs;

create table peopleAndDobs (
p_name nvarchar(20),
p_dob date,
p_num int primary key);

insert into peopleAndDobs values
('a', '1234-12-19', 1),
('b', '2023-07-16', 2),
('c', '1938-03-23', 3),
('d', '1783-10-07', 4);

select dbo.calculateAge1(p_dob) as age from peopleAndDobs;

-----------------------------------------------------------------------------------------------------------

-- COALESCE