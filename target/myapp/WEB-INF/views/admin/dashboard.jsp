<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Hotel Management System</title>
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
        }
        .navbar h1 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        .nav-links {
            display: flex;
            gap: 1rem;
            list-style: none;
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
        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .page-header h2 {
            color: #2c3e50;
            font-size: 1.8rem;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .stat-card h3 {
            color: #7f8c8d;
            font-size: 0.9rem;
            text-transform: uppercase;
            margin-bottom: 0.8rem;
            font-weight: 600;
        }
        .stat-card .value {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2c3e50;
        }
        .stat-card.blue {
            border-left: 4px solid #667eea;
        }
        .stat-card.blue .value {
            color: #667eea;
        }
        .stat-card.green {
            border-left: 4px solid #27ae60;
        }
        .stat-card.green .value {
            color: #27ae60;
        }
        .stat-card.orange {
            border-left: 4px solid #f39c12;
        }
        .stat-card.orange .value {
            color: #f39c12;
        }
        .stat-card.red {
            border-left: 4px solid #e74c3c;
        }
        .stat-card.red .value {
            color: #e74c3c;
        }
        .section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .section h2 {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            font-size: 1.4rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
        }
        table td {
            padding: 1rem;
            border-bottom: 1px solid #ecf0f1;
        }
        table tr:hover {
            background: #f8f9fa;
        }
        .badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }
        .badge.pending {
            background: #fff3cd;
            color: #856404;
        }
        .badge.confirmed {
            background: #d1ecf1;
            color: #0c5460;
        }
        .badge.checkedin {
            background: #d4edda;
            color: #155724;
        }
        .badge.checkedout {
            background: #e2e3e5;
            color: #383d41;
        }
        .badge.cancelled {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🏨 Hệ thống Quản lý Khách sạn</h1>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/rooms?action=list">Phòng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/customers?action=list">Khách hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings?action=list">Đặt phòng</a></li>
            <li style="margin-left: auto;"><a href="${pageContext.request.contextPath}/auth?action=logout" style="background: rgba(255,255,255,0.2);">Đăng xuất</a></li>
        </ul>
    </div>
    
    <div class="container">
        <div class="page-header">
            <h2>📊 Dashboard - Tổng quan hệ thống</h2>
        </div>
        
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
