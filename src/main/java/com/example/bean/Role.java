package com.example.bean;

public enum Role {
    ADMIN("Admin"),
    STAFF("Staff"),
    MANAGER("Manager");
    
    private String displayName;
    
    Role(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}
