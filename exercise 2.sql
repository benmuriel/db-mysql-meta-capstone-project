
-- 1   procedure GetMaxQuantity
DROP PROCEDURE IF EXISTS GetMaxQuantity;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN 
 SELECT MAX(quantity) AS 'Max Quantity in Order'
 FROM orders;
END//
DELIMITER ;

-- 2 prepared request

PREPARE GetOrderDetail 'SELECT order_id, quantity, total_cost FROM orders WHERE order_id = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- 3  procedure cancelOrder
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(orderID INT)
BEGIN 
 DELETE FROM  orders WHERE order_id = orderID;
SELECT CONCAT('Order ',orderID,' IS CANCELLED');
END//
DELIMITER ;