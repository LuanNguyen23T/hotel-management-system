<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management - Hotel Management System</title>
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
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .room-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .room-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem;
            text-align: center;
        }
        .room-number {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .room-type {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        .room-body {
            padding: 1.5rem;
        }
        .room-info {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
            margin-bottom: 1rem;
        }
        .room-info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .room-info-label {
            font-weight: 500;
            color: #666;
        }
        .room-info-value {
            font-weight: 600;
            color: #2c3e50;
        }
        .room-status {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .status-available {
            background: #d4edda;
            color: #155724;
        }
        .status-occupied {
            background: #fff3cd;
            color: #856404;
        }
        .status-maintenance {
            background: #f8d7da;
            color: #721c24;
        }
        .room-actions {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
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
            <li><a href="${pageContext.request.contextPath}/rooms" class="active">Rooms</a></li>
            <li><a href="${pageContext.request.contextPath}/customers">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/bookings">Bookings</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>Room Management</h2>
            <a href="${pageContext.request.contextPath}/rooms?action=add" class="btn btn-primary">+ Add New Room</a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="filters">
            <form method="get" action="${pageContext.request.contextPath}/rooms">
                <input type="hidden" name="action" value="list">
                <div class="filter-group">
                    <label>Filter by Status:</label>
                    <select name="status" onchange="this.form.submit()">
                        <option value="">All Rooms</option>
                        <option value="Available" ${param.status == 'Available' ? 'selected' : ''}>Available</option>
                        <option value="Occupied" ${param.status == 'Occupied' ? 'selected' : ''}>Occupied</option>
                        <option value="Maintenance" ${param.status == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
                    </select>
                    
                    <label>Filter by Type:</label>
                    <select name="type" onchange="this.form.submit()">
                        <option value="">All Types</option>
                        <option value="Single" ${param.type == 'Single' ? 'selected' : ''}>Single</option>
                        <option value="Double" ${param.type == 'Double' ? 'selected' : ''}>Double</option>
                        <option value="Suite" ${param.type == 'Suite' ? 'selected' : ''}>Suite</option>
                        <option value="Deluxe" ${param.type == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                    </select>
                </div>
            </form>
        </div>

        <div class="rooms-grid">
            <c:forEach var="room" items="${rooms}">
                <div class="room-card">
                    <div class="room-header">
                        <div class="room-number">Room ${room.roomNumber}</div>
                        <div class="room-type">${room.roomType}</div>
                    </div>
                    <div class="room-body">
                        <div class="room-info">
                            <div class="room-info-item">
                                <span class="room-info-label">Price/Night:</span>
                                <span class="room-info-value">
                                                                    <td>
                                    <fmt:formatNumber value="${room.pricePerNight}" pattern="#,##0"/>đ
                                </span>
                            </div>
                            <div class="room-info-item">
                                <span class="room-info-label">Capacity:</span>
                                <span class="room-info-value">${room.capacity} guests</span>
                            </div>
                            <div class="room-info-item">
                                <span class="room-info-label">Status:</span>
                                <span class="room-status status-${room.status.toLowerCase()}">${room.status}</span>
                            </div>
                        </div>
                        <c:if test="${not empty room.description}">
                            <p style="color: #666; font-size: 0.9rem; margin-top: 0.5rem;">${room.description}</p>
                        </c:if>
                        <div class="room-actions">
                            <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}" 
                               class="btn btn-warning btn-small">Edit</a>
                            <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}" 
                               class="btn btn-danger btn-small"
                               onclick="return confirm('Are you sure you want to delete room ${room.roomNumber}?')">Delete</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty rooms}">
            <div style="text-align: center; padding: 3rem; background: white; border-radius: 10px;">
                <h3 style="color: #666;">No rooms found</h3>
                <p style="color: #999; margin-top: 1rem;">Add your first room to get started</p>
            </div>
        </c:if>
    </div>
</body>
</html>
