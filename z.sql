-- List all databases
show databases;

-- Select a DB
use cartdb;

-- List all tables
show tables;

-- Inspect columns of a table
show columns from product;

-- List all records from product
select * from product limit 10;

-- Insert multiple records
insert into product (name, price) values
('Apple', 3.4),
('Orange', 3.3);

-- Update record by id
update product set name = "long bean"
where id = 1;

update product set description = "I am green"
where id = 1;

update product set price = 0.99
where id = 4;

-- YYYY-MM-DDTHH:mm:ss.sssZ
-- YYYY-MM-DD HH:mm:ss

update product set description = "I am orange"
where id = 2;

update product set description = "I am red"
where id = 3;

-- Check your timezone of the database instance
SELECT @@global.time_zone, @@session.time_zone;

-- Update all records' description when name has 'o'

update product set description = "I have letter o"
where name like '%o%';
-- o% behind it will change the name start with 'o'

update product set description = "I am expensive" 
where price > 2;

update product set description = "my timestamp is null"
where created_at is null;

update product set description = "my timestamp is not null"
where created_at is not null;

-- when making changes select first and check the data before changes
select * from product where created_at is null;

delete from product where name = 'apple';

insert into product (name, price) values
("apple", 3.4),
("orange", 3.3),
("cabbage", 1),
("carrot", 1.5),
("potato", 1.8);

update product set description = "I am orange"
where id = 6;

-- PK = Private Key
-- FK = Foreign Key (Foreign Key must be a Private Key of another product)

-- create a cart table
create table cart (
    id int primary key not null auto_increment,
    quantity int not null,
    product_id int not null,
    created_at timestamp default current_timestamp,
    foreign key (product_id) references product(id)
);

-- 4 carrots, 6 apples, 2 oranges

insert into cart (product_id, quantity) values
(8, 4), (5, 6), (6, 2);

-- inner join = join 2 tables product table and cart table
select p.name, c.quantity 
from product p inner join cart c
on p.id = c.product_id;

select p.name, p.price, c.quantity 
from product p inner join cart c 
on p.id = c.product_id;


insert into product (name, price) values ("Pineapple Tart", 10), ("Mango", 7.3), ("Pear", 2.2), ("Carrot", 1.2);
insert into cart (product_id, quantity) values 
    ((select id from product where name = "Pineapple Tart"), 5), 
    ((select id from product where name = "Mango"), 2), 
    ((select id from product where name = "Pear"), 6);

-- Code Challenge 1 - Formulate a query with the following criterias:
-- 1. Select:
-- name
-- price
-- quantity
-- 2. Where:
-- price is greater than 3
-- 3. Order:
-- by name ascending order (ASC)
   select p.name, p.price, c.quantity 
    from product p inner join cart c 
    on p.id = c.product_id 
    where p.price > 3 
    order by p.name;


-- Code Challenge 2 - Formulate a query with the following criterias:
-- 1. Select:
-- name
-- price
-- quantity
-- payableWithGst (Include 8% of GST)
-- 2. Where:
-- price is greater than 3
-- 3. Order:
-- by quantity descending order (DESC)
  select p.name, p.price, c.quantity, (p.price * 1.08) as payable_with_gst 
    from product p inner join cart c 
    on p.id = c.product_id
    where p.price > 3
    order by c.quantity desc;

-- Code Challenge 4: Distinct product
-- 1. Select:
-- distinct product name
    select distinct name from product;

-- Code Challenge 5: Count total number of products
-- 1. Select:
-- count product name
    select count(1) from product;

-- Code Challenge 6: Sum the price of all products
-- Select:
-- sum of price
    select round(sum(price),2) as total_price from product;


