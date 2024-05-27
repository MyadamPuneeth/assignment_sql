CREATE TABLE address_data (
sno INT PRIMARY KEY,
house_no NVARCHAR(50),
locality NVARCHAR(50),
area NVARCHAR(50),
city NVARCHAR(50));

DROP TABLE contact_data;

CREATE TABLE contact_data (
sno INT ,
c_sno INT PRIMARY KEY,
ph_no BIGINT,
email NVARCHAR(50),
alternate_ph_no BIGINT,
personName NVARCHAR(50),
FOREIGN KEY (sno) REFERENCES address_data(sno));

ALTER TABLE address_data
add personName NVARCHAR(50);


SELECT * from address_data;

SELECT * from contact_data;

INSERT INTO address_data
VALUES
(1, '13-6-457/23/A', 'Gudimalkapur', 'Mehdipatnam', 'Hyderabad', 'puneeth'),
(2, '13-6-457/53/1347', 'some-colony-A', 'madhapur', 'Hyderabad','vijay'),
(3, '13-6-457/53/1347', 'some-colony-A', 'madhapur', 'Hyderabad', 'Purendar'),
(4, '657-27-757', 'some-colony-B', 'bachupally', 'Hyderabad', 'rithvik');

INSERT INTO contact_data
VALUES
(1, 10, 7680826042, 'myadampuneeth@gmail.com', 9666425430, 'puneeth'),
(3, 20, 1234567890,'purendar@gmail.com', 8765434564, 'Purendar'),
(2, 30, 1234567890, 'vijay@gmail.com', 8765434564, 'vijay'),
(4, 40, 0987654321, 'rithvik@gmail.com', 2345678901, 'rithivk');

SELECT contact_data.ph_no, address_data.locality
FROM contact_data
JOIN address_data on contact_data.sno = address_data.sno
WHERE contact_data.personName = 'puneeth';

SELECT personName from address_data
where area = 'madhapur';

Drop database p123;

CREATE TABLE USERS_DETAILS (UNAME NVARCHAR(10), UNUM INT) INSERT VALUES ('PUNEETH', 267);
