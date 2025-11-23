package com.example.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            action = "home";
        }
        
        switch (action) {
            case "home":
                showHome(request, response);
                break;
            case "list":
                listItems(request, response);
                break;
            case "add":
                addItem(request, response);
                break;
            default:
                showHome(request, response);
                break;
        }
    }
    
    private void showHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/auth?action=login");
    }
    
    private void listItems(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Logic to list items
        request.getRequestDispatcher("/WEB-INF/views/list.jsp").forward(request, response);
    }
    
    private void addItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Logic to add item
        response.sendRedirect(request.getContextPath() + "?action=list");
    }
}
