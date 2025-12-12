package com.leo_sac.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    
    private static final String VALID_USERNAME = "admin";
    private static final String VALID_PASSWORD = "1234";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, private, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setDateHeader("Expires", -1);
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (VALID_USERNAME.equals(username) && VALID_PASSWORD.equals(password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario", username);
            
            response.sendRedirect("dashboard.jsp?nocache=" + System.currentTimeMillis());
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, private, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setDateHeader("Expires", -1);
        
        response.sendRedirect("login.jsp");
    }
}