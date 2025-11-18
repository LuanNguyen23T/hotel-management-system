package com.example.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.bo.BookingBO;
import com.example.bo.RoomBO;
import com.example.bo.CustomerBO;
import com.example.bean.Booking;
import java.util.List;

public class BookingServlet extends HttpServlet {
    
    private BookingBO bookingBO;
    private RoomBO roomBO;
    private CustomerBO customerBO;
    
    @Override
    public void init() throws ServletException {
        bookingBO = new BookingBO();
        roomBO = new RoomBO();
        customerBO = new CustomerBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listBookings(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBooking(request, response);
                break;
            case "confirm":
                confirmBooking(request, response);
                break;
            case "checkin":
                checkInBooking(request, response);
                break;
            case "checkout":
                checkOutBooking(request, response);
                break;
            case "cancel":
                cancelBooking(request, response);
                break;
            default:
                listBookings(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addBooking(request, response);
        } else if ("edit".equals(action)) {
            updateBooking(request, response);
        } else {
            doGet(request, response);
        }
    }
    
    private void listBookings(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String filterStatus = request.getParameter("status");
        List<Booking> bookings;
        
        if (filterStatus != null && !filterStatus.isEmpty()) {
            bookings = bookingBO.getBookingsByStatus(filterStatus);
        } else {
            bookings = bookingBO.getAllBookings();
        }
        
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/bookings.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("customers", customerBO.getAllCustomers());
        request.setAttribute("rooms", roomBO.getAvailableRooms());
        request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Booking booking = bookingBO.getBookingById(id);
        request.setAttribute("booking", booking);
        request.setAttribute("customers", customerBO.getAllCustomers());
        request.setAttribute("rooms", roomBO.getAllRooms());
        request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
    }
    
    private void addBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkInDateStr = request.getParameter("checkInDate");
            String checkOutDateStr = request.getParameter("checkOutDate");
            int numberOfGuests = Integer.parseInt(request.getParameter("numberOfGuests"));
            String specialRequests = request.getParameter("specialRequests");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkInDate = sdf.parse(checkInDateStr);
            Date checkOutDate = sdf.parse(checkOutDateStr);
            
            Booking booking = new Booking();
            booking.setCustomerId(customerId);
            booking.setRoomId(roomId);
            booking.setCheckInDate(checkInDate);
            booking.setCheckOutDate(checkOutDate);
            booking.setNumberOfGuests(numberOfGuests);
            booking.setSpecialRequests(specialRequests);
            
            if (bookingBO.addBooking(booking)) {
                response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=add");
            } else {
                request.setAttribute("error", "Không thể tạo đặt phòng. Phòng có thể không khả dụng hoặc dữ liệu không hợp lệ.");
                request.setAttribute("customers", customerBO.getAllCustomers());
                request.setAttribute("rooms", roomBO.getAvailableRooms());
                request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.setAttribute("customers", customerBO.getAllCustomers());
            request.setAttribute("rooms", roomBO.getAvailableRooms());
            request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
        }
    }
    
    private void updateBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkInDateStr = request.getParameter("checkInDate");
            String checkOutDateStr = request.getParameter("checkOutDate");
            int numberOfGuests = Integer.parseInt(request.getParameter("numberOfGuests"));
            String specialRequests = request.getParameter("specialRequests");
            String status = request.getParameter("status");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkInDate = sdf.parse(checkInDateStr);
            Date checkOutDate = sdf.parse(checkOutDateStr);
            
            Booking booking = new Booking();
            booking.setId(id);
            booking.setCustomerId(customerId);
            booking.setRoomId(roomId);
            booking.setCheckInDate(checkInDate);
            booking.setCheckOutDate(checkOutDate);
            booking.setNumberOfGuests(numberOfGuests);
            booking.setSpecialRequests(specialRequests);
            booking.setStatus(status);
            
            if (bookingBO.updateBooking(booking)) {
                response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=update");
            } else {
                request.setAttribute("error", "Không thể cập nhật đặt phòng.");
                request.setAttribute("booking", booking);
                request.setAttribute("customers", customerBO.getAllCustomers());
                request.setAttribute("rooms", roomBO.getAllRooms());
                request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
        }
    }
    
    private void deleteBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookingBO.deleteBooking(id);
        response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=delete");
    }
    
    private void confirmBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookingBO.confirmBooking(id);
        response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=confirm");
    }
    
    private void checkInBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookingBO.checkIn(id);
        response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=checkin");
    }
    
    private void checkOutBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookingBO.checkOut(id);
        response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=checkout");
    }
    
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookingBO.cancelBooking(id);
        response.sendRedirect(request.getContextPath() + "/bookings?action=list&success=cancel");
    }
}
