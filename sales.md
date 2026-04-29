# andmebaas sales
```sql
--1. categories
create table categories(
categoryID INT primary key identity(1,1),
category_name varchar(25) Unique);
insert into categories(category_name)
values('Arvuti')
select * from categories
```
<img width="215" height="88" alt="{93C74CA9-58AF-448A-9251-14C2D1762CC4}" src="https://github.com/user-attachments/assets/cbbd8135-6064-49c7-a1c1-b2093ccb86ba" />

```sql
--2. brands
CREATE TABLE brands(
brand_id int PRIMARY KEY identity(1,1),
brand_name varchar(15) UNIQUE);
INSERT INTO brands(brand_name)
VALUES ('SAMSUNG');
SELECT * FROM brands;
```
<img width="202" height="103" alt="{895C88F5-A95A-47CD-BF89-4BC0FA5E3B57}" src="https://github.com/user-attachments/assets/92a23ac5-8de8-4076-a5e0-d2dcdf6828c5" />

```sql
--3. products
Create TABLE products(
product_id int PRIMARY KEY identity(1,1),
product_name varchar(50) not null,
brand_id int,
FOREIGN KEY (brand_id) references brands(brand_id),
category_id int,
FOREIGN KEY (category_id) references categories(categoryid),
model_year int,
list_price money);

SELECT * FROM products;

INSERT INTO products
VALUES ('nutitelefonˇX10' , 1, 1, 2025, 600);
```
<img width="506" height="109" alt="{DF37030F-228F-48D4-A90F-98E521C071F8}" src="https://github.com/user-attachments/assets/2dea367c-9ddb-4666-9372-49676d4836b1" />

```sql
--4. stores
CREATE TABLE stores(
Store_id int PRIMARY KEY identity (1,1),
store_name varchar(20) not null,
phone varchar(13),
email varchar(21),
street varchar(21),
city varchar(15),
state varchar(10),
zip_code char(5)
) 
SELECT * FROM stores

INSERT INTO stores
VALUES('ülemiste', '58801233', 'ülemiste@gmail.com', 'ülemiste tee', 'Tallinn', 'Eesti', '53765');
```
<img width="595" height="112" alt="{4D0B5866-F70C-4C57-A29F-6BB5EA31B6E1}" src="https://github.com/user-attachments/assets/b7629c02-663c-4a31-af8a-afb7a8541874" />

```sql
--5. stocks
CREATE TABLE stocks(
store_id int,
product_id int,
PRIMARY KEY (store_id, product_id),
FOREIGN KEY (store_id) references stores(store_id),
FOREIGN KEY (product_id) references products(product_id),
quantity int)

SELECT * FROM stocks;

INSERT INTO stocks
VALUES(1, 1, 4)
```
<img width="254" height="102" alt="{FBCC25B1-2E5E-487E-A6E6-60926D50FD44}" src="https://github.com/user-attachments/assets/fc78b02a-f99b-4807-857d-b2a93fef1b73" />

```sql
--6. customers
create table customers(
customerID int PRIMARY KEY identity(1,1),
first_name varchar(15) not null,
last_name varchar(15) not null,
phone varchar(13),
email varchar(20),
street varchar(15),
city varchar(15) check (city='Tallinn' or city='Narva'),
state varchar(15),
zip_code char(5)
)
insert into customers
values('Andrei', 'Lomov', '5298034', 'AndreiLomov@gmail.co', 'Ülemiste', 'Tallinn', 'Harjumaa', '13912')
select * from customers
```
<img width="683" height="106" alt="{E3D19B24-AACC-42C3-BE81-C825A7BC9C6C}" src="https://github.com/user-attachments/assets/9ad49ba6-2b97-43b3-bae2-ae82b7a371c1" />

```sql
--7. staffs
create table staff(
staffID int primary key identity(1,1),
first_name varchar(15) not null,
last_name varchar(15) not null,
email varchar(25),
phone varchar(13),
active bit,
storeID int,
FOREIGN KEY (storeID) references stores(store_ID),
manager bit
);
insert into staff 
values('Alex','Tag','AlexTag@gmail.com', '56111714', 1, 1, 0)
```
<img width="581" height="100" alt="{85A3C57A-F74E-401C-8F02-F981399DB8EC}" src="https://github.com/user-attachments/assets/3dec5b1e-7e9a-421e-aeef-eae0eb9486e0" />

```sql
--8. orders
create table orders(
order_id int PRIMARY KEY identity (1,1),
customer_id int,
order_status varchar(15) Check(order_status='complete' or order_status='incomplete'),
order_date Date,
required_date Date,
shipped_date Date,
store_id int,
staff_id int,
FOREIGN KEY (customer_id) references customers(customerID),
FOREIGN KEY (store_id) references Stores(Store_id),
FOREIGN KEY (staff_id) references staff(staffID)
)
INSERT INTO orders
VALUES(2, 'complete', '2026-04-29', '2026-05-01','2026-06-07', 1, 2);
Select * FROM orders
```
<img width="590" height="101" alt="{AAA04FAA-B583-4BF4-9DE6-832806443018}" src="https://github.com/user-attachments/assets/d8c48b42-09a7-4401-a5c5-443f1418835a" />

```sql
--9. order_items
create table order_items(
order_id int,
item_id int,
PRIMARY KEY (order_id, item_id),
product_id int,
quantity int,
list_price money,
discount int,
FOREIGN KEY (order_id) references orders(order_id),
FOREIGN KEY(product_id) references products(product_id)
)
Select * from order_items
INSERT INTO order_items
Values(4,2,1,150,1267.00, 50)
```
<img width="403" height="104" alt="{91A4F1FB-14EF-49AB-A380-4C71F098D706}" src="https://github.com/user-attachments/assets/196fc15e-d042-48b8-a5c8-5dd911607e6d" />

Diagramm
<img width="878" height="684" alt="{4D893819-10E0-4CAF-8E72-A689D6F9F571}" src="https://github.com/user-attachments/assets/5dbcaf6a-11b6-4665-9509-e874386aed29" />



