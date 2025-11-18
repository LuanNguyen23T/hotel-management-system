package com.example.model;

import com.example.bean.Booking;
import com.example.bean.Room;
import com.example.bean.Customer;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class BookingDAO {
    private static List<Booking> bookings = new ArrayList<>();
    private static int nextId = 1;
    private RoomDAO roomDAO = new RoomDAO();
    private CustomerDAO customerDAO = new CustomerDAO();
    
    static {
        // Sample data
        Date now = new Date();
        Date tomorrow = new Date(now.getTime() + 86400000);
        Date nextWeek = new Date(now.getTime() + 7 * 86400000);
        
        Booking b1 = new Booking(nextId++, 1, 4, now, nextWeek, 2, 5600000, 
                                "Confirmed", "Tầng cao, view đẹp", new Date());
        b1.setCustomerName("Nguyễn Văn A");
        b1.setRoomNumber("202");
        bookings.add(b1);
        
        Booking b2 = new Booking(nextId++, 2, 2, tomorrow, new Date(tomorrow.getTime() + 3 * 86400000), 
                                1, 1500000, "Pending", "", new Date());
        b2.setCustomerName("Trần Thị B");
        b2.setRoomNumber("102");
        bookings.add(b2);
    }
    
    public List<Booking> getAllBookings() {
        List<Booking> allBookings = new ArrayList<>(bookings);
        // Enrich with customer and room info
        for (Booking booking : allBookings) {
            Customer customer = customerDAO.getCustomerById(booking.getCustomerId());
            Room room = roomDAO.getRoomById(booking.getRoomId());
            if (customer != null) {
                booking.setCustomerName(customer.getFullName());
            }
            if (room != null) {
                booking.setRoomNumber(room.getRoomNumber());
            }
        }
        return allBookings;
    }
    
    public Booking getBookingById(int id) {
        Booking booking = bookings.stream()
                .filter(b -> b.getId() == id)
                .findFirst()
                .orElse(null);
        
        if (booking != null) {
            Customer customer = customerDAO.getCustomerById(booking.getCustomerId());
            Room room = roomDAO.getRoomById(booking.getRoomId());
            if (customer != null) {
                booking.setCustomerName(customer.getFullName());
            }
            if (room != null) {
                booking.setRoomNumber(room.getRoomNumber());
            }
        }
        return booking;
    }
    
    public List<Booking> getBookingsByCustomer(int customerId) {
        return bookings.stream()
                .filter(b -> b.getCustomerId() == customerId)
                .collect(Collectors.toList());
    }
    
    public List<Booking> getBookingsByRoom(int roomId) {
        return bookings.stream()
                .filter(b -> b.getRoomId() == roomId)
                .collect(Collectors.toList());
    }
    
    public List<Booking> getBookingsByStatus(String status) {
        return bookings.stream()
                .filter(b -> b.getStatus().equals(status))
                .collect(Collectors.toList());
    }
    
    public boolean addBooking(Booking booking) {
        booking.setId(nextId++);
        booking.setBookingDate(new Date());
        booking.setStatus("Pending");
        return bookings.add(booking);
    }
    
    public boolean updateBooking(Booking booking) {
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getId() == booking.getId()) {
                bookings.set(i, booking);
                return true;
            }
        }
        return false;
    }
    
    public boolean deleteBooking(int id) {
        return bookings.removeIf(b -> b.getId() == id);
    }
    
    public boolean updateBookingStatus(int id, String status) {
        Booking booking = getBookingById(id);
        if (booking != null) {
            booking.setStatus(status);
            
            // Update room status based on booking status
            if ("CheckedIn".equals(status)) {
                roomDAO.updateRoomStatus(booking.getRoomId(), "Occupied");
            } else if ("CheckedOut".equals(status) || "Cancelled".equals(status)) {
                roomDAO.updateRoomStatus(booking.getRoomId(), "Available");
            }
            return true;
        }
        return false;
    }
    
    public int countBookingsByStatus(String status) {
        return (int) bookings.stream()
                .filter(b -> b.getStatus().equals(status))
                .count();
    }
    
    public double getTotalRevenue() {
        return bookings.stream()
                .filter(b -> "CheckedOut".equals(b.getStatus()))
                .mapToDouble(Booking::getTotalPrice)
                .sum();
    }
}
