<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.bean.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome - MVC Sample</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .header h1 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .user-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .user-info h2 {
            margin-bottom: 15px;
        }
        
        .user-info p {
            margin: 5px 0;
            font-size: 16px;
        }
        
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 30px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: transform 0.2s, box-shadow 0.2s;
            display: inline-block;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-danger {
            background-color: #f44336;
            color: white;
        }
        
        .content {
            margin-top: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        
        .content h3 {
            color: #333;
            margin-bottom: 15px;
        }
        
        .content ul {
            list-style-position: inside;
            line-height: 1.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎉 Chào Mừng Bạn Đến Với Hệ Thống!</h1>
        </div>
        
        <div class="user-info">
            <h2>Thông Tin Người Dùng</h2>
            <% if (user != null) { %>
                <p><strong>ID:</strong> <%= user.getId() %></p>
                <p><strong>Username:</strong> <%= user.getUsername() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <% } else { %>
                <p>Không tìm thấy thông tin người dùng</p>
            <% } %>
        </div>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}?action=list" class="btn btn-primary">
                📋 Xem Danh Sách Users
            </a>
            <a href="${pageContext.request.contextPath}?action=home" class="btn btn-secondary">
                🏠 Trang Chủ
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                🚪 Đăng Xuất
            </a>
        </div>
        
        <div class="content">
            <h3>Các Chức Năng Hiện Có:</h3>
            <ul>
                <li>Quản lý thông tin người dùng</li>
                <li>Xem danh sách tất cả users trong hệ thống</li>
                <li>Đăng nhập và xác thực</li>
                <li>Quản lý session</li>
            </ul>
        </div>
    </div>
</body>
</html>
