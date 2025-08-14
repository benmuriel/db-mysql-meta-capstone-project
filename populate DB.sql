INSERT INTO menus(menu_name, price, category, cuisine)
VALUES('menu 1',2.5,'category 1', 'cuisine 1'),
('menu 2',2.6,'category 2', 'cuisine 2'),
('menu 3',1.5,'category 3', 'cuisine 3');

INSERT INTO menu_items(menu_id,cours_name, starter_name,dessert_name)
VALUES (1,'cours 11','starter 11','dessert 11'),(1,'cours 12','starter 12','dessert 12'),
(2,'cours 21','starter 21','dessert 21'),(2,'cours 22','starter 22','dessert 22'),
(3,'cours 31','starter 31','dessert 31'),(3,'cours 32','starter 32','dessert 32');

INSERT INTO customers (name,mail)
VALUES('customer 1', 'customer1@mail.com'),
('customer 2', 'customer2@mail.com'),
('customer 3', 'customer3@mail.com');

INSERT INTO orders(order_date,quantity,total_cost, menu_id, customer_id)
VALUES('2024-02-11',3,5.2,1,1),('2024-02-11',1,2.6,2,1),('2024-02-14',6,5.5,3,3),
('2024-02-15',3,5.2,1,1),('2024-02-21',1,2.6,2,1),('2024-02-14',1,9.5,2,3),
('2024-03-01',3,5.2,1,1),('2024-03-10',1,2.6,2,1),('2024-04-02',2,4.5,2,2);

