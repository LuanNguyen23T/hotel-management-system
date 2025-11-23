package com.example.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Cho phép truy cập trang login, register và static resources
        if (uri.endsWith("/auth") || uri.endsWith("/auth/login") || uri.endsWith("/auth/register") ||
            uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Kiểm tra đăng nhập cho các trang admin
        if (uri.startsWith(contextPath + "/admin") || 
            uri.startsWith(contextPath + "/dashboard") ||
            uri.startsWith(contextPath + "/rooms") ||
            uri.startsWith(contextPath + "/customers") ||
            uri.startsWith(contextPath + "/bookings")) {
            
            if (session == null || session.getAttribute("user") == null) {
                httpResponse.sendRedirect(contextPath + "/auth?action=login");
                return;
            }
            
            // Kiểm tra role (Admin, Manager, Staff đều có thể truy cập)
            String role = (String) session.getAttribute("role");
            if (role == null || (!role.equals("Admin") && !role.equals("Manager") && !role.equals("Staff"))) {
                httpResponse.sendRedirect(contextPath + "/auth?action=login&error=unauthorized");
                return;
            }
        }
        
        // Kiểm tra đăng nhập cho các trang customer
        if (uri.startsWith(contextPath + "/customer")) {
            if (session == null || session.getAttribute("customer") == null) {
                httpResponse.sendRedirect(contextPath + "/auth?action=login");
                return;
            }
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
