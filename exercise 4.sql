-- 3 procedure AddValidBooking

DELIMITER //
DROP PROCEDURE IF EXISTS AddBooking//
CREATE PROCEDURE AddBooking( customerId INT, tableNumber INT,bookingDate DATE)
BEGIN
START TRANSACTION;
INSERT INTO bookings  (booking_date, table_number,customer_id)
VALUES(bookingDate,tableNumber,customerId);
IF (NOT EXISTS(SELECT * FROM bookings WHERE booking_date = bookingDate AND table_number = tableNumber)) THEN
	COMMIT;
	SELECT CONCAT('Table ',tableNumber, ' is now booked') ;
ELSE
    ROLLBACK;
    SELECT CONCAT('Table ',tableNumber, ' is already booked - booking cancelled') ;
END IF;
END//
DELIMITER ;
CALL AddValidBooking('2022-11-12',2,3);