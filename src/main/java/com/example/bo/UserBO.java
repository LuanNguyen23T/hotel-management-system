package com.example.bo;

import java.util.List;

import com.example.bean.User;
import com.example.model.UserDAO;

public class UserBO {
    private UserDAO userDAO;
    
    public UserBO() {
        this.userDAO = new UserDAO();
    }
    
    public User login(String username, String password) {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            return null;
        }
        return userDAO.validateUser(username, password);
    }
    
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }
    
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public boolean addUser(User user) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return false;
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return false;
        }
        return userDAO.addUser(user);
    }
    
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
    
    public boolean deleteUser(int id) {
        return userDAO.deleteUser(id);
    }
}
