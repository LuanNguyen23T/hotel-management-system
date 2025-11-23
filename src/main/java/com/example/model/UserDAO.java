package com.example.model;

import java.util.ArrayList;
import java.util.List;

import com.example.bean.User;

public class UserDAO {
    private static List<User> users = new ArrayList<>();
    private static int nextId = 1;
    
    static {
        // Sample users với các role khác nhau
        users.add(new User(nextId++, "admin", "admin123", "Quản trị viên", "admin@hotel.com", "Admin", true));
        users.add(new User(nextId++, "manager", "manager123", "Nguyễn Văn Quản lý", "manager@hotel.com", "Manager", true));
        users.add(new User(nextId++, "staff", "staff123", "Trần Thị Nhân viên", "staff@hotel.com", "Staff", true));
    }
    
    public User validateUser(String username, String password) {
        return users.stream()
                .filter(u -> u.getUsername().equals(username) && 
                           u.getPassword().equals(password) && 
                           u.isActive())
                .findFirst()
                .orElse(null);
    }
    
    public User getUserByUsername(String username) {
        return users.stream()
                .filter(u -> u.getUsername().equals(username))
                .findFirst()
                .orElse(null);
    }
    
    public User getUserById(int id) {
        return users.stream()
                .filter(u -> u.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    public List<User> getAllUsers() {
        return new ArrayList<>(users);
    }
    
    public boolean addUser(User user) {
        if (getUserByUsername(user.getUsername()) != null) {
            return false;
        }
        user.setId(nextId++);
        return users.add(user);
    }
    
    public boolean updateUser(User user) {
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId() == user.getId()) {
                users.set(i, user);
                return true;
            }
        }
        return false;
    }
    
    public boolean deleteUser(int id) {
        return users.removeIf(u -> u.getId() == id);
    }
}
