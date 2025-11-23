package com.example.controller.customer;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.bean.Booking;
import com.example.bean.Customer;
import com.example.bean.Room;
import com.example.bo.BookingBO;
import com.example.bo.RoomBO;

public class CustomerBookingServlet extends HttpServlet {
    
    private BookingBO bookingBO;
    private RoomBO roomBO;
    
    @Override
    public void init() throws ServletException {
        bookingBO = new BookingBO();
        roomBO = new RoomBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        switch (action) {
            case "available":
                showAvailableRooms(request, response);
                break;
            case "book":
                showBookingForm(request, response);
                break;
            case "my-bookings":
                showMyBookings(request, response);
                break;
            case "view":
                viewBookingDetail(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "cancel":
                cancelBooking(request, response);
                break;
            default:
                showAvailableRooms(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createBooking(request, response);
        } else if ("update".equals(action)) {
            updateBooking(request, response);
        } else {
            showAvailableRooms(request, response);
        }
    }
    
    private void showAvailableRooms(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Room> allRooms = roomBO.getAllRooms();
        
        // Filter only available rooms
        List<Room> availableRooms = allRooms.stream()
                .filter(room -> "Available".equals(room.getStatus()))
                .collect(Collectors.toList());
        
        // Filter by room type if provided
        String roomType = request.getParameter("roomType");
        if (roomType != null && !roomType.isEmpty() && !"all".equals(roomType)) {
            availableRooms = availableRooms.stream()
                    .filter(room -> roomType.equals(room.getRoomType()))
                    .collect(Collectors.toList());
        }
        
        // Filter by max price if provided
        String maxPriceStr = request.getParameter("maxPrice");
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try {
                double maxPrice = Double.parseDouble(maxPriceStr);
                availableRooms = availableRooms.stream()
                        .filter(room -> room.getPricePerNight() <= maxPrice)
                        .collect(Collectors.toList());
            } catch (NumberFormatException e) {
                // Ignore invalid price
            }
        }
        
        request.setAttribute("rooms", availableRooms);
        request.setAttribute("selectedType", roomType);
        request.setAttribute("maxPrice", maxPriceStr);
        request.getRequestDispatcher("/WEB-INF/views/customer/available-rooms.jsp").forward(request, response);
    }
    
    private void showBookingForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String roomIdStr = request.getParameter("roomId");
        if (roomIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/customer/booking?action=available");
            return;
        }
        
        try {
            int roomId = Integer.parseInt(roomIdStr);
            Room room = roomBO.getRoomById(roomId);
            
            if (room == null || !"Available".equals(room.getStatus())) {
                request.setAttribute("error", "Phòng không khả dụng!");
                showAvailableRooms(request, response);
                return;
            }
            
            request.setAttribute("room", room);
            request.getRequestDispatcher("/WEB-INF/views/customer/booking-form.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/booking?action=available");
        }
    }
    
    private void createBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkInStr = request.getParameter("checkInDate");
            String checkOutStr = request.getParameter("checkOutDate");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkInDate = sdf.parse(checkInStr);
            Date checkOutDate = sdf.parse(checkOutStr);
            
            // Validate dates
            Date today = new Date();
            if (checkInDate.before(today)) {
                request.setAttribute("error", "Ngày check-in phải từ hôm nay trở đi!");
                request.setAttribute("roomId", roomId);
                showBookingForm(request, response);
                return;
            }
            
            if (checkOutDate.before(checkInDate) || checkOutDate.equals(checkInDate)) {
                request.setAttribute("error", "Ngày check-out phải sau ngày check-in!");
                request.setAttribute("roomId", roomId);
                showBookingForm(request, response);
                return;
            }
            
            // Create booking
            Booking booking = new Booking();
            booking.setCustomerId(customer.getId());
            booking.setRoomId(roomId);
            booking.setCheckInDate(checkInDate);
            booking.setCheckOutDate(checkOutDate);
            booking.setStatus("Confirmed");
            booking.setNumberOfGuests(1); // Default to 1 guest
            booking.setBookingDate(new Date()); // Current date/time
            
