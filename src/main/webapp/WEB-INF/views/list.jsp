<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.bean.User" %>
<%@ page import="com.example.model.UserDAO" %>
<%
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #008CBA;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
        .back-link:hover {
            background-color: #007399;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User List</h1>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for (User user : users) { 
                %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                </tr>
                <% 
                } 
                %>
            </tbody>
        </table>
        
        <a href="${pageContext.request.contextPath}?action=home" class="back-link">Back to Home</a>
    </div>
</body>
</html>
