-- =========================================
-- SwiftRide Database Schema
-- =========================================
CREATE DATABASE IF NOT EXISTS swiftride_db;
USE swiftride_db;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(256) NOT NULL,
    profile_image VARCHAR(255) DEFAULT NULL,
    wallet_balance DECIMAL(10,2) DEFAULT 0.00,
    reward_points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_users_email (email)
) ENGINE=InnoDB;

-- Admins Table
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(256) NOT NULL,
    role VARCHAR(50) DEFAULT 'SUPER_ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_admins_email (email)
) ENGINE=InnoDB;

-- Routes Table
CREATE TABLE IF NOT EXISTS routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    origin VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    distance_km DECIMAL(8,2) DEFAULT NULL,
    estimated_duration VARCHAR(20) DEFAULT NULL,
    is_popular BOOLEAN DEFAULT FALSE,
    badge VARCHAR(20) DEFAULT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_routes_origin (origin),
    INDEX idx_routes_destination (destination)
) ENGINE=InnoDB;

-- Buses Table
CREATE TABLE IF NOT EXISTS buses (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_name VARCHAR(100) NOT NULL,
    bus_type ENUM('AC_SLEEPER','AC_SEATER','NON_AC_SLEEPER','NON_AC_SEATER') NOT NULL,
    bus_number VARCHAR(20) NOT NULL UNIQUE,
    total_seats INT NOT NULL DEFAULT 40,
    route_id INT NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    amenities VARCHAR(255) DEFAULT NULL,
    rating DECIMAL(3,2) DEFAULT 0.00,
    total_ratings INT DEFAULT 0,
    operator_name VARCHAR(100) DEFAULT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    INDEX idx_buses_route (route_id),
    INDEX idx_buses_type (bus_type)
) ENGINE=InnoDB;

-- Seats Table
CREATE TABLE IF NOT EXISTS seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    seat_number VARCHAR(5) NOT NULL,
    seat_type ENUM('LOWER','UPPER','SEATER') DEFAULT 'SEATER',
    is_booked BOOLEAN DEFAULT FALSE,
    travel_date DATE DEFAULT NULL,
    locked_until TIMESTAMP NULL DEFAULT NULL,
    locked_by INT DEFAULT NULL,
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE,
    INDEX idx_seats_bus_date (bus_id, travel_date),
    UNIQUE KEY uk_seat_bus_date (bus_id, seat_number, travel_date)
) ENGINE=InnoDB;

-- Bookings Table
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_code VARCHAR(20) NOT NULL UNIQUE,
    pnr_number VARCHAR(15) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    bus_id INT NOT NULL,
    route_id INT NOT NULL,
    travel_date DATE NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10,2) NOT NULL,
    payment_status ENUM('PAID','PENDING','REFUNDED') DEFAULT 'PENDING',
    booking_status ENUM('CONFIRMED','CANCELLED','COMPLETED') DEFAULT 'CONFIRMED',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    INDEX idx_bookings_user (user_id),
    INDEX idx_bookings_date (travel_date),
    INDEX idx_bookings_status (booking_status)
) ENGINE=InnoDB;

-- Booking_Seats Table
CREATE TABLE IF NOT EXISTS booking_seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_number VARCHAR(5) NOT NULL,
    passenger_name VARCHAR(100) NOT NULL,
    passenger_age INT DEFAULT NULL,
    passenger_gender ENUM('Male','Female','Other') DEFAULT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Reviews Table
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    bus_id INT NOT NULL,
    booking_id INT DEFAULT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_approved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
) ENGINE=InnoDB;

-- =========================================
-- Default Admin Account (password: admin123)
-- =========================================
INSERT INTO admins (full_name, email, password, role) VALUES
('Admin', 'admin@swiftride.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'SUPER_ADMIN');

-- =========================================
-- Sample Routes
-- =========================================
INSERT INTO routes (origin, destination, distance_km, estimated_duration, is_popular, badge, base_price) VALUES
('Mumbai', 'Pune', 150.00, '3h 30m', TRUE, 'FASTEST', 499.00),
('Bangalore', 'Chennai', 350.00, '6h 00m', TRUE, 'POPULAR', 850.00),
('Delhi', 'Jaipur', 280.00, '5h 30m', TRUE, 'LATEST', 399.00),
('Hyderabad', 'Vijayawada', 275.00, '4h 45m', TRUE, 'FREQUENT', 600.00),
('Mumbai', 'Goa', 590.00, '10h 15m', TRUE, 'POPULAR', 1200.00),
('Kolkata', 'Siliguri', 560.00, '9h 30m', FALSE, NULL, 950.00);

-- =========================================
-- Sample Buses
-- =========================================
INSERT INTO buses (bus_name, bus_type, bus_number, total_seats, route_id, departure_time, arrival_time, ticket_price, amenities, rating, total_ratings, operator_name) VALUES
('SwiftRide Express', 'AC_SLEEPER', 'MH-01-AB-1234', 40, 1, '22:30:00', '02:00:00', 599.00, 'WIFI,CHARGING,TRACKING', 4.5, 1240, 'SwiftRide Travels'),
('BoltBus Economy', 'NON_AC_SEATER', 'MH-02-CD-5678', 40, 1, '06:15:00', '09:45:00', 350.00, 'TRACKING', 4.2, 856, 'BoltBus Corp'),
('Royal Cruiser', 'AC_SLEEPER', 'KA-01-EF-9012', 40, 2, '23:45:00', '05:45:00', 950.00, 'WIFI,CHARGING,TRACKING,BLANKET', 4.8, 2100, 'Royal Coach Lines'),
('Metro Liner', 'AC_SEATER', 'DL-01-GH-3456', 40, 3, '07:00:00', '12:30:00', 450.00, 'WIFI,CHARGING', 4.3, 540, 'Metro Transport'),
('Coastal Star', 'AC_SLEEPER', 'MH-03-IJ-7890', 40, 5, '18:00:00', '04:15:00', 1350.00, 'WIFI,CHARGING,TRACKING,BLANKET,SNACKS', 4.7, 1890, 'Coastal Lines');
