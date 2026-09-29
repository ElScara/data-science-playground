/*Route Details Table*/
CREATE TABLE route_details (
    route_id INT UNIQUE, 
    flight_num INT CHECK (flight_num IS NOT NULL),
    origin_airport VARCHAR(50),
    destination_airport VARCHAR(50),
    aircraft_id VARCHAR(50),
    distance_miles INT CHECK (distance_miles > 0)
);

/*Extract Passengers on Specific Routes*/
SELECT DISTINCT customer_id 
FROM passengers_on_flights 
WHERE route_id BETWEEN 1 AND 25;

/*Identify the number of passengers and total revenue in business class*/
SELECT COUNT(customer_id) AS number_of_passengers, 
       SUM(price_per_ticket * no_of_tickets) AS total_revenue 
FROM ticket_details 
WHERE class_id = 'Business';

/*Display the full name of the customer*/
SELECT CONCAT(first_name, ' ', last_name) AS full_name 
FROM customer;

/* Extract customers who have registered and booked a ticket*/
SELECT DISTINCT c.customer_id, c.first_name, c.last_name 
FROM customer c
INNER JOIN ticket_details t ON c.customer_id = t.customer_id;

/*Identify customers based on brand (Emirates)*/
SELECT c.first_name, c.last_name 
FROM customer c
JOIN ticket_details t ON c.customer_id = t.customer_id
WHERE t.brand = 'Emirates';

/*Customers in Economy Plus (Group By & Having)*/
SELECT customer_id 
FROM passengers_on_flights 
GROUP BY customer_id, class_id 
HAVING class_id = 'Economy Plus';

/*Check if total revenue crossed 10000*/
SELECT SUM(price_per_ticket * no_of_tickets) AS Total_Revenue,
       IF(SUM(price_per_ticket * no_of_tickets) > 10000, 'Crossed 10000', 'Not Crossed 10000') AS Revenue_Status
FROM ticket_details;

/* Create and grant access to a new DBA user*/
CREATE USER 'new_dba_user'@'localhost' IDENTIFIED BY 'SecurePass123!';
GRANT ALL PRIVILEGES ON aircargo_db.* TO 'new_dba_user'@'localhost';
FLUSH PRIVILEGES;

/*Improve speed and extract passengers for Route ID 4*/
CREATE INDEX idx_route_id ON passengers_on_flights(route_id);

SELECT customer_id 
FROM passengers_on_flights 
WHERE route_id = 4;

/*View the execution plan for Route ID 4*/
EXPLAIN SELECT customer_id 
FROM passengers_on_flights 
WHERE route_id = 4;

/*Find maximum ticket price for each class (Window Function)*/
SELECT DISTINCT class_id, 
       MAX(price_per_ticket) OVER(PARTITION BY class_id) AS max_ticket_price
FROM ticket_details;

/*Calculate total price across different aircraft IDs (Rollup)*/
SELECT customer_id, aircraft_id, SUM(price_per_ticket * no_of_tickets) AS total_price
FROM ticket_details
GROUP BY customer_id, aircraft_id WITH ROLLUP;

/* Create a view for Business class customers*/
CREATE VIEW business_class_view AS
SELECT c.customer_id, c.first_name, c.last_name, t.brand
FROM customer c
JOIN ticket_details t ON c.customer_id = t.customer_id
WHERE t.class_id = 'Business';

/*Create a stored procedure for passengers in a route range*/
DELIMITER //
CREATE PROCEDURE GetPassengersByRoute(IN start_route INT, IN end_route INT)
BEGIN
    DECLARE table_count INT;
    SELECT COUNT(*) INTO table_count 
    FROM information_schema.tables 
    WHERE table_schema = DATABASE() AND table_name = 'passengers_on_flights';
    
    IF table_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Table passengers_on_flights does not exist';
    ELSE
        SELECT * FROM passengers_on_flights 
        WHERE route_id BETWEEN start_route AND end_route;
    END IF;
END //
DELIMITER ;

/*Create a stored procedure for long-distance routes (>2000 miles*/
DELIMITER //
CREATE PROCEDURE GetLongDistanceRoutes()
BEGIN
    SELECT * FROM routes WHERE Distance_miles > 2000;
END //
DELIMITER ;

/*Create a stored procedure to group flight distances (SDT, IDT, LDT)*/
DELIMITER //
CREATE PROCEDURE GroupFlightDistances()
BEGIN
    SELECT Flight_num, Distance_miles,
           CASE 
               WHEN Distance_miles BETWEEN 0 AND 2000 THEN 'SDT'
               WHEN Distance_miles > 2000 AND Distance_miles <= 6500 THEN 'IDT'
               WHEN Distance_miles > 6500 THEN 'LDT'
           END AS Distance_Category
    FROM routes;
END //
DELIMITER ;

/*Create a function and procedure for complimentary services*/
DELIMITER //
CREATE FUNCTION CheckComplimentary(class_id VARCHAR(50)) 
RETURNS VARCHAR(3) DETERMINISTIC
BEGIN
    DECLARE is_complimentary VARCHAR(3);
    IF class_id IN ('Business', 'Economy Plus') THEN
        SET is_complimentary = 'Yes';
    ELSE
        SET is_complimentary = 'No';
    END IF;
    RETURN is_complimentary;
END //

CREATE PROCEDURE GetComplimentaryDetails()
BEGIN
    SELECT p_date, customer_id, class_id, 
           CheckComplimentary(class_id) AS complimentary_services
    FROM ticket_details;
END //
DELIMITER ;

/*Extract the first customer whose last name ends with 'Scott' using a Cursor*/
DELIMITER //
CREATE PROCEDURE GetCustomerScott()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_fname VARCHAR(50);
    DECLARE c_lname VARCHAR(50);
    
    DECLARE scott_cursor CURSOR FOR 
        SELECT customer_id, first_name, last_name 
        FROM customer 
        WHERE last_name LIKE '%Scott' LIMIT 1;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN scott_cursor;
    FETCH scott_cursor INTO c_id, c_fname, c_lname;
    
    IF NOT done THEN
        SELECT c_id, c_fname, c_lname;
    END IF;
    
    CLOSE scott_cursor;
END //
DELIMITER ;