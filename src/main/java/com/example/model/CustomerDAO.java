package com.example.model;

import com.example.bean.Customer;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private static List<Customer> customers = new ArrayList<>();
    private static int nextId = 1;
    
    static {
        // Sample data
        customers.add(new Customer(nextId++, "Nguyễn Văn A", "nguyenvana@email.com", 
                                   "0901234567", "001234567890", "Hà Nội", "Việt Nam"));
        customers.add(new Customer(nextId++, "Trần Thị B", "tranthib@email.com", 
                                   "0912345678", "001234567891", "TP.HCM", "Việt Nam"));
        customers.add(new Customer(nextId++, "Lê Văn C", "levanc@email.com", 
                                   "0923456789", "001234567892", "Đà Nẵng", "Việt Nam"));
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
}