            // Calculate total price
            Room room = roomBO.getRoomById(roomId);
            long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
            double totalPrice = room.getPricePerNight() * days;
            booking.setTotalPrice(totalPrice);
            
            if (bookingBO.addBooking(booking)) {
                // Update room status
                room.setStatus("Booked");
                roomBO.updateRoom(room);
                
                session.setAttribute("success", "Đặt phòng thành công!");
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
            } else {
                request.setAttribute("error", "Đặt phòng thất bại!");
                showBookingForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showBookingForm(request, response);
        }
    }
    
    private void showMyBookings(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        List<Booking> bookings = bookingBO.getBookingsByCustomerId(customer.getId());
        
        // Get room info for each booking
        for (Booking booking : bookings) {
            Room room = roomBO.getRoomById(booking.getRoomId());
            booking.setRoom(room);
        }
        
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/customer/my-bookings.jsp").forward(request, response);
    }
    
    private void viewBookingDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            Booking booking = bookingBO.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
                return;
            }
            
            // Get room and customer info
            Room room = roomBO.getRoomById(booking.getRoomId());
            booking.setRoom(room);
            
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/views/customer/booking-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
        }
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            Booking booking = bookingBO.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
                return;
            }
            
            // Only allow edit if status is Confirmed (not checked in yet)
            if (!"Confirmed".equals(booking.getStatus())) {
                request.setAttribute("error", "Chỉ có thể chỉnh sửa đặt phòng ở trạng thái Confirmed!");
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=view&id=" + bookingId);
                return;
            }
            
            Room room = roomBO.getRoomById(booking.getRoomId());
            booking.setRoom(room);
            
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/views/customer/booking-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
        }
    }
    
    private void updateBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String checkInStr = request.getParameter("checkInDate");
            String checkOutStr = request.getParameter("checkOutDate");
            
            Booking booking = bookingBO.getBookingById(bookingId);
            if (booking == null || !"Confirmed".equals(booking.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
                return;
            }
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkInDate = sdf.parse(checkInStr);
            Date checkOutDate = sdf.parse(checkOutStr);
            
            // Validate dates
            Date today = new Date();
            if (checkInDate.before(today)) {
                request.setAttribute("error", "Ngày check-in phải từ hôm nay trở đi!");
                showEditForm(request, response);
                return;
            }
            
            if (checkOutDate.before(checkInDate) || checkOutDate.equals(checkInDate)) {
                request.setAttribute("error", "Ngày check-out phải sau ngày check-in!");
                showEditForm(request, response);
                return;
            }
            
            // Update booking
            booking.setCheckInDate(checkInDate);
            booking.setCheckOutDate(checkOutDate);
            
            // Recalculate total price
            Room room = roomBO.getRoomById(booking.getRoomId());
            long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
            double totalPrice = room.getPricePerNight() * days;
            booking.setTotalPrice(totalPrice);
            
            if (bookingBO.updateBooking(booking)) {
                HttpSession session = request.getSession();
                session.setAttribute("success", "Cập nhật đặt phòng thành công!");
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=view&id=" + bookingId);
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
                showEditForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showEditForm(request, response);
        }
    }
    
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            Booking booking = bookingBO.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
                return;
            }
            
            // Only allow cancel if status is Confirmed
            if (!"Confirmed".equals(booking.getStatus())) {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Chỉ có thể hủy đặt phòng ở trạng thái Confirmed!");
                response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
                return;
            }
            
            // Update booking status
            booking.setStatus("Cancelled");
            bookingBO.updateBooking(booking);
            
            // Update room status back to Available
            Room room = roomBO.getRoomById(booking.getRoomId());
            room.setStatus("Available");
            roomBO.updateRoom(room);
            
            HttpSession session = request.getSession();
            session.setAttribute("success", "Hủy đặt phòng thành công!");
            response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/booking?action=my-bookings");
        }
    }
}
