package com.example.bean;

public class Customer {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String idCard;
    private String address;
    private String nationality;
    
    public Customer() {
    }
    
    public Customer(int id, String fullName, String email, String phone, 
                   String idCard, String address, String nationality) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.idCard = idCard;
        this.address = address;
        this.nationality = nationality;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getIdCard() {
        return idCard;
    }
    
    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getNationality() {
        return nationality;
    }
    
    public void setNationality(String nationality) {
        this.nationality = nationality;
    }
    
    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", idCard='" + idCard + '\'' +
                '}';
    }
}
