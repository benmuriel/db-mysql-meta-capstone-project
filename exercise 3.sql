-- 1 insert booking
TRUNCATE TABLE bookings;
INSERT INTO bookings (booking_date, table_number,customer_id)
VALUES ('2022-10-10',5,1),('2022-11-12',3,3),('2022-10-11',2,2),('2022-10-13',2,1)

-- 2 procedure CheckBooking

DELIMITER //
DROP PROCEDURE IF EXISTS CheckBooking//
CREATE PROCEDURE CheckBooking(bookingDate DATE, tableNumber INT)
BEGIN
	SELECT CASE WHEN EXISTS(SELECT * FROM bookings WHERE booking_date = bookingDate AND table_number = tableNumber) 
    THEN CONCAT('Table ',tableNumber, ' is already booked') ELSE CONCAT('Table ',tableNumber, ' is free') END 
    AS 'Booking status';
END//
DELIMITER ;
CALL CheckBooking('2022-11-12',3);


-- 3 procedure AddValidBooking

DELIMITER //
DROP PROCEDURE IF EXISTS AddValidBooking//
CREATE PROCEDURE AddValidBooking(bookingDate DATE, customerId INT, tableNumber INT)
BEGIN
START TRANSACTION;
INSERT INTO bookings  (booking_date, table_number,customer_id)
VALUES(bookingDate,tableNumber,customerId);
IF (NOT EXISTS(SELECT * FROM bookings WHERE booking_date = bookingDate AND table_number = tableNumber)) THEN
	COMMIT;
	SELECT CONCAT('Table ',tableNumber, ' is now booked') AS 'Booking status' ;
ELSE
    ROLLBACK;
    SELECT CONCAT('Table ',tableNumber, ' is already booked - booking cancelled') AS 'Booking status' ;
END IF;
END//
DELIMITER ;
CALL AddValidBooking('2022-11-12',2,3);