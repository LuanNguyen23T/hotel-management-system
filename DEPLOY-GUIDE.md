# 🏨 Hotel Management System - Hướng dẫn Deploy lên Tomcat

## 📋 Yêu cầu hệ thống

- Java JDK 8 hoặc cao hơn
- Maven
- MySQL
- Tomcat 9 (đã cài qua Homebrew)

## 🚀 Hướng dẫn Deploy

### Bước 1: Chuẩn bị Database

1. Khởi động MySQL (nếu dùng Homebrew):
```bash
brew services start mysql
```

2. Tạo database:
```bash
cd database
./setup.sh
```

Hoặc import thủ công:
```bash
mysql -u root -p < database/schema.sql
```

### Bước 2: Cấu hình Database

Mở file `src/main/java/com/example/util/DatabaseConnection.java` và điều chỉnh:
- `URL`: jdbc:mysql://localhost:3306/hotel_management
- `USERNAME`: root (hoặc user MySQL của bạn)
- `PASSWORD`: (password MySQL của bạn)

### Bước 3: Deploy lên Tomcat

**Cách 1: Sử dụng script tự động (Khuyến nghị)**

```bash
./deploy-tomcat.sh
```

Script này sẽ:
1. Build project bằng `mvn clean package`
2. Copy file `myapp.war` vào thư mục webapps của Tomcat
3. Hiển thị thông tin truy cập

**Cách 2: Thực hiện thủ công**

```bash
# Bước 1: Build project
mvn clean package

# Bước 2: Copy WAR file vào Tomcat
sudo cp target/myapp.war /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/webapps/
```

### Bước 4: Khởi động Tomcat

```bash
# Khởi động Tomcat
brew services start tomcat@9

# Kiểm tra trạng thái
brew services list | grep tomcat

# Xem logs
tail -f /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/logs/catalina.out
```

### Bước 5: Truy cập ứng dụng

Mở trình duyệt và truy cập:
```
http://localhost:8080/myapp
```

## 🛠️ Các lệnh hữu ích

### Quản lý Tomcat

```bash
# Khởi động Tomcat
brew services start tomcat@9

# Dừng Tomcat
brew services stop tomcat@9

# Khởi động lại Tomcat
brew services restart tomcat@9

# Kiểm tra trạng thái
brew services list | grep tomcat
```

### Xem logs

```bash
# Xem logs realtime
tail -f /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/logs/catalina.out

# Xem logs lỗi
tail -f /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/logs/localhost.log
```

### Build lại project

```bash
# Build không chạy test
mvn clean package -DskipTests

# Build và chạy test
mvn clean package

# Chỉ build không clean
mvn package
```

### Undeploy ứng dụng

```bash
# Xóa file WAR và thư mục đã deploy
sudo rm -rf /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/webapps/myapp*
```

## 🐛 Xử lý lỗi thường gặp

### Lỗi kết nối database

- Kiểm tra MySQL đã chạy chưa: `brew services list`
- Kiểm tra thông tin kết nối trong `DatabaseConnection.java`
- Kiểm tra database đã được tạo: `mysql -u root -p -e "SHOW DATABASES;"`

### Port 8080 đã được sử dụng

```bash
# Tìm process đang dùng port 8080
lsof -i :8080

# Kill process nếu cần
kill -9 <PID>
```

### Tomcat không tự động deploy

- Xóa thư mục work và temp của Tomcat:
```bash
sudo rm -rf /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/work/*
sudo rm -rf /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/temp/*
```

### Permission denied khi copy WAR

```bash
# Sử dụng sudo
sudo cp target/myapp.war /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/webapps/
```

## 📁 Cấu trúc file WAR

File `myapp.war` được tạo trong thư mục `target/` sau khi build, bao gồm:
- Compiled Java classes
- JSP files
- WEB-INF/web.xml
- Dependencies (JAR files)
- Static resources

## 🔧 Cấu hình nâng cao

### Thay đổi context path

Để thay đổi URL từ `/myapp` sang tên khác, đổi tên file WAR:
```bash
mv target/myapp.war target/hotel.war
sudo cp target/hotel.war /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/webapps/
```

Truy cập tại: `http://localhost:8080/hotel`

### Thay đổi port Tomcat

Chỉnh sửa file: `/opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/conf/server.xml`

Tìm dòng:
```xml
<Connector port="8080" protocol="HTTP/1.1"
```

Đổi `8080` thành port mong muốn.

## 📞 Hỗ trợ

Nếu gặp vấn đề, kiểm tra:
1. Logs của Tomcat
2. Logs của ứng dụng
3. Console output khi build Maven
