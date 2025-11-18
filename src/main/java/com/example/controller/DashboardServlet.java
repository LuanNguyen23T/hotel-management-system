package com.example.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.bo.RoomBO;
import com.example.bo.CustomerBO;
import com.example.bo.BookingBO;

public class DashboardServlet extends HttpServlet {
    
    private RoomBO roomBO;
    private CustomerBO customerBO;
    private BookingBO bookingBO;
    
    @Override
    public void init() throws ServletException {
        roomBO = new RoomBO();
        customerBO = new CustomerBO();
        bookingBO = new BookingBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get statistics
        int totalRooms = roomBO.getAllRooms().size();
        int availableRooms = roomBO.countAvailableRooms();
        int occupiedRooms = roomBO.countOccupiedRooms();
        int totalCustomers = customerBO.getTotalCustomers();
        int pendingBookings = bookingBO.countPendingBookings();
        int confirmedBookings = bookingBO.countConfirmedBookings();
        double totalRevenue = bookingBO.getTotalRevenue();
        
        // Set attributes
        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("occupiedRooms", occupiedRooms);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("confirmedBookings", confirmedBookings);
        request.setAttribute("totalRevenue", totalRevenue);
        
        // Get recent bookings
        request.setAttribute("recentBookings", bookingBO.getAllBookings());
        
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
