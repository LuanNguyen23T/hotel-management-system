package com.example.bo;

import java.util.List;
import java.util.concurrent.TimeUnit;

import com.example.bean.Booking;
import com.example.bean.Room;
import com.example.model.BookingDAO;
import com.example.model.RoomDAO;

public class BookingBO {
    private BookingDAO bookingDAO;
    private RoomDAO roomDAO;
    
    public BookingBO() {
        this.bookingDAO = new BookingDAO();
        this.roomDAO = new RoomDAO();
    }
    
    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }
    
    public Booking getBookingById(int id) {
        return bookingDAO.getBookingById(id);
    }
    
    public List<Booking> getBookingsByCustomer(int customerId) {
        return bookingDAO.getBookingsByCustomer(customerId);
    }
    
    public List<Booking> getBookingsByStatus(String status) {
        return bookingDAO.getBookingsByStatus(status);
    }
    
    public boolean addBooking(Booking booking) {
        // Validate
        if (!validateBooking(booking)) {
            return false;
        }
        
        // Check room availability
        Room room = roomDAO.getRoomById(booking.getRoomId());
        if (room == null || !"Available".equals(room.getStatus())) {
            return false;
        }
        
        // Calculate total price
        long diffInMillies = booking.getCheckOutDate().getTime() - booking.getCheckInDate().getTime();
        long numberOfNights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        if (numberOfNights <= 0) {
            numberOfNights = 1;
        }
        
        double totalPrice = room.getPricePerNight() * numberOfNights;
        booking.setTotalPrice(totalPrice);
        
        return bookingDAO.addBooking(booking);
    }
    
    public boolean updateBooking(Booking booking) {
        if (booking.getId() <= 0) {
            return false;
        }
        
        if (!validateBooking(booking)) {
            return false;
        }
        
        // Recalculate total price
        Room room = roomDAO.getRoomById(booking.getRoomId());
        if (room != null) {
            long diffInMillies = booking.getCheckOutDate().getTime() - booking.getCheckInDate().getTime();
            long numberOfNights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
            if (numberOfNights <= 0) {
                numberOfNights = 1;
            }
            
            double totalPrice = room.getPricePerNight() * numberOfNights;
            booking.setTotalPrice(totalPrice);
        }
        
        return bookingDAO.updateBooking(booking);
    }
    
    public boolean deleteBooking(int id) {
        if (id <= 0) {
            return false;
        }
        
        // Get booking to update room status
        Booking booking = bookingDAO.getBookingById(id);
        if (booking != null) {
            roomDAO.updateRoomStatus(booking.getRoomId(), "Available");
        }
        
        return bookingDAO.deleteBooking(id);
    }
    
    public boolean confirmBooking(int id) {
        return bookingDAO.updateBookingStatus(id, "Confirmed");
    }
    
    public boolean checkIn(int id) {
        return bookingDAO.updateBookingStatus(id, "CheckedIn");
    }
    
    public boolean checkOut(int id) {
        return bookingDAO.updateBookingStatus(id, "CheckedOut");
    }
    
    public boolean cancelBooking(int id) {
        return bookingDAO.updateBookingStatus(id, "Cancelled");
    }
    
    private boolean validateBooking(Booking booking) {
        if (booking.getCustomerId() <= 0 || booking.getRoomId() <= 0) {
            return false;
        }
        
        if (booking.getCheckInDate() == null || booking.getCheckOutDate() == null) {
            return false;
        }
        
        if (booking.getCheckOutDate().before(booking.getCheckInDate())) {
            return false;
        }
        
        if (booking.getNumberOfGuests() <= 0) {
            return false;
        }
        
        return true;
    }
    
    public int countPendingBookings() {
        return bookingDAO.countBookingsByStatus("Pending");
    }
    
    public int countConfirmedBookings() {
        return bookingDAO.countBookingsByStatus("Confirmed");
    }
    
    public double getTotalRevenue() {
        return bookingDAO.getTotalRevenue();
    }
    
    public List<Booking> getBookingsByCustomerId(int customerId) {
        return bookingDAO.getBookingsByCustomer(customerId);
    }
}
