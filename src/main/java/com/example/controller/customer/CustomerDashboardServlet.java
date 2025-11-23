package com.example.controller.customer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.bean.Customer;
import com.example.bo.BookingBO;
import com.example.bo.RoomBO;

public class CustomerDashboardServlet extends HttpServlet {
    
    private RoomBO roomBO;
    private BookingBO bookingBO;
    
    @Override
    public void init() throws ServletException {
        roomBO = new RoomBO();
        bookingBO = new BookingBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Get statistics
        int availableRooms = roomBO.countAvailableRooms();
        int myBookings = bookingBO.getBookingsByCustomerId(customer.getId()).size();
        
        // Set attributes
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("myBookings", myBookings);
        request.setAttribute("recentBookings", bookingBO.getBookingsByCustomerId(customer.getId()));
        request.setAttribute("availableRoomsList", roomBO.getAvailableRooms());
        
        request.getRequestDispatcher("/WEB-INF/views/customer/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
