<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Hotel Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; }
        .header { background: #2c3e50; color: white; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .header h1 { display: inline-block; }
        .nav { float: right; margin-top: 10px; }
        .nav a { color: white; text-decoration: none; padding: 10px 20px; margin-left: 10px; background: #34495e; border-radius: 5px; transition: 0.3s; }
        .nav a:hover { background: #1abc9c; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; transition: 0.3s; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }
        .stat-card h3 { color: #7f8c8d; font-size: 14px; text-transform: uppercase; margin-bottom: 10px; }
        .stat-card .value { font-size: 36px; font-weight: bold; color: #2c3e50; }
        .stat-card.blue .value { color: #3498db; }
        .stat-card.green .value { color: #2ecc71; }
        .stat-card.orange .value { color: #e67e22; }
        .stat-card.red .value { color: #e74c3c; }
        .section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .section h2 { color: #2c3e50; margin-bottom: 20px; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; }
        table th { background: #34495e; color: white; padding: 12px; text-align: left; }
        table td { padding: 12px; border-bottom: 1px solid #ecf0f1; }
        table tr:hover { background: #f8f9fa; }
        .badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .badge.pending { background: #f39c12; color: white; }
        .badge.confirmed { background: #3498db; color: white; }
        .badge.checkedin { background: #2ecc71; color: white; }
        .badge.checkedout { background: #95a5a6; color: white; }
        .badge.cancelled { background: #e74c3c; color: white; }
    </style>
</head>
<body>
        <div class="header">
        <h1>🏨 Hotel Management System</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/rooms?action=list">Phòng</a>
            <a href="${pageContext.request.contextPath}/customers?action=list">Khách hàng</a>
            <a href="${pageContext.request.contextPath}/bookings?action=list">Đặt phòng</a>
        </div>
    </div>
    
    <div class="container">
        <div class="stats-grid">
            <div class="stat-card blue">
                <h3>Tổng số phòng</h3>
                <div class="value">${totalRooms}</div>
            </div>
            <div class="stat-card green">
                <h3>Phòng trống</h3>
                <div class="value">${availableRooms}</div>
            </div>
            <div class="stat-card orange">
                <h3>Phòng đã đặt</h3>
                <div class="value">${occupiedRooms}</div>
            </div>
            <div class="stat-card red">
                <h3>Tổng khách hàng</h3>
                <div class="value">${totalCustomers}</div>
            </div>
            <div class="stat-card blue">
                <h3>Đơn chờ xác nhận</h3>
                <div class="value">${pendingBookings}</div>
            </div>
            <div class="stat-card green">
                <h3>Đơn đã xác nhận</h3>
                <div class="value">${confirmedBookings}</div>
            </div>
            <div class="stat-card orange">
                <h3>Doanh thu</h3>
                <div class="value"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>đ</div>
            </div>
        </div>
        
        <div class="section">
            <h2>📋 Đặt phòng gần đây</h2>
            <c:choose>
                <c:when test="${empty recentBookings}">
                    <p style="text-align: center; color: #7f8c8d; padding: 20px;">Chưa có đơn đặt phòng nào</p>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Khách hàng</th>
                                <th>Phòng</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Số khách</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentBookings}" var="booking">
                                <tr>
                                    <td>${booking.id}</td>
                                    <td>${booking.customerName}</td>
                                    <td>${booking.roomNumber}</td>
                                    <td><fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/></td>
                                    <td>${booking.numberOfGuests}</td>
                                    <td><fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0"/>đ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.status == 'Pending'}">
                                                <span class="badge pending">Chờ xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Confirmed'}">
                                                <span class="badge confirmed">Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'CheckedIn'}">
                                                <span class="badge checkedin">Đã nhận phòng</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'CheckedOut'}">
                                                <span class="badge checkedout">Đã trả phòng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge cancelled">Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
