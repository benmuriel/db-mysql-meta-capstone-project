 -- 1 create view
DROP VIEW IF EXISTS OrderView;
CREATE VIEW OrderView AS SELECT * FROM orders;

-- 2 request with join
SELECT c.customer_id, c.name, o.order_id, m.price as cost, m.menu_name, mi.cours_name
FROM orders o  
INNER JOIN customers c ON c.customer_id = o.customer_id  
INNER JOIN menus m on m.menu_id = o.menu_id
INNER JOIN menu_items mi ON mi.menu_id = m.menu_id;

-- 3 request with any
SELECT m.menu_name 
FROM menus m 
INNER JOIN menu_items mi ON m.menu_id = mi.menu_id

WHERE menu_item_id = ANY(SELECT mi.menu_item_id
FROM menu_items mi
INNER JOIN menus m ON m.menu_id = mi.menu_id
INNER JOIN orders o on o.menu_id = m.menu_id
WHERE o.quantity > 2)