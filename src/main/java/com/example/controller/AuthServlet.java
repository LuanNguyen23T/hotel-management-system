package com.example.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.bean.Customer;
import com.example.bean.User;
import com.example.bo.CustomerBO;
import com.example.bo.UserBO;

public class AuthServlet extends HttpServlet {
    
    private UserBO userBO;
    private CustomerBO customerBO;
    
    @Override
    public void init() throws ServletException {
        userBO = new UserBO();
        customerBO = new CustomerBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            logout(request, response);
        } else if ("register".equals(action)) {
            showRegisterForm(request, response);
        } else {
            showLoginForm(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            login(request, response);
        } else if ("register".equals(action)) {
            register(request, response);
        } else {
            showLoginForm(request, response);
        }
    }
    
    private void showLoginForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }
    
    private void showRegisterForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }
    
    private void login(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String accountType = request.getParameter("accountType"); // "admin" or "customer"
        
        // Check account type and login accordingly
        if ("customer".equals(accountType)) {
            // Login as customer
            Customer customer = customerBO.loginCustomer(username, password);
            
            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                session.setAttribute("customerId", customer.getId());
                session.setAttribute("username", customer.getUsername());
                session.setAttribute("fullName", customer.getFullName());
                session.setAttribute("userType", "customer");
                
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu khách hàng không đúng!");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        } else {
            // Login as admin/manager/staff
            User user = userBO.login(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("userType", "admin");
                
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu quản trị viên không đúng!");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        }
    }
    
    private void register(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String idCard = request.getParameter("idCard");
            String nationality = request.getParameter("nationality");
            String address = request.getParameter("address");
            
            Customer customer = new Customer();
            customer.setUsername(username);
            customer.setPassword(password);
            customer.setFullName(fullName);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setIdCard(idCard);
            customer.setNationality(nationality);
            customer.setAddress(address);
            
            if (customerBO.registerCustomer(customer)) {
                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại! Tên đăng nhập, email hoặc CMND đã tồn tại.");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/auth?action=login");
    }
}
