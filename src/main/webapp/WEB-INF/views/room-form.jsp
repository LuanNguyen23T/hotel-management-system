<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${room.id == 0 ? 'Add' : 'Edit'} Room - Hotel Management</title>
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
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        .form-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-card h2 {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #667eea;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 500;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            font-family: inherit;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }
        .btn {
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 1rem;
            font-weight: 500;
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
            background: #95a5a6;
            color: white;
        }
        .btn-secondary:hover {
            background: #7f8c8d;
        }
        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .required {
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>🏨 Hotel Management System</h1>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/rooms?action=list">Rooms</a></li>
            <li><a href="${pageContext.request.contextPath}/customers?action=list">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/bookings?action=list">Bookings</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="form-card">
            <h2>${room.id == 0 ? '➕ Add New Room' : '✏️ Edit Room'}</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/rooms">
                <input type="hidden" name="action" value="${room.id == 0 ? 'insert' : 'update'}">
                <c:if test="${room.id != 0}">
                    <input type="hidden" name="id" value="${room.id}">
                </c:if>

                <div class="form-group">
                    <label for="roomNumber">Room Number <span class="required">*</span></label>
                    <input type="text" id="roomNumber" name="roomNumber" 
                           value="${room.roomNumber}" required 
                           placeholder="e.g., 101, 201, A-301">
                </div>

                <div class="form-group">
                    <label for="roomType">Room Type <span class="required">*</span></label>
                    <select id="roomType" name="roomType" required>
                        <option value="">Select Room Type</option>
                        <option value="Single" ${room.roomType == 'Single' ? 'selected' : ''}>Single</option>
                        <option value="Double" ${room.roomType == 'Double' ? 'selected' : ''}>Double</option>
                        <option value="Suite" ${room.roomType == 'Suite' ? 'selected' : ''}>Suite</option>
                        <option value="Deluxe" ${room.roomType == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                    </select>
                </div>

                                <div class="form-group">
                    <label for="pricePerNight">Giá/Đêm (VNĐ) *</label>
                    <input type="number" class="form-control" id="pricePerNight" name="pricePerNight" 
                           value="${room.pricePerNight}" step="1000" required>
                </div>

                <div class="form-group">
                    <label for="capacity">Capacity (Guests) <span class="required">*</span></label>
                    <input type="number" id="capacity" name="capacity" 
                           value="${room.capacity}" required min="1" max="10"
                           placeholder="e.g., 2">
                </div>

                <div class="form-group">
                    <label for="status">Status <span class="required">*</span></label>
                    <select id="status" name="status" required>
                        <option value="Available" ${room.status == 'Available' ? 'selected' : ''}>Available</option>
                        <option value="Occupied" ${room.status == 'Occupied' ? 'selected' : ''}>Occupied</option>
                        <option value="Maintenance" ${room.status == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" 
                              placeholder="Enter room description, amenities, etc...">${room.description}</textarea>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/rooms?action=list" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        ${room.id == 0 ? 'Add Room' : 'Update Room'}
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
