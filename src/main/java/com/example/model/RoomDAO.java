package com.example.model;

import com.example.bean.Room;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RoomDAO {
    private static List<Room> rooms = new ArrayList<>();
    private static int nextId = 1;
    
    static {
        // Sample data
        rooms.add(new Room(nextId++, "101", "Single", 500000, "Available", 1, "Phòng đơn tiện nghi"));
        rooms.add(new Room(nextId++, "102", "Single", 500000, "Available", 1, "Phòng đơn view thành phố"));
        rooms.add(new Room(nextId++, "201", "Double", 800000, "Available", 2, "Phòng đôi cao cấp"));
        rooms.add(new Room(nextId++, "202", "Double", 800000, "Occupied", 2, "Phòng đôi view biển"));
        rooms.add(new Room(nextId++, "301", "Suite", 1500000, "Available", 4, "Phòng Suite sang trọng"));
        rooms.add(new Room(nextId++, "302", "Deluxe", 2000000, "Available", 4, "Phòng Deluxe đẳng cấp"));
        rooms.add(new Room(nextId++, "401", "Suite", 1500000, "Maintenance", 4, "Phòng Suite đang bảo trì"));
    }
    
    public List<Room> getAllRooms() {
        return new ArrayList<>(rooms);
    }
    
    public Room getRoomById(int id) {
        return rooms.stream()
                .filter(r -> r.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    public Room getRoomByNumber(String roomNumber) {
        return rooms.stream()
                .filter(r -> r.getRoomNumber().equals(roomNumber))
                .findFirst()
                .orElse(null);
    }
    
    public List<Room> getAvailableRooms() {
        return rooms.stream()
                .filter(r -> "Available".equals(r.getStatus()))
                .collect(Collectors.toList());
    }
    
    public List<Room> getRoomsByType(String type) {
        return rooms.stream()
                .filter(r -> r.getRoomType().equals(type))
                .collect(Collectors.toList());
    }
    
    public List<Room> getRoomsByStatus(String status) {
        return rooms.stream()
                .filter(r -> r.getStatus().equals(status))
                .collect(Collectors.toList());
    }
    
    public boolean addRoom(Room room) {
        room.setId(nextId++);
        return rooms.add(room);
    }
    
    public boolean updateRoom(Room room) {
        for (int i = 0; i < rooms.size(); i++) {
            if (rooms.get(i).getId() == room.getId()) {
                rooms.set(i, room);
                return true;
            }
        }
        return false;
    }
    
    public boolean deleteRoom(int id) {
        return rooms.removeIf(r -> r.getId() == id);
    }
    
    public boolean updateRoomStatus(int id, String status) {
        Room room = getRoomById(id);
        if (room != null) {
            room.setStatus(status);
            return true;
        }
        return false;
    }
    
    public int countRoomsByStatus(String status) {
        return (int) rooms.stream()
                .filter(r -> r.getStatus().equals(status))
                .count();
    }
}
