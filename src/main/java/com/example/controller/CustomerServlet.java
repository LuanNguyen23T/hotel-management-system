package com.example.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.example.bo.CustomerBO;
import com.example.bean.Customer;
import java.util.List;

public class CustomerServlet extends HttpServlet {
    
    private CustomerBO customerBO;
    
    @Override
    public void init() throws ServletException {
        customerBO = new CustomerBO();
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
                listCustomers(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            case "search":
                searchCustomers(request, response);
                break;
            default:
                listCustomers(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addCustomer(request, response);
        } else if ("edit".equals(action)) {
            updateCustomer(request, response);
        } else {
            doGet(request, response);
        }
    }
    
    private void listCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Customer> customers = customerBO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/WEB-INF/views/customers.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerBO.getCustomerById(id);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
    }
    
    private void addCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String idCard = request.getParameter("idCard");
        String address = request.getParameter("address");
        String nationality = request.getParameter("nationality");
        
        Customer customer = new Customer();
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setIdCard(idCard);
        customer.setAddress(address);
        customer.setNationality(nationality);
        
        if (customerBO.addCustomer(customer)) {
            response.sendRedirect(request.getContextPath() + "/customers?action=list&success=add");
        } else {
            request.setAttribute("error", "Không thể thêm khách hàng. Email hoặc CMND có thể đã tồn tại.");
            request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
        }
    }
    
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String idCard = request.getParameter("idCard");
        String address = request.getParameter("address");
        String nationality = request.getParameter("nationality");
        
        Customer customer = new Customer();
        customer.setId(id);
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setIdCard(idCard);
        customer.setAddress(address);
        customer.setNationality(nationality);
        
        if (customerBO.updateCustomer(customer)) {
            response.sendRedirect(request.getContextPath() + "/customers?action=list&success=update");
        } else {
            request.setAttribute("error", "Không thể cập nhật khách hàng.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/customer-form.jsp").forward(request, response);
        }
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        customerBO.deleteCustomer(id);
        response.sendRedirect(request.getContextPath() + "/customers?action=list&success=delete");
    }
    
    private void searchCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Customer> customers = customerBO.searchCustomers(keyword);
        request.setAttribute("customers", customers);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/customers.jsp").forward(request, response);
    }
}
