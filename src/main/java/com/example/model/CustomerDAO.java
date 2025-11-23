package com.example.model;

import java.util.ArrayList;
import java.util.List;

import com.example.bean.Customer;

public class CustomerDAO {
    private static List<Customer> customers = new ArrayList<>();
    private static int nextId = 1;
    
    static {
        // Sample data with username and password for login
        Customer c1 = new Customer(nextId++, "Nguyễn Văn A", "nguyenvana@email.com", 
                                   "0901234567", "001234567890", "Hà Nội", "Việt Nam");
        c1.setUsername("customer1");
        c1.setPassword("customer123");
        customers.add(c1);
        
        Customer c2 = new Customer(nextId++, "Trần Thị B", "tranthib@email.com", 
                                   "0912345678", "001234567891", "TP.HCM", "Việt Nam");
        c2.setUsername("customer2");
        c2.setPassword("customer123");
        customers.add(c2);
        
        Customer c3 = new Customer(nextId++, "Lê Văn C", "levanc@email.com", 
                                   "0923456789", "001234567892", "Đà Nẵng", "Việt Nam");
        c3.setUsername("customer3");
        c3.setPassword("customer123");
        customers.add(c3);
    }
    
    public List<Customer> getAllCustomers() {
        return new ArrayList<>(customers);
    }
    
    public Customer getCustomerById(int id) {
        return customers.stream()
                .filter(c -> c.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    public Customer getCustomerByEmail(String email) {
        return customers.stream()
                .filter(c -> c.getEmail().equals(email))
                .findFirst()
                .orElse(null);
    }
    
    public Customer getCustomerByIdCard(String idCard) {
        return customers.stream()
                .filter(c -> c.getIdCard().equals(idCard))
                .findFirst()
                .orElse(null);
    }
    
    public List<Customer> searchCustomers(String keyword) {
        String lowerKeyword = keyword.toLowerCase();
        return customers.stream()
                .filter(c -> c.getFullName().toLowerCase().contains(lowerKeyword) ||
                           c.getEmail().toLowerCase().contains(lowerKeyword) ||
                           c.getPhone().contains(keyword) ||
                           c.getIdCard().contains(keyword))
                .collect(java.util.stream.Collectors.toList());
    }
    
    public boolean addCustomer(Customer customer) {
        customer.setId(nextId++);
        return customers.add(customer);
    }
    
    public boolean updateCustomer(Customer customer) {
        for (int i = 0; i < customers.size(); i++) {
            if (customers.get(i).getId() == customer.getId()) {
                customers.set(i, customer);
                return true;
            }
        }
        return false;
    }
    
    public boolean deleteCustomer(int id) {
        return customers.removeIf(c -> c.getId() == id);
    }
    
    public int getTotalCustomers() {
        return customers.size();
    }
    
    public Customer getCustomerByUsername(String username) {
        return customers.stream()
                .filter(c -> c.getUsername() != null && c.getUsername().equals(username))
                .findFirst()
                .orElse(null);
    }
    
    public Customer validateCustomerLogin(String username, String password) {
        return customers.stream()
                .filter(c -> c.getUsername() != null && c.getUsername().equals(username) &&
                           c.getPassword() != null && c.getPassword().equals(password))
                .findFirst()
                .orElse(null);
    }
}
