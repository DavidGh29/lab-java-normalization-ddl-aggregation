CREATE DATABASE lab_week_6_final;

USE lab_week_6_final;

CREATE TABLE authors (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE articles (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          title VARCHAR(255) NOT NULL,
                          word_count INT NOT NULL CHECK ( word_count > 0 ),
                          views INT NOT NULL CHECK ( views >= 0 ),
                          author_id INT,
                          FOREIGN KEY (author_id) REFERENCES authors(id)
);

INSERT INTO authors (name) VALUES
                               ('Maria Charlotte'),
                               ('Juan Perez'),
                               ('Gemma Alcocer');

INSERT INTO articles (title, word_count, views, author_id) VALUES
                                                               ('Best Paint Colors',814,14,1),
                                                               ('Small Space Decorating Tips',1146,221,2),
                                                               ('Hot Acessories',986,105,1),
                                                               ('Mixing Textures',765,22,1),
                                                               ('Kitchen Refresh',1242,307,2),
                                                               ('Homemade Art Hacks',1002,193,1),
                                                               ('Refinishing Wood Floors',1571,7542,3);

CREATE TABLE customers (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           status VARCHAR(20) NOT NULL,
                           total_mileage INT NOT NULL CHECK ( total_mileage >=0 )
);

CREATE TABLE aircrafts (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           name VARCHAR(100) NOT NULL UNIQUE,
                           total_seats INT NOT NULL CHECK ( total_seats >0 )
);

CREATE TABLE flights (
                         flight_number VARCHAR(10) PRIMARY KEY,
                         aircraft_id INT,
                         mileage INT NOT NULL CHECK ( mileage >0 ),
                         FOREIGN KEY (aircraft_id) REFERENCES aircrafts (id)
);

CREATE TABLE bookings (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          customer_id INT,
                          flight_number VARCHAR(10),
                          FOREIGN KEY (customer_id) REFERENCES customers(id),
                          FOREIGN KEY (flight_number) REFERENCES flights(flight_number)
);

INSERT INTO aircrafts (name, total_seats) VALUES
                                              ('Boeing 747',400),
                                              ('Airbus A330',236),
                                              ('Boeing 777',264);

INSERT INTO customers (name, status, total_mileage) VALUES
                                                        ('Agustine Riviera', 'Silver', 115235),
                                                        ('Alaina Sepulvida', 'None', 6008),
                                                        ('Tom Jones', 'Gold', 205767),
                                                        ('Sam Rio', 'None', 2653),
                                                        ('Jessica James', 'Silver', 127656),
                                                        ('Ana Janco', 'Silver', 136773),
                                                        ('Jennifer Cortez', 'Gold', 300582),
                                                        ('Christian Janco', 'Silver', 14642);

INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES
                                                              ('DL143', 1, 135),
                                                              ('DL122', 2, 4370),
                                                              ('DL53', 3, 2078),
                                                              ('DL222', 3, 1765),
                                                              ('DL37', 1, 531);

INSERT INTO bookings (customer_id, flight_number) VALUES
                                                      (1,'DL143'),
                                                      (1,'DL122'),
                                                      (2,'DL122'),
                                                      (3,'DL122'),
                                                      (3,'DL53'),
                                                      (3,'DL222'),
                                                      (4,'DL143'),
                                                      (4,'DL37'),
                                                      (5,'DL143'),
                                                      (5,'DL122'),
                                                      (6,'DL222'),
                                                      (7,'DL222'),
                                                      (8,'DL222');

SELECT COUNT(DISTINCT flight_number) FROM flights;
SELECT AVG(mileage) FROM flights;
SELECT AVG(total_seats) FROM aircrafts;
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;
SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%';
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;

SELECT c.status, AVG(f.mileage)
FROM bookings b
         JOIN customers c ON b.customer_id = c.id
         JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;

SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
         JOIN customers c ON b.customer_id = c.id
         JOIN flights f ON b.flight_number = f.flight_number
         JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
    LIMIT 1;