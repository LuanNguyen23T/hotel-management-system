package com.example.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.bean.Room;
import com.example.bo.RoomBO;

public class AdminRoomServlet extends HttpServlet {
    
    private RoomBO roomBO;
    
    @Override
    public void init() throws ServletException {
        roomBO = new RoomBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listRooms(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteRoom(request, response);
                break;
            case "updateStatus":
                updateRoomStatus(request, response);
                break;
            default:
                listRooms(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addRoom(request, response);
        } else if ("edit".equals(action)) {
            updateRoom(request, response);
        } else {
            doGet(request, response);
        }
    }
    
    private void listRooms(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String filterType = request.getParameter("type");
        String filterStatus = request.getParameter("status");
        List<Room> rooms;
        
        // Filter by both type and status
        if ((filterStatus != null && !filterStatus.isEmpty()) || (filterType != null && !filterType.isEmpty())) {
            rooms = roomBO.getRoomsByFilter(filterStatus, filterType);
        } else {
            rooms = roomBO.getAllRooms();
        }
        
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/WEB-INF/views/admin/rooms.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/room-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Room room = roomBO.getRoomById(id);
        request.setAttribute("room", room);
        request.getRequestDispatcher("/WEB-INF/views/admin/room-form.jsp").forward(request, response);
    }
    
    private void addRoom(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        double pricePerNight = Double.parseDouble(request.getParameter("pricePerNight"));
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String description = request.getParameter("description");
        
        Room room = new Room();
        room.setRoomNumber(roomNumber);
        room.setRoomType(roomType);
        room.setPricePerNight(pricePerNight);
        room.setStatus("Available");
        room.setCapacity(capacity);
        room.setDescription(description);
        
        if (roomBO.addRoom(room)) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms?action=list&success=add");
        } else {
            request.setAttribute("error", "Không thể thêm phòng. Số phòng có thể đã tồn tại.");
            request.getRequestDispatcher("/WEB-INF/views/admin/room-form.jsp").forward(request, response);
        }
    }
    
    private void updateRoom(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        double pricePerNight = Double.parseDouble(request.getParameter("pricePerNight"));
        String status = request.getParameter("status");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String description = request.getParameter("description");
        
        Room room = new Room();
        room.setId(id);
        room.setRoomNumber(roomNumber);
        room.setRoomType(roomType);
        room.setPricePerNight(pricePerNight);
        room.setStatus(status);
        room.setCapacity(capacity);
        room.setDescription(description);
        
        if (roomBO.updateRoom(room)) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms?action=list&success=update");
        } else {
            request.setAttribute("error", "Không thể cập nhật phòng.");
            request.setAttribute("room", room);
            request.getRequestDispatcher("/WEB-INF/views/admin/room-form.jsp").forward(request, response);
        }
    }
    
    private void deleteRoom(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        roomBO.deleteRoom(id);
        response.sendRedirect(request.getContextPath() + "/admin/rooms?action=list&success=delete");
    }
    
    private void updateRoomStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        roomBO.updateRoomStatus(id, status);
        response.sendRedirect(request.getContextPath() + "/admin/rooms?action=list&success=status");
    }
}
