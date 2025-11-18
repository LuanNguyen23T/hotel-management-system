package com.example.bean;

public class Room {
    private int id;
    private String roomNumber;
    private String roomType; // Single, Double, Suite, Deluxe
    private double pricePerNight;
    private String status; // Available, Occupied, Maintenance
    private int capacity;
    private String description;
    
    public Room() {
    }
    
    public Room(int id, String roomNumber, String roomType, double pricePerNight, 
                String status, int capacity, String description) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.status = status;
        this.capacity = capacity;
        this.description = description;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getRoomNumber() {
        return roomNumber;
    }
    
    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }
    
    public String getRoomType() {
        return roomType;
    }
    
    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }
    
    public double getPricePerNight() {
        return pricePerNight;
    }
    
    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public int getCapacity() {
        return capacity;
    }
    
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Override
    public String toString() {
        return "Room{" +
                "id=" + id +
                ", roomNumber='" + roomNumber + '\'' +
                ", roomType='" + roomType + '\'' +
                ", pricePerNight=" + pricePerNight +
                ", status='" + status + '\'' +
                ", capacity=" + capacity +
                '}';
    }
}
