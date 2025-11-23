<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phòng có sẵn - Hotel Management System</title>
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
        }
        .header h2 {
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        .filter-form {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: end;
        }
        .form-group {
            flex: 1;
            min-width: 200px;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #555;
            font-weight: 500;
        }
        .form-group select,
        .form-group input {
            width: 100%;
            padding: 0.7rem;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 0.95rem;
        }
        .btn {
            padding: 0.7rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
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
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .room-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .room-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
        }
        .room-number {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .room-type {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        .room-body {
            padding: 1.5rem;
        }
        .room-info {
            margin-bottom: 1rem;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-label {
            color: #666;
            font-size: 0.9rem;
        }
        .info-value {
            color: #2c3e50;
            font-weight: 600;
        }
        .room-price {
            font-size: 1.5rem;
            color: #667eea;
            font-weight: 700;
            text-align: center;
            margin: 1rem 0;
        }
        .btn-book {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🏨 Hotel Management</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=available" style="background: rgba(255,255,255,0.2);">Đặt phòng</a>
            <a href="${pageContext.request.contextPath}/customer/booking?action=my-bookings">Booking của tôi</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
        </div>
    </div>

    <div class="container">
        <div class="header">
            <h2>🔍 Tìm phòng trống</h2>
            <form method="get" action="${pageContext.request.contextPath}/customer/booking" class="filter-form">
                <input type="hidden" name="action" value="available">
                
                <div class="form-group">
                    <label>Loại phòng</label>
                    <select name="roomType">
                        <option value="all">Tất cả</option>
                        <option value="Single" ${selectedType == 'Single' ? 'selected' : ''}>Single</option>
                        <option value="Double" ${selectedType == 'Double' ? 'selected' : ''}>Double</option>
                        <option value="Suite" ${selectedType == 'Suite' ? 'selected' : ''}>Suite</option>
                        <option value="Deluxe" ${selectedType == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Giá tối đa (VNĐ)</label>
                    <input type="number" name="maxPrice" value="${maxPrice}" placeholder="Nhập giá tối đa">
                </div>
                
                <button type="submit" class="btn btn-primary">Lọc</button>
            </form>
        </div>

        <c:if test="${not empty rooms}">
            <div class="rooms-grid">
                <c:forEach var="room" items="${rooms}">
                    <div class="room-card">
                        <div class="room-header">
                            <div class="room-number">Phòng ${room.roomNumber}</div>
                            <div class="room-type">${room.roomType}</div>
                        </div>
                        <div class="room-body">
                            <div class="room-info">
                                <div class="info-row">
                                    <span class="info-label">Sức chứa:</span>
                                    <span class="info-value">${room.capacity} người</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Trạng thái:</span>
                                    <span class="info-value" style="color: #27ae60;">${room.status}</span>
                                </div>
                            </div>
                            <c:if test="${not empty room.description}">
                                <p style="color: #666; font-size: 0.9rem; margin: 1rem 0;">${room.description}</p>
                            </c:if>
                            <div class="room-price">
                                <fmt:formatNumber value="${room.pricePerNight}" pattern="#,###"/> VNĐ/đêm
                            </div>
                            <a href="${pageContext.request.contextPath}/customer/booking?action=book&roomId=${room.id}">
                                <button class="btn-book">Đặt phòng ngay</button>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty rooms}">
            <div class="empty-state">
                <h3>😕 Không tìm thấy phòng phù hợp</h3>
                <p style="color: #999;">Vui lòng thử điều chỉnh bộ lọc tìm kiếm</p>
            </div>
        </c:if>
    </div>
</body>
</html>
