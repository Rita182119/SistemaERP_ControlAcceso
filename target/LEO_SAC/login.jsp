<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, private, max-age=0, proxy-revalidate, s-maxage=0");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    response.setDateHeader("Expires", -1);
    response.setHeader("X-Content-Type-Options", "nosniff");
    
    jakarta.servlet.http.HttpSession sesion = request.getSession(false);
    if (sesion != null && sesion.getAttribute("usuario") != null) {
        response.sendRedirect("dashboard.jsp?nocache=" + System.currentTimeMillis());
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Acceso | LEO SAC ERP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }
        
        :root {
            --rosa: #d63384;
            --rosa-claro: #ff7eb6;
            --rosa-suave: #ffe4ec;
            --negro: #121212;
            --negro-claro: #1e1e1e;
            --blanco: #ffffff;
            --gris: #6c757d;
            --gris-claro: #f8f9fa;
            --border-radius: 12px;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }
        
        html, body {
            height: 100%;
            overflow: hidden;
        }
        
        body {
            background-color: var(--gris-claro);
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--negro);
        }
        
        .login-container {
            background: var(--blanco);
            border-radius: var(--border-radius);
            width: 450px;
            padding: 40px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            border: 1px solid var(--rosa-suave);
        }
        
        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--rosa);
        }
        
        .logo {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .logo-icon {
            color: var(--rosa);
            font-size: 42px;
            background: var(--rosa-suave);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border: 2px solid rgba(214, 51, 132, 0.2);
        }
        
        .logo h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--negro);
            letter-spacing: -0.5px;
            margin-bottom: 8px;
        }
        
        .logo p {
            font-size: 14px;
            color: var(--gris);
            font-weight: 400;
        }
        
        .error-message {
            background: var(--rosa-suave);
            border: 1px solid var(--rosa);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .error-message i {
            color: var(--rosa);
            font-size: 18px;
            flex-shrink: 0;
        }
        
        .error-message span {
            font-size: 14px;
            color: var(--negro);
            font-weight: 500;
        }
        
        .form-group {
            margin-bottom: 24px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--negro);
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label i {
            color: var(--rosa);
            font-size: 14px;
        }
        
        .input-container {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--rosa);
            font-size: 18px;
            pointer-events: none;
            transition: var(--transition);
            z-index: 2;
        }
        
        .input-field {
            width: 100%;
            padding: 16px 20px 16px 50px;
            background: var(--blanco);
            border: 2px solid var(--rosa-suave);
            border-radius: 8px;
            font-size: 15px;
            color: var(--negro);
            transition: var(--transition);
            outline: none;
            position: relative;
            z-index: 1;
        }
        
        .input-field:focus {
            border-color: var(--rosa);
            box-shadow: 0 0 0 3px rgba(214, 51, 132, 0.1);
        }
        
        .input-field:focus + .input-icon {
            color: var(--rosa-claro);
            transform: translateY(-50%) scale(1.1);
        }
        
        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--rosa);
            cursor: pointer;
            font-size: 16px;
            padding: 0;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            z-index: 2;
        }
        
        .password-toggle:hover {
            color: var(--rosa-claro);
        }
        
        .btn-submit {
            width: 100%;
            padding: 17px;
            background: var(--rosa);
            color: var(--blanco);
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }
        
        .btn-submit:hover {
            background: #c22570;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(214, 51, 132, 0.2);
        }
        
        .btn-submit:active {
            transform: translateY(0);
        }
        
        .demo-section {
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--rosa-suave);
        }
        
        .demo-title {
            font-size: 13px;
            color: var(--rosa);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
        }
        
        .demo-title i {
            color: var(--rosa);
            font-size: 14px;
        }
        
        .demo-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        
        .demo-item {
            background: var(--rosa-suave);
            border: 1px solid rgba(214, 51, 132, 0.2);
            border-radius: 8px;
            padding: 12px;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .demo-item:hover {
            background: rgba(214, 51, 132, 0.1);
            border-color: var(--rosa);
        }
        
        .demo-label {
            font-size: 11px;
            color: var(--rosa);
            margin-bottom: 5px;
            display: block;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 600;
        }
        
        .demo-value {
            font-size: 13px;
            color: var(--negro);
            font-weight: 600;
            font-family: 'Consolas', 'Monaco', monospace;
        }
        
        .footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--rosa-suave);
            color: var(--gris);
            font-size: 12px;
            line-height: 1.6;
        }
        
        .tech-stack {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 10px;
            font-size: 11px;
        }
        
        .tech-item {
            color: var(--rosa);
            font-weight: 500;
        }
        
        .input-field.error {
            border-color: #dc3545;
            animation: shake 0.3s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-3px); }
            75% { transform: translateX(3px); }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 20px;
            }
            
            .login-container {
                width: 100%;
                padding: 30px 25px;
            }
            
            .demo-grid {
                grid-template-columns: 1fr;
            }
        }
        
        body, html {
            overscroll-behavior: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-shield-alt"></i>
            </div>
            <h1>LEO SAC ERP</h1>
            <p>Sistema de Control de Acceso</p>
        </div>
        
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null && !error.isEmpty()) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= error %></span>
            </div>
        <% } %>
        
        <form action="LoginController" method="POST" id="loginForm">
            <div class="form-group">
                <label class="form-label" for="username">
                    <i class="fas fa-user"></i>
                    <span>Usuario</span>
                </label>
                <div class="input-container">
                    <input type="text" 
                           id="username" 
                           name="username" 
                           class="input-field <%= error != null ? "error" : "" %>"
                           placeholder="admin"
                           required
                           autofocus
                           autocomplete="off">
                    <div class="input-icon">
                        <i class="fas fa-user-circle"></i>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="password">
                    <i class="fas fa-key"></i>
                    <span>Contraseña</span>
                </label>
                <div class="input-container">
                    <input type="password" 
                           id="password" 
                           name="password" 
                           class="input-field <%= error != null ? "error" : "" %>"
                           placeholder="••••••••"
                           required
                           autocomplete="off">
                    <div class="input-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <button type="button" class="password-toggle">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>
            
            <button type="submit" class="btn-submit">
                <i class="fas fa-sign-in-alt"></i>
                <span>ACCEDER AL SISTEMA</span>
            </button>
        </form>
    </div>
    
    <script>
        (function() {
            if (window.location.search.includes('logout=true')) {
                if (window.history && window.history.replaceState) {
                    window.history.replaceState(null, null, window.location.pathname);
                }
            }
            
            window.onpageshow = function(event) {
                if (event.persisted) {
                    window.location.reload();
                }
            };
            
            const passwordToggle = document.querySelector('.password-toggle');
            const passwordInput = document.getElementById('password');
            
            if (passwordToggle) {
                passwordToggle.addEventListener('click', function() {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    
                    const icon = this.querySelector('i');
                    icon.classList.toggle('fa-eye');
                    icon.classList.toggle('fa-eye-slash');
                    
                    if (type === 'text') {
                        this.style.color = 'var(--rosa-claro)';
                    } else {
                        this.style.color = 'var(--rosa)';
                    }
                });
            }
            
            <% if (error != null && !error.isEmpty()) { %>
                document.addEventListener('DOMContentLoaded', function() {
                    if (passwordInput) {
                        passwordInput.value = '';
                        passwordInput.focus();
                    }
                    
                    document.querySelectorAll('.input-field').forEach(input => {
                        input.addEventListener('input', function() {
                            if (this.classList.contains('error')) {
                                this.classList.remove('error');
                            }
                        });
                    });
                });
            <% } %>
            
            document.addEventListener('wheel', function(e) {
                if (e.target === document.body || e.target === document.documentElement) {
                    e.preventDefault();
                }
            }, { passive: false });
            
            document.querySelectorAll('.input-field').forEach(input => {
                const icon = input.parentElement.querySelector('.input-icon i');
                
                input.addEventListener('focus', function() {
                    if (icon) icon.style.color = 'var(--rosa-claro)';
                });
                
                input.addEventListener('blur', function() {
                    if (!this.value && icon) {
                        icon.style.color = 'var(--rosa)';
                    }
                });
            });
            
            const submitBtn = document.querySelector('.btn-submit');
            if (submitBtn) {
                submitBtn.addEventListener('mouseenter', function() {
                    this.style.background = '#c22570';
                });
                
                submitBtn.addEventListener('mouseleave', function() {
                    this.style.background = 'var(--rosa)';
                });
            }
            
            document.querySelectorAll('.demo-item').forEach(item => {
                item.addEventListener('click', function() {
                    this.style.transform = 'translateY(-2px) scale(0.98)';
                    setTimeout(() => {
                        this.style.transform = 'translateY(-2px) scale(1)';
                    }, 150);
                });
            });
            
            const loginForm = document.getElementById('loginForm');
            if (loginForm) {
                loginForm.addEventListener('submit', function() {
                    const submitBtn = this.querySelector('.btn-submit');
                    if (submitBtn) {
                        submitBtn.disabled = true;
                        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>PROCESANDO...</span>';
                    }
                });
            }
        })();
    </script>
</body>
</html>