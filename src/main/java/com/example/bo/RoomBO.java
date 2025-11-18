package com.example.bo;

import com.example.bean.Room;
import com.example.model.RoomDAO;
import java.util.List;

public class RoomBO {
    private RoomDAO roomDAO;
    
    public RoomBO() {
        this.roomDAO = new RoomDAO();
    }
    
    public List<Room> getAllRooms() {
        return roomDAO.getAllRooms();
    }
    
    public Room getRoomById(int id) {
        return roomDAO.getRoomById(id);
    }
    
    public List<Room> getAvailableRooms() {
        return roomDAO.getAvailableRooms();
    }
    
    public List<Room> getRoomsByType(String type) {
        if (type == null || type.trim().isEmpty()) {
            return roomDAO.getAllRooms();
        }
        return roomDAO.getRoomsByType(type);
    }
    
    public boolean addRoom(Room room) {
        // Validate
        if (room.getRoomNumber() == null || room.getRoomNumber().trim().isEmpty()) {
            return false;
        }
        
        // Check if room number already exists
        if (roomDAO.getRoomByNumber(room.getRoomNumber()) != null) {
            return false;
        }
        
        if (room.getPricePerNight() <= 0) {
            return false;
        }
        
        return roomDAO.addRoom(room);
    }
    
    public boolean updateRoom(Room room) {
        // Validate
        if (room.getId() <= 0) {
            return false;
        }
        
        if (room.getPricePerNight() <= 0) {
            return false;
        }
        
        return roomDAO.updateRoom(room);
    }
    
    public boolean deleteRoom(int id) {
        if (id <= 0) {
            return false;
        }
        return roomDAO.deleteRoom(id);
    }
    
    public boolean updateRoomStatus(int id, String status) {
        // Validate status
        if (!isValidStatus(status)) {
            return false;
        }
        return roomDAO.updateRoomStatus(id, status);
    }
    
    private boolean isValidStatus(String status) {
        return "Available".equals(status) || 
               "Occupied".equals(status) || 
               "Maintenance".equals(status);
    }
    
    public int countAvailableRooms() {
        return roomDAO.countRoomsByStatus("Available");
    }
    
    public int countOccupiedRooms() {
        return roomDAO.countRoomsByStatus("Occupied");
    }
}
