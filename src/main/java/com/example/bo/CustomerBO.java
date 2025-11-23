package com.example.bo;

import java.util.List;

import com.example.bean.Customer;
import com.example.model.CustomerDAO;

public class CustomerBO {
    private CustomerDAO customerDAO;
    
    public CustomerBO() {
        this.customerDAO = new CustomerDAO();
    }
    
    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }
    
    public Customer getCustomerById(int id) {
        return customerDAO.getCustomerById(id);
    }
    
    public List<Customer> searchCustomers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return customerDAO.getAllCustomers();
        }
        return customerDAO.searchCustomers(keyword);
    }
    
    public boolean addCustomer(Customer customer) {
        // Validate
        if (!validateCustomer(customer)) {
            return false;
        }
        
        // Check duplicate email
        if (customerDAO.getCustomerByEmail(customer.getEmail()) != null) {
            return false;
        }
        
        // Check duplicate ID card
        if (customerDAO.getCustomerByIdCard(customer.getIdCard()) != null) {
            return false;
        }
        
        return customerDAO.addCustomer(customer);
    }
    
    public boolean updateCustomer(Customer customer) {
        if (customer.getId() <= 0) {
            return false;
        }
        
        if (!validateCustomer(customer)) {
            return false;
        }
        
        return customerDAO.updateCustomer(customer);
    }
    
    public boolean deleteCustomer(int id) {
        if (id <= 0) {
            return false;
        }
        return customerDAO.deleteCustomer(id);
    }
    
    private boolean validateCustomer(Customer customer) {
        if (customer.getFullName() == null || customer.getFullName().trim().isEmpty()) {
            return false;
        }
        
        if (customer.getEmail() == null || !isValidEmail(customer.getEmail())) {
            return false;
        }
        
        if (customer.getPhone() == null || customer.getPhone().trim().isEmpty()) {
            return false;
        }
        
        if (customer.getIdCard() == null || customer.getIdCard().trim().isEmpty()) {
            return false;
        }
        
        return true;
    }
    
    private boolean isValidEmail(String email) {
        return email != null && email.contains("@") && email.contains(".");
    }
    
    public int getTotalCustomers() {
        return customerDAO.getTotalCustomers();
    }
    
    public Customer loginCustomer(String username, String password) {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            return null;
        }
        return customerDAO.validateCustomerLogin(username, password);
    }
    
    public boolean registerCustomer(Customer customer) {
        // Validate basic customer info
        if (!validateCustomer(customer)) {
            return false;
        }
        
        // Validate username and password
        if (customer.getUsername() == null || customer.getUsername().trim().isEmpty()) {
            return false;
        }
        
        if (customer.getPassword() == null || customer.getPassword().length() < 6) {
            return false;
        }
        
        // Check duplicate username
        if (customerDAO.getCustomerByUsername(customer.getUsername()) != null) {
            return false;
        }
        
        // Check duplicate email
        if (customerDAO.getCustomerByEmail(customer.getEmail()) != null) {
            return false;
        }
        
        // Check duplicate ID card
        if (customerDAO.getCustomerByIdCard(customer.getIdCard()) != null) {
            return false;
        }
        
        return customerDAO.addCustomer(customer);
    }
}
