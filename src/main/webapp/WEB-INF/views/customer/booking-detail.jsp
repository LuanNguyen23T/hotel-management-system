<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Booking - Hotel Management System</title>
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
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 1.5rem;
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .card-header h2 {
            font-size: 1.5rem;
        }
        .status-badge {
            padding: 0.5rem 1.2rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            background: white;
        }
        .status-confirmed {
            color: #155724;
        }
        .status-checked-in {
            color: #004085;
        }
        .status-checked-out {
            color: #383d41;
        }
        .status-cancelled {
            color: #721c24;
        }
        .card-body {
            padding: 2rem;
        }
        .info-section {
            margin-bottom: 2rem;
        }
        .section-title {
            font-size: 1.2rem;
            color: #2c3e50;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #f0f0f0;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
        }
        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
        }
        .price-summary {
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
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
            border-top: 2px solid #e0e0e0;
            padding-top: 1rem;
            margin-top: 1rem;
        }
        .actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        .btn {
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .btn-warning {
            background: #ffc107;
            color: #000;
        }
        .btn-warning:hover {
            background: #e0a800;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background: #c82333;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
    </style>
    <script>
        function confirmCancel() {
            return confirm('Bạn có chắc chắn muốn hủy đặt phòng này?');
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
                <h2>📄 Chi tiết Booking #${booking.id}</h2>
                <c:choose>
                    <c:when test="${booking.status == 'Confirmed'}">
                        <span class="status-badge status-confirmed">Đã xác nhận</span>
                    </c:when>
                    <c:when test="${booking.status == 'CheckedIn'}">
                        <span class="status-badge status-checked-in">Đang ở</span>
                    </c:when>
                    <c:when test="${booking.status == 'CheckedOut'}">
                        <span class="status-badge status-checked-out">Đã trả phòng</span>
                    </c:when>
                    <c:when test="${booking.status == 'Cancelled'}">
                        <span class="status-badge status-cancelled">Đã hủy</span>
                    </c:when>
                </c:choose>
            </div>
            <div class="card-body">
                <div class="info-section">
                    <h3 class="section-title">Thông tin phòng</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Số phòng</span>
                            <span class="info-value">${booking.room.roomNumber}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Loại phòng</span>
                            <span class="info-value">${booking.room.roomType}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Sức chứa</span>
                            <span class="info-value">${booking.room.capacity} người</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Giá mỗi đêm</span>
                            <span class="info-value" style="color: #667eea;">
                                <fmt:formatNumber value="${booking.room.pricePerNight}" pattern="#,###"/> VNĐ
                            </span>
                        </div>
                    </div>
                </div>

                <div class="info-section">
                    <h3 class="section-title">Thông tin đặt phòng</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Ngày nhận phòng</span>
                            <span class="info-value">
                                <fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Ngày trả phòng</span>
                            <span class="info-value">
                                <fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>
                        <c:if test="${not empty booking.bookingDate}">
                            <div class="info-item">
                                <span class="info-label">Ngày đặt</span>
                                <span class="info-value">
                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                        </c:if>
                    </div>

                    <div class="price-summary">
                        <h4 style="margin-bottom: 1rem; color: #2c3e50;">Chi tiết thanh toán</h4>
                        <div class="price-row">
                            <span>Giá phòng/đêm:</span>
                            <span><fmt:formatNumber value="${booking.room.pricePerNight}" pattern="#,###"/> VNĐ</span>
                        </div>
                        <div class="price-row total-price">
                            <span>Tổng cộng:</span>
                            <span><fmt:formatNumber value="${booking.totalPrice}" pattern="#,###"/> VNĐ</span>
                        </div>
                    </div>
                </div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/customer/booking?action=my-bookings" class="btn btn-secondary">
                        Quay lại
                    </a>
                    <c:if test="${booking.status == 'Confirmed'}">
                        <a href="${pageContext.request.contextPath}/customer/booking?action=edit&id=${booking.id}" class="btn btn-warning">
                            Chỉnh sửa
                        </a>
                        <a href="${pageContext.request.contextPath}/customer/booking?action=cancel&id=${booking.id}" 
                           onclick="return confirmCancel()" class="btn btn-danger">
                            Hủy booking
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
