# Hướng dẫn cấu hình MySQL Database

## 1. Cài đặt MySQL
Đảm bảo MySQL đã được cài đặt trên máy:
- **macOS**: `brew install mysql`
- **Windows**: Tải từ https://dev.mysql.com/downloads/mysql/
- **Linux**: `sudo apt-get install mysql-server`

## 2. Khởi động MySQL Server
```bash
# macOS
brew services start mysql

# Linux
sudo service mysql start

# Windows
# MySQL sẽ tự động khởi động như service
```

## 3. Tạo Database
Chạy file schema.sql để tạo database và các bảng:

```bash
mysql -u root -p < database/schema.sql
```

Hoặc đăng nhập vào MySQL và chạy:
```bash
mysql -u root -p
source database/schema.sql
```

## 4. Cấu hình kết nối
Cập nhật thông tin kết nối trong file `DatabaseConfig.java`:
- **DB_URL**: jdbc:mysql://localhost:3306/hotel_management
- **DB_USER**: root (hoặc username của bạn)
- **DB_PASSWORD**: password của bạn

## 5. Cấu trúc Database

### Bảng `rooms` (Phòng)
- id, room_number, room_type, price_per_night, status, capacity, description

### Bảng `customers` (Khách hàng)
- id, full_name, email, phone, id_card, address, nationality

### Bảng `bookings` (Đặt phòng)
- id, customer_id, room_id, check_in_date, check_out_date, number_of_guests, total_price, status, special_requests

### Bảng `users` (Người dùng)
- id, username, password, email, full_name, role

## 6. Dữ liệu mẫu
Database đã được tạo với dữ liệu mẫu:
- 7 phòng (các loại: Single, Double, Suite, Deluxe)
- 3 khách hàng
- 2 đặt phòng
- 1 user admin (username: admin, password: admin123)
