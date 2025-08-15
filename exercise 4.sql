-- 1 procedure AddValidBooking

DELIMITER //
DROP PROCEDURE IF EXISTS AddBooking//
CREATE PROCEDURE AddBooking( customerId INT, tableNumber INT,bookingDate DATE)
BEGIN
START TRANSACTION;
INSERT INTO bookings  (booking_date, table_number,customer_id)
VALUES(bookingDate,tableNumber,customerId);
IF (NOT EXISTS(SELECT * FROM bookings WHERE booking_date = bookingDate AND table_number = tableNumber)) THEN
	COMMIT;
	SELECT 'New booking added' AS 'Confirmation' ;
ELSE
    ROLLBACK;
    SELECT CONCAT('Table ',tableNumber, ' is already booked - booking cancelled') AS  'Confirmation' ;
END IF;
END//
DELIMITER ;
CALL AddBooking(2,3,'2022-11-12');

DELIMITER //
DROP PROCEDURE IF EXISTS UpdateBooking//
CREATE PROCEDURE UpdateBooking( bookingID INT,bookingDate DATE)
BEGIN
IF (EXISTS(SELECT * FROM bookings WHERE booking_id = bookingID)) THEN
 UPDATE bookings SET booking_date = bookingDate WHERE booking_id = bookingID;
 SELECT CONCAT('Booking ',bookingID, ' updated') AS  'Confirmation' ;
 ELSE SELECT 'Booking not found' AS 'Confirmation' ;
 END IF;
END//
DELIMITER ;
CALL UpdateBooking(9,'2022-12-17');

DELIMITER //
DROP PROCEDURE IF EXISTS CancelBooking//
CREATE PROCEDURE CancelBooking( bookingID INT)
BEGIN
IF (EXISTS(SELECT * FROM bookings WHERE booking_id = bookingID)) THEN
 DELETE FROM bookings WHERE booking_id = bookingID;
 SELECT CONCAT('Booking ',bookingID, ' cancelled') AS  'Confirmation' ;
 ELSE SELECT 'Booking not found' AS 'Confirmation' ;
 END IF;
END//
DELIMITER ;
CALL CancelBooking(9);