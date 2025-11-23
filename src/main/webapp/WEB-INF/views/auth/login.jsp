<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Quản lý Khách sạn</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .login-header h1 {
            color: #2c3e50;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }
        .login-header p {
            color: #7f8c8d;
            font-size: 0.95rem;
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
        .form-group input {
            width: 100%;
            padding: 0.9rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn-login {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .alert-error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        .demo-info {
            margin-top: 2rem;
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 8px;
            font-size: 0.9rem;
        }
        .demo-info h3 {
            color: #2c3e50;
            margin-bottom: 1rem;
            font-size: 1rem;
        }
        .demo-info ul {
            list-style: none;
        }
        .demo-info li {
            padding: 0.5rem;
            margin-bottom: 0.5rem;
            background: white;
            border-radius: 5px;
        }
        .demo-info strong {
            color: #667eea;
        }
        .icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e0e0e0;
            color: #7f8c8d;
        }
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .account-type {
            margin-bottom: 1.5rem;
        }
        .account-type label {
            display: block;
            margin-bottom: 0.8rem;
            color: #2c3e50;
            font-weight: 500;
            font-size: 1rem;
        }
        .radio-group {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
        }
        .radio-option {
            display: flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .radio-option:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }
        .radio-option input[type="radio"] {
            width: auto;
            margin-right: 0.5rem;
            cursor: pointer;
        }
        .radio-option input[type="radio"]:checked + span {
            color: #667eea;
            font-weight: 600;
        }
        .radio-option:has(input[type="radio"]:checked) {
            border-color: #667eea;
            background: #f8f9ff;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="icon">🏨</div>
            <h1>Đăng nhập hệ thống</h1>
            <p>Hệ thống Quản lý Khách sạn</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/auth">
            <input type="hidden" name="action" value="login">
            
            <div class="account-type">
                <label>Loại tài khoản</label>
                <div class="radio-group">
                    <label class="radio-option">
                        <input type="radio" name="accountType" value="admin" checked>
                        <span>👨‍💼 Quản trị viên</span>
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="accountType" value="customer">
                        <span>🧑‍💼 Khách hàng</span>
                    </label>
                </div>
            </div>
            
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" 
                       placeholder="Nhập tên đăng nhập" required autofocus>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" 
                       placeholder="Nhập mật khẩu" required>
            </div>

            <button type="submit" class="btn-login">Đăng nhập</button>
        </form>

        <div class="register-link">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/auth?action=register">Đăng ký ngay</a>
        </div>
    </div>
</body>
</html>
