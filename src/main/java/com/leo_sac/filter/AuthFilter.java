package com.leo_sac.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, 
            FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);
        
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        boolean isJspPage = path.endsWith(".jsp");
        boolean isLoginPage = path.equals("/login.jsp");
        boolean isLoginController = path.equals("/LoginController");
        boolean isLogoutController = path.equals("/LogoutController");
        
        boolean loggedIn = (session != null && session.getAttribute("usuario") != null);
        
        if ((isLoginPage || isLoginController) && loggedIn && !isLogoutController) {
            httpResponse.sendRedirect(contextPath + "/dashboard.jsp");
            return;
        }
        
        if (!loggedIn && isJspPage && !isLoginPage) {
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        if (path.equals("/") || path.equals("/index.html")) {
            if (loggedIn) {
                httpResponse.sendRedirect(contextPath + "/dashboard.jsp");
            } else {
                httpResponse.sendRedirect(contextPath + "/login.jsp");
            }
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
}