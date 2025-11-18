<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - Hotel Management System</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .page-header h2 {
            color: #2c3e50;
        }
        .btn {
            padding: 0.7rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 0.95rem;
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
        .btn-success {
            background: #27ae60;
            color: white;
        }
        .btn-warning {
            background: #f39c12;
            color: white;
        }
        .btn-danger {
            background: #e74c3c;
            color: white;
        }
        .btn-small {
            padding: 0.4rem 0.8rem;
            font-size: 0.85rem;
            margin: 0 0.2rem;
        }
        .filters {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .filter-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: center;
        }
        .filter-group select {
            padding: 0.6rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.95rem;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            white-space: nowrap;
        }
        td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .status-badge {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-confirmed {
            background: #cce5ff;
            color: #004085;
        }
        .status-checkedin {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-checkedout {
            background: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>🏨 Hotel Management System</h1>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/rooms">Rooms</a></li>
            <li><a href="${pageContext.request.contextPath}/customers">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/bookings" class="active">Bookings</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>Booking Management</h2>
            <a href="${pageContext.request.contextPath}/bookings?action=add" class="btn btn-primary">+ New Booking</a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="filters">
            <form method="get" action="${pageContext.request.contextPath}/bookings">
                <input type="hidden" name="action" value="list">
                <div class="filter-group">
                    <label>Filter by Status:</label>
                    <select name="status" onchange="this.form.submit()">
                        <option value="">All Bookings</option>
                        <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Confirmed" ${param.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                        <option value="CheckedIn" ${param.status == 'CheckedIn' ? 'selected' : ''}>Checked In</option>
                        <option value="CheckedOut" ${param.status == 'CheckedOut' ? 'selected' : ''}>Checked Out</option>
                        <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Room</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Guests</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>${booking.id}</td>
                            <td><strong>${booking.customerName}</strong></td>
                            <td>Room ${booking.roomNumber}</td>
                            <td><fmt:formatDate value="${booking.checkInDate}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${booking.checkOutDate}" pattern="dd/MM/yyyy"/></td>
                            <td>${booking.numberOfGuests}</td>
                            <td><strong><fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0"/>đ</strong></td>
                            <td>
                                <span class="status-badge status-${booking.status.toLowerCase()}">
                                    ${booking.status}
                                </span>
                            </td>
                            <td>
                                <c:if test="${booking.status == 'Pending'}">
                                    <a href="${pageContext.request.contextPath}/bookings?action=updateStatus&id=${booking.id}&status=Confirmed" 
                                       class="btn btn-success btn-small">Confirm</a>
                                </c:if>
                                <c:if test="${booking.status == 'Confirmed'}">
                                    <a href="${pageContext.request.contextPath}/bookings?action=updateStatus&id=${booking.id}&status=CheckedIn" 
                                       class="btn btn-success btn-small">Check In</a>
                                </c:if>
                                <c:if test="${booking.status == 'CheckedIn'}">
                                    <a href="${pageContext.request.contextPath}/bookings?action=updateStatus&id=${booking.id}&status=CheckedOut" 
                                       class="btn btn-success btn-small">Check Out</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/bookings?action=edit&id=${booking.id}" 
                                   class="btn btn-warning btn-small">Edit</a>
                                <a href="${pageContext.request.contextPath}/bookings?action=delete&id=${booking.id}" 
                                   class="btn btn-danger btn-small"
                                   onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty bookings}">
            <div style="text-align: center; padding: 3rem; background: white; border-radius: 10px; margin-top: 2rem;">
                <h3 style="color: #666;">No bookings found</h3>
                <p style="color: #999; margin-top: 1rem;">Create your first booking to get started</p>
            </div>
        </c:if>
    </div>
</body>
</html>
