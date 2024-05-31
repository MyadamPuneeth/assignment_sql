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
    SELECT e.emp_id, e.emp_name, CAST('ceo' AS NVARCHAR(20)) AS manager_name, 1 AS emp_level
    FROM employeeTable AS e
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.emp_id, e.emp_name, m.emp_name AS manager_name, (emp_level + 1) AS hierarchy_level
    FROM employeeTable AS e
    INNER JOIN cte m ON m.emp_id = e.manager_id
)
SELECT * FROM cte ORDER BY emp_level;

select * from computedColumnTable;

alter table computedColumnTable drop column computed_column_div;

/* select column1 , column2 from computedColumnTable where computed_cloumn_add >0
group by computed_cloumn_sub having computed_cloumn_sub < 50000 order by column2; */

alter table computedColumnTable add constraint pk primary key (computed_cloumn);

alter table computedColumnTable alter column computed_cloumn int not null;

