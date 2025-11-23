package com.example.filter;

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

import com.example.bean.User;

public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        boolean isLoggedIn = (user != null);
        
        // Allow access to login page, static resources
        if (requestURI.contains("/login") || 
            requestURI.contains("/css/") || 
            requestURI.contains("/js/") || 
            requestURI.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // If not logged in and trying to access protected resources, redirect to login
        if (!isLoggedIn) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        
        // User is logged in, allow access
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
