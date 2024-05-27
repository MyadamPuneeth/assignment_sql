--table creation
create table customer_details(
name nvarchar(50),
product_name nvarchar(50),
cost decimal(10,4),
floatcost float,
purdate date
)

--insertion
insert into customer_details values(
'puneeth',
'phone',
15456.87698,
15456.87698,
'2024-05-10'
);

--displaying all the table elements
select * from customer_details;

--creating a view
create view customer_view as
select name, product_name, floatcost+cost as total_cost
from customer_details;

--displaying all the view elements
select*from customer_view;

--indexing
create index customer_idx on customer_details(name);

--displaying only name column
select name from customer_details;

--altering the table
alter table customer_details
add email nvarchar(50);

alter table customer_details
add sno int;

--add values in a particular column
update customer_details 
set sno= 2 
where cost= 15456.8770;

--deleting a single row
delete from customer_details where sno=2;

--deleting the whole table data but table intact
truncate table data_types
select * from data_types;

--deleting the table including the table itself
drop table customer_details
select * from customer_details

--renaming try 1 (status failed)
alter table data_types
CHANGE column FirstName modatiperu nvarchar(50);

--renaming try 2 (status passed)
exec sp_rename 'data_types.FirstName', 'modatiperu', 'COLUMN';

use database_267_1

-- USING TCL COMMANDS
create table products (
pName NVARCHAR(50),
pCost FLOAT,
pDuration INT,
pPurchasedFrom NVARCHAR(50)
);

SELECT * from products;

INSERT INTO products
VALUES
('phone', 15000, 10, 'flipkart'),
('book', 35, 15, 'stationery'),
('glasses', 2000, 100, 'baba opticals');

--update glasses, insert into, alter table (add primary key, sno)

SELECT * from products;

ALTER TABLE products 
ADD pSno INT;

SELECT * from products;

BEGIN TRANSACTION;

UPDATE products SET pSno = 1 WHERE pName = 'phone';

UPDATE products SET pSno = 2 WHERE pName = 'book';

UPDATE products SET pSno = 3 WHERE pName = 'glasses';

SELECT * from products;

SAVE TRANSACTION saveAfterUpdation;

UPDATE products SET pCost= 30000 WHERE pSno= 3;

IF @@ERROR <> 0
	ROLLBACK TRANSACTION saveAfterUpdation;
ELSE
	COMMIT TRANSACTION;

SELECT * from products;