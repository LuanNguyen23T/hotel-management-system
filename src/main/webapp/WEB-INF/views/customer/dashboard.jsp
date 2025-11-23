<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Khách hàng</title>
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
            align-items: center;
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
        .nav-links a.active {
            background: rgba(255,255,255,0.3);
        }
        .nav-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn-logout {
            padding: 0.5rem 1rem;
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }
        .btn-logout:hover {
            background: rgba(255,255,255,0.3);
        }
        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        .welcome-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .welcome-card h2 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .stat-card .icon {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        .stat-card .number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
            margin: 0.5rem 0;
        }
        .stat-card .label {
            color: #7f8c8d;
            font-size: 1rem;
        }
        .section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        .section h3 {
            color: #2c3e50;
            font-size: 1.5rem;
        }
        .btn-primary {
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.2s;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
        }
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .room-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            transition: transform 0.2s;
        }
        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .room-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }
        .room-type {
            color: #2c3e50;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }
        .room-price {
            font-size: 1.3rem;
            font-weight: bold;
            color: #27ae60;
            margin: 1rem 0;
        }
        .room-info {
            color: #7f8c8d;
            margin: 0.5rem 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        th {
            background: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
        }
        .status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-confirmed {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-checkedin {
            background: #d4edda;
            color: #155724;
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🏨 Hotel Management</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=available">Đặt phòng</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=my-bookings">Booking của tôi</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn-logout">Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-card">
            <h2>Xin chào, ${fullName}!</h2>
            <p>Chào mừng bạn đến với hệ thống đặt phòng khách sạn</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="icon">🏨</div>
                <div class="number">${availableRooms}</div>
                <div class="label">Phòng còn trống</div>
                <a href="${pageContext.request.contextPath}/customer/booking?action=available" 
                   style="display: block; margin-top: 1rem; color: #667eea; text-decoration: none; font-weight: 600;">
                    Xem phòng →
                </a>
            </div>
            <div class="stat-card">
                <div class="icon">📅</div>
                <div class="number">${myBookings}</div>
                <div class="label">Đặt phòng của tôi</div>
                <a href="${pageContext.request.contextPath}/customer/booking?action=my-bookings" 
                   style="display: block; margin-top: 1rem; color: #667eea; text-decoration: none; font-weight: 600;">
                    Xem chi tiết →
                </a>
            </div>
        </div>

        <div class="section">
            <div class="section-header">
                <h3>🏨 Phòng có sẵn</h3>
            </div>
            
            <c:choose>
                <c:when test="${not empty availableRoomsList}">
                    <div class="rooms-grid">
                        <c:forEach var="room" items="${availableRoomsList}">
                            <div class="room-card">
                                <div class="room-number">Phòng ${room.roomNumber}</div>
                                <div class="room-type">${room.roomType}</div>
                                <div class="room-price">
                                    <fmt:formatNumber value="${room.pricePerNight}" type="number" groupingUsed="true"/> đ/đêm
                                </div>
                                <div class="room-info">
                                    👥 Sức chứa: ${room.capacity} người
                                </div>
                                <div class="room-info" style="margin-top: 0.5rem;">
                                    ${room.description}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>Không có phòng trống</h3>
                        <p>Hiện tại không có phòng nào còn trống</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="section">
            <div class="section-header">
                <h3>📋 Lịch sử đặt phòng</h3>
            </div>
            
            <c:choose>
                <c:when test="${not empty recentBookings}">
                    <table>
                        <thead>
                            <tr>
                                <th>Mã đặt phòng</th>
                                <th>Ngày nhận phòng</th>
                                <th>Ngày trả phòng</th>
                                <th>Số khách</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${recentBookings}">
                                <tr>
                                    <td>#${booking.id}</td>
                                    <td><fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/></td>
                                    <td>${booking.numberOfGuests} người</td>
                                    <td><fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/> đ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.status == 'Pending'}">
                                                <span class="status status-pending">Chờ xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Confirmed'}">
                                                <span class="status status-confirmed">Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'CheckedIn'}">
                                                <span class="status status-checkedin">Đang ở</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status">${booking.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>Chưa có đặt phòng nào</h3>
                        <p>Bạn chưa đặt phòng nào. Hãy chọn một phòng trống ở trên để đặt!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
