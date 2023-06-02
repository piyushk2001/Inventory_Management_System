#Delete Tables
Drop table issue_receive;
Drop table inv_overstock;
Drop table inv_understock;
Drop table item;

#Set Safety
set sql_safe_updates = 0;
set foreign_key_checks = 0;

#Item Table
create table item 
(item_id varchar(50) primary key, 
name varchar(50), 
description varchar(50), 
price decimal(18, 2), 
quantity int, 
threshold int default 20);

#Understocking Table
create table inv_understock
(num int primary key auto_increment,
item_id varchar(50), 
name varchar(50),
quantity int,
last_update_date date,
foreign key(item_id) references item(item_id));

#Overstocking Table
create table inv_overstock
(num int primary key auto_increment,
item_id varchar(50),
name varchar(50),
quantity int,
last_update_date date,
foreign key(item_id) references item(item_id));

#Issue/Receive Table
create table issue_receive
(num int primary key auto_increment,
item_id varchar(50),
transaction_type enum("issue", "receive") not null,
quantity int,
date date,
foreign key(item_id) references item(item_id));

#Fill Item records
insert into item(item_id, name, description, price, quantity) values
('1001', 'Samsung Galaxy S21', 'High-end Android smartphone', 999.00, 30),
('1002', 'Apple iPhone 12', 'A powerful smartphone with 5G support', 899.00, 20),
('1003', 'Sony WH-1000XM4', 'Premium noise-cancelling headphones', 349.00, 25),
('1004', 'Bose QuietComfort 35 II', 'Wireless noise-cancelling headphones', 299.00, 30),
('1005', 'Dell XPS 13', 'Ultra-portable laptop with stunning display', 1299.00, 10),
('1006', 'HP Spectre x360', 'Convertible laptop with excellent battery life', 1099.00, 15),
('1007', 'Logitech MX Master 3', 'Wireless mouse for productivity', 99.00, 20),
('1008', 'Apple MacBook Air', 'Sleek and lightweight laptop', 999.00, 12),
('1009', 'Lenovo ThinkPad X1 Carbon', 'Business ultrabook', 1499.00, 8),
('1010', 'Google Pixel 5', 'Flagship Android smartphone', 699.00, 18),
('1011', 'Microsoft Surface Pro 7', 'Powerful tablet/laptop hybrid', 1199.00, 14),
('1012', 'Samsung Galaxy Watch 3', 'Premium smartwatch with LTE support', 399.00, 10),
('1013', 'Apple iPad Pro', 'High-end tablet with Apple Pencil support', 799.00, 20),
('1014', 'Sony Alpha a7 III', 'High-end mirrorless camera', 1999.00, 5),
('1015', 'Canon EOS R6', 'Full-frame mirrorless camera', 2499.00, 3),
('1016', 'DJI Mavic Air 2', 'High-end drone with 4K video support', 799.00, 7),
('1017', 'Bose SoundLink Revolve+', 'Portable Bluetooth speaker', 299.00, 20),
('1018', 'Sonos Beam', 'Smart soundbar for home entertainment', 399.00, 8),
('1019', 'Amazon Echo Dot', 'Smart speaker with Alexa support', 49.00, 30),
('1020', 'Nest Learning Thermostat', 'Smart thermostat', 249.00, 12),
('1021', 'Philips Hue White and Color Ambiance Starter Kit', 'Smart lighting', 179.00, 15),
('1022', 'Samsung Galaxy Buds Pro', 'High-end wireless earbuds', 199.00, 25),
('1023', 'Apple AirPods Pro', 'Premium noise-cancelling wireless earbuds', 249.00, 20),
('1024', 'Microsoft Xbox Series X', 'Next-generation gaming console', 499.00, 6),
('1025', 'Sony PlayStation 5', 'High-end gaming console', 499.00, 8),
('1026', 'Oculus Quest 2', 'All-in-one virtual reality headset', 399.00, 10),
('1027', 'Fitbit Versa 3', 'Premium smartwatch with fitness tracking', 229.00, 18),
('ITM001', 'Laptop', '8GB RAM 256GB SSD', 999.99, 50),
('ITM002', 'Desktop Computer', 'Intel Core i7 16GB RAM 1TB HDD', 1499.99, 30),
('ITM003', 'Tablet', '4GB RAM 128GB storage', 399.99, 100);

#Initial default values
insert into inv_understock (item_id, name, quantity, last_update_date) 
select item_id, name, quantity, curdate() from item where quantity < 20;
insert into inv_overstock (item_id, name, quantity, last_update_date) 
select item_id, name, quantity, curdate() from item where quantity > 20;

select * from item;
select * from inv_understock;
select * from inv_overstock;
select * from issue_receive;