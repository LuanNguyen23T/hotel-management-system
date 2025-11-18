<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${customer.id == 0 ? 'Add' : 'Edit'} Customer - Hotel Management</title>
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
            min-height: 80px;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
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
            <h2>${customer.id == 0 ? '➕ Add New Customer' : '✏️ Edit Customer'}</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/customers">
                <input type="hidden" name="action" value="${customer.id == 0 ? 'insert' : 'update'}">
                <c:if test="${customer.id != 0}">
                    <input type="hidden" name="id" value="${customer.id}">
                </c:if>

                <div class="form-group">
                    <label for="fullName">Full Name <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" 
                           value="${customer.fullName}" required 
                           placeholder="e.g., John Doe">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" 
                               value="${customer.email}" required 
                               placeholder="e.g., john@example.com">
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" 
                               value="${customer.phone}" required 
                               placeholder="e.g., +84 123 456 789">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="idCard">ID Card Number <span class="required">*</span></label>
                        <input type="text" id="idCard" name="idCard" 
                               value="${customer.idCard}" required 
                               placeholder="e.g., 123456789012">
                    </div>

                    <div class="form-group">
                        <label for="nationality">Nationality <span class="required">*</span></label>
                        <input type="text" id="nationality" name="nationality" 
                               value="${customer.nationality}" required 
                               placeholder="e.g., Vietnam">
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" 
                              placeholder="Enter full address...">${customer.address}</textarea>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/customers?action=list" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        ${customer.id == 0 ? 'Add Customer' : 'Update Customer'}
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
