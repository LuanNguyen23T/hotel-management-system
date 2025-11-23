-- Create database
CREATE DATABASE IF NOT EXISTS hotel_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE hotel_management;

-- Drop tables if exist
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;

-- Create rooms table
CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Available',
    capacity INT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_room_type (room_type),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create customers table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    id_card VARCHAR(50) UNIQUE,
    address TEXT,
    nationality VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_id_card (id_card)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create bookings table
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    number_of_guests INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    special_requests TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    INDEX idx_customer_id (customer_id),
    INDEX idx_room_id (room_id),
    INDEX idx_status (status),
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_check_out_date (check_out_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample rooms
INSERT INTO rooms (room_number, room_type, price_per_night, status, capacity, description) VALUES
('101', 'Single', 500000, 'Available', 1, 'Phòng đơn tiêu chuẩn với giường đơn, phù hợp cho 1 người'),
('102', 'Single', 500000, 'Available', 1, 'Phòng đơn với view thành phố'),
('201', 'Double', 800000, 'Available', 2, 'Phòng đôi với 2 giường đơn hoặc 1 giường đôi'),
('202', 'Double', 850000, 'Occupied', 2, 'Phòng đôi cao cấp với ban công'),
('301', 'Suite', 1500000, 'Available', 4, 'Phòng suite rộng rãi với phòng khách riêng'),
('302', 'Suite', 1600000, 'Available', 4, 'Phòng suite sang trọng với view biển'),
('401', 'Deluxe', 2000000, 'Maintenance', 2, 'Phòng deluxe cao cấp với đầy đủ tiện nghi');

-- Insert sample customers (with username and password for login)
INSERT INTO customers (username, password, full_name, email, phone, id_card, address, nationality) VALUES
('customer1', 'customer123', 'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0901234567', '123456789012', '123 Đường ABC, Quận 1, TP.HCM', 'Việt Nam'),
('customer2', 'customer123', 'Trần Thị Bình', 'tranthibinh@gmail.com', '0912345678', '234567890123', '456 Đường XYZ, Quận 3, TP.HCM', 'Việt Nam'),
('customer3', 'customer123', 'Lê Minh Cường', 'leminhcuong@gmail.com', '0923456789', '345678901234', '789 Đường DEF, Quận 5, TP.HCM', 'Việt Nam');

-- Insert sample bookings
INSERT INTO bookings (customer_id, room_id, check_in_date, check_out_date, number_of_guests, total_price, status, special_requests) VALUES
(1, 4, '2025-11-20', '2025-11-22', 2, 1700000, 'Confirmed', 'Yêu cầu phòng tầng cao'),
(2, 5, '2025-11-25', '2025-11-28', 3, 4500000, 'Pending', 'Cần thêm giường phụ cho trẻ em');

-- Insert sample users with different roles (password: admin123, manager123, staff123)
INSERT INTO users (username, password, email, full_name, role) VALUES
('admin', 'admin123', 'admin@hotel.com', 'Administrator', 'Admin'),
('manager', 'manager123', 'manager@hotel.com', 'Hotel Manager', 'Manager'),
('staff', 'staff123', 'staff@hotel.com', 'Staff Member', 'Staff');
