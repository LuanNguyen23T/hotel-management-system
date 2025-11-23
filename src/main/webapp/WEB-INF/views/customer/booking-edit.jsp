<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Booking - Hotel Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h1 {
            font-size: 1.5rem;
        }
        .nav-links {
            display: flex;
            gap: 1rem;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
        }
        .card-header h2 {
            font-size: 1.5rem;
        }
        .card-body {
            padding: 2rem;
        }
        .room-info {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }
        .room-info h3 {
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem;
            background: white;
            border-radius: 5px;
        }
        .info-label {
            color: #666;
        }
        .info-value {
            font-weight: 600;
            color: #2c3e50;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 600;
        }
        .form-group input {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 1rem;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
        }
        .alert-error {
            background: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border-left: 4px solid #17a2b8;
        }
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }
        .btn {
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
        .price-preview {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
        }
        .total-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
            border-top: 2px solid #e0e0e0;
            padding-top: 1rem;
            margin-top: 1rem;
        }
    </style>
    <script>
        function calculateTotal() {
            const checkIn = document.getElementById('checkInDate').value;
            const checkOut = document.getElementById('checkOutDate').value;
            const pricePerNight = ${booking.room.pricePerNight};
            
            if (checkIn && checkOut) {
                const date1 = new Date(checkIn);
                const date2 = new Date(checkOut);
                const days = Math.ceil((date2 - date1) / (1000 * 60 * 60 * 24));
                
                if (days > 0) {
                    const total = days * pricePerNight;
                    document.getElementById('numDays').textContent = days;
                    document.getElementById('totalPrice').textContent = total.toLocaleString('vi-VN');
                    document.getElementById('pricePreview').style.display = 'block';
                } else {
                    document.getElementById('pricePreview').style.display = 'none';
                }
            }
        }
        
        window.onload = function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('checkInDate').setAttribute('min', today);
            document.getElementById('checkOutDate').setAttribute('min', today);
            calculateTotal();
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h1>🏨 Hotel Management</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=available">Đặt phòng</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=my-bookings">Booking của tôi</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2>✏️ Chỉnh sửa Booking #${booking.id}</h2>
            </div>
            <div class="card-body">
                <div class="alert alert-info">
                    ℹ️ Bạn chỉ có thể thay đổi ngày nhận/trả phòng. Nếu muốn thay đổi phòng, vui lòng hủy booking này và đặt phòng mới.
                </div>

                <div class="room-info">
                    <h3>Thông tin phòng</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Số phòng:</span>
                            <span class="info-value">${booking.room.roomNumber}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Loại phòng:</span>
                            <span class="info-value">${booking.room.roomType}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Sức chứa:</span>
                            <span class="info-value">${booking.room.capacity} người</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Giá/đêm:</span>
                            <span class="info-value" style="color: #667eea;">
                                <fmt:formatNumber value="${booking.room.pricePerNight}" pattern="#,###"/> VNĐ
                            </span>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/customer/booking">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="bookingId" value="${booking.id}">

                    <div class="form-group">
                        <label for="checkInDate">Ngày nhận phòng *</label>
                        <input type="date" id="checkInDate" name="checkInDate" 
                               value="<fmt:formatDate value='${booking.checkInDate}' pattern='yyyy-MM-dd'/>" 
                               required onchange="calculateTotal()">
                    </div>

                    <div class="form-group">
                        <label for="checkOutDate">Ngày trả phòng *</label>
                        <input type="date" id="checkOutDate" name="checkOutDate" 
                               value="<fmt:formatDate value='${booking.checkOutDate}' pattern='yyyy-MM-dd'/>" 
                               required onchange="calculateTotal()">
                    </div>

                    <div id="pricePreview" class="price-preview">
                        <h4 style="margin-bottom: 1rem; color: #2c3e50;">Chi tiết giá mới</h4>
                        <div class="price-row">
                            <span>Số đêm:</span>
                            <span id="numDays">0</span>
                        </div>
                        <div class="price-row">
                            <span>Giá mỗi đêm:</span>
                            <span><fmt:formatNumber value="${booking.room.pricePerNight}" pattern="#,###"/> VNĐ</span>
                        </div>
                        <div class="price-row total-price">
                            <span>Tổng cộng:</span>
                            <span id="totalPrice">0</span> VNĐ
                        </div>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/customer/booking?action=view&id=${booking.id}" class="btn btn-secondary">
                            Hủy
                        </a>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
