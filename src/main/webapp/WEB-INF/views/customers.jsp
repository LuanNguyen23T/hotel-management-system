<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Hotel Management System</title>
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
        .search-box {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        .search-box input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
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
        }
        td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }
        tr:hover {
            background: #f8f9fa;
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
            <li><a href="${pageContext.request.contextPath}/rooms?action=list">Phòng</a></li>
            <li><a href="${pageContext.request.contextPath}/customers?action=list" class="active">Khách hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/bookings?action=list">Đặt phòng</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>Customer Management</h2>
            <a href="${pageContext.request.contextPath}/customers?action=add" class="btn btn-primary">+ Add New Customer</a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="search-box">
            <form method="get" action="${pageContext.request.contextPath}/customers">
                <input type="hidden" name="action" value="search">
                <input type="text" name="query" placeholder="🔍 Search customers by name, email, or phone..." 
                       value="${param.query}">
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>ID Card</th>
                        <th>Nationality</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>${customer.id}</td>
                            <td><strong>${customer.fullName}</strong></td>
                            <td>${customer.email}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.idCard}</td>
                            <td>${customer.nationality}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/customers?action=edit&id=${customer.id}" 
                                   class="btn btn-warning btn-small">Edit</a>
                                <a href="${pageContext.request.contextPath}/customers?action=delete&id=${customer.id}" 
                                   class="btn btn-danger btn-small"
                                   onclick="return confirm('Are you sure you want to delete ${customer.fullName}?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty customers}">
            <div style="text-align: center; padding: 3rem; background: white; border-radius: 10px; margin-top: 2rem;">
                <h3 style="color: #666;">No customers found</h3>
                <p style="color: #999; margin-top: 1rem;">Add your first customer to get started</p>
            </div>
        </c:if>
    </div>
</body>
</html>
