<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking của tôi - Hotel Management System</title>
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
        .nav-links a:hover, .nav-links a.active {
            background: rgba(255,255,255,0.2);
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h2 {
            color: #2c3e50;
        }
        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        .alert-error {
            background: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }
        .bookings-grid {
            display: grid;
            gap: 1.5rem;
        }
        .booking-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .booking-sidebar {
            width: 150px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .room-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .room-type {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        .booking-content {
            flex: 1;
            padding: 1.5rem;
        }
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }
        .booking-id {
            font-size: 0.9rem;
            color: #666;
        }
        .status-badge {
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }
        .status-checked-in {
            background: #cce5ff;
            color: #004085;
        }
        .status-checked-out {
            background: #e2e3e5;
            color: #383d41;
        }
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        .booking-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0.3rem;
        }
        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
        }
        .booking-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        .btn {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
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
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .empty-state h3 {
            color: #666;
            margin-bottom: 1rem;
        }
        .btn-book-now {
            display: inline-block;
            margin-top: 1rem;
            padding: 0.8rem 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
        }
        .btn-book-now:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
    </style>
    <script>
        function confirmCancel(bookingId) {
            if (confirm('Bạn có chắc chắn muốn hủy đặt phòng này?')) {
                window.location.href = '${pageContext.request.contextPath}/customer/booking?action=cancel&id=' + bookingId;
            }
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h1>🏨 Hotel Management</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=available">Đặt phòng</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=my-bookings" class="active">Booking của tôi</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        <div class="header">
            <h2>📋 Booking của tôi</h2>
        </div>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                ${sessionScope.success}
                <c:remove var="success" scope="session" />
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">
                ${sessionScope.error}
                <c:remove var="error" scope="session" />
            </div>
        </c:if>

        <c:if test="${not empty bookings}">
            <div class="bookings-grid">
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card">
                        <div class="booking-sidebar">
                            <div class="room-number">${booking.room.roomNumber}</div>
                            <div class="room-type">${booking.room.roomType}</div>
                        </div>
                        <div class="booking-content">
                            <div class="booking-header">
                                <span class="booking-id">Booking #${booking.id}</span>
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

                            <div class="booking-info">
                                <div class="info-item">
                                    <span class="info-label">Nhận phòng</span>
                                    <span class="info-value">
                                        <fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Trả phòng</span>
                                    <span class="info-value">
                                        <fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Tổng tiền</span>
                                    <span class="info-value" style="color: #667eea;">
                                        <fmt:formatNumber value="${booking.totalPrice}" pattern="#,###"/> VNĐ
                                    </span>
                                </div>
                            </div>

                            <div class="booking-actions">
                                <a href="${pageContext.request.contextPath}/customer/booking?action=view&id=${booking.id}" class="btn btn-primary">
                                    Xem chi tiết
                                </a>
                                <c:if test="${booking.status == 'Confirmed'}">
                                    <a href="${pageContext.request.contextPath}/customer/booking?action=edit&id=${booking.id}" class="btn btn-warning">
                                        Chỉnh sửa
                                    </a>
                                    <button onclick="confirmCancel(${booking.id})" class="btn btn-danger">
                                        Hủy booking
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty bookings}">
            <div class="empty-state">
                <h3>📭 Bạn chưa có booking nào</h3>
                <p style="color: #999;">Hãy đặt phòng để trải nghiệm dịch vụ của chúng tôi</p>
                <a href="${pageContext.request.contextPath}/customer/booking?action=available" class="btn-book-now">
                    Đặt phòng ngay
                </a>
            </div>
        </c:if>
    </div>
</body>
</html>
