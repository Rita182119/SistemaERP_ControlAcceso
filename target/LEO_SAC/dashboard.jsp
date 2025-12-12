<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Configura las cabeceras para control de caché
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Validar sesión
    jakarta.servlet.http.HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String usuario = (String) sesion.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | LEO SAC ERP</title>
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
        
        body {
            background-color: var(--gris-claro);
            color: var(--negro);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Header */
        .header {
            background: var(--blanco);
            border-bottom: 1px solid var(--rosa-suave);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo-icon {
            color: var(--rosa);
            font-size: 28px;
            background: var(--rosa-suave);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .logo-text h1 {
            font-size: 22px;
            font-weight: 700;
            color: var(--negro);
            margin-bottom: 3px;
        }
        
        .logo-text p {
            font-size: 12px;
            color: var(--gris);
            font-weight: 400;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 18px;
            background: var(--rosa-suave);
            border-radius: 50px;
            border: 1px solid rgba(214, 51, 132, 0.1);
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: var(--rosa);
            color: var(--blanco);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 16px;
        }
        
        .user-details {
            display: flex;
            flex-direction: column;
        }
        
        .user-role {
            font-size: 11px;
            color: var(--rosa);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: var(--negro);
        }
        
        .logout-btn {
            background: var(--rosa);
            color: var(--blanco);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            letter-spacing: 0.3px;
        }
        
        .logout-btn:hover {
            background: #c22570;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(214, 51, 132, 0.2);
        }
        
        /* Contenido principal */
        .main-content {
            flex: 1;
            padding: 30px 40px;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        
        /* Dashboard Header */
        .dashboard-header {
            background: var(--blanco);
            border-radius: var(--border-radius);
            padding: 25px 30px;
            box-shadow: var(--shadow);
            border-left: 5px solid var(--rosa);
        }
        
        .dashboard-title {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .dashboard-title i {
            color: var(--rosa);
            font-size: 24px;
        }
        
        .dashboard-title h2 {
            font-size: 24px;
            font-weight: 700;
            color: var(--negro);
        }
        
        .welcome-text {
            color: var(--gris);
            font-size: 15px;
            line-height: 1.6;
            max-width: 800px;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .stat-card {
            background: var(--blanco);
            border-radius: var(--border-radius);
            padding: 25px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: var(--shadow);
            border: 1px solid var(--rosa-suave);
            transition: var(--transition);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(214, 51, 132, 0.1);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            background: var(--rosa-suave);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--rosa);
            font-size: 24px;
        }
        
        .stat-info {
            flex: 1;
        }
        
        .stat-label {
            font-size: 13px;
            color: var(--gris);
            margin-bottom: 5px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--negro);
        }
        
        /* Modules Grid */
        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .module-card {
            background: var(--blanco);
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--shadow);
            border: 1px solid var(--rosa-suave);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .module-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--rosa);
        }
        
        .module-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(214, 51, 132, 0.1);
        }
        
        .module-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .module-icon {
            width: 50px;
            height: 50px;
            background: var(--rosa-suave);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--rosa);
            font-size: 22px;
        }
        
        .module-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--negro);
            margin: 0;
        }
        
        .module-description {
            color: var(--gris);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .module-actions {
            display: flex;
            justify-content: flex-end;
        }
        
        .module-btn {
            background: transparent;
            color: var(--rosa);
            border: 1px solid var(--rosa);
            padding: 8px 20px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .module-btn:hover {
            background: var(--rosa);
            color: var(--blanco);
        }
        
        /* Footer */
        .footer {
            background: var(--blanco);
            border-top: 1px solid var(--rosa-suave);
            padding: 25px 40px;
            text-align: center;
        }
        
        .footer-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }
        
        .footer-text {
            color: var(--gris);
            font-size: 13px;
        }       
        
        @media (max-width: 1024px) {
            .modules-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            }
        }
        
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .user-info {
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .main-content {
                padding: 20px;
            }
            
            .stats-grid,
            .modules-grid {
                grid-template-columns: 1fr;
            }
            
            .footer {
                padding: 20px;
            }
        }
        
        @media (max-width: 480px) {
            .user-profile {
                flex-direction: column;
                text-align: center;
                padding: 15px;
            }
            
            .dashboard-header {
                padding: 20px;
            }
            
            .stat-card {
                flex-direction: column;
                text-align: center;
            }
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }
        
        html {
            scroll-behavior: smooth;
        }
        
        .module-card.active {
            border-color: var(--rosa);
            box-shadow: 0 0 0 3px var(--rosa-suave);
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="logo-text">
                <h1>ERP LEO SAC</h1>
                <p>Sistema de Gestión Empresarial</p>
            </div>
        </div>
        
        <div class="user-info">
            <div class="user-profile">
                <div class="user-avatar">
                    <%= usuario.substring(0, 1).toUpperCase() %>
                </div>
                <div class="user-details">
                    <div class="user-role">Bienvenido</div>
                    <div class="user-name"><%= usuario %></div>
                </div>
            </div>
            
            <a href="LogoutController" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>CERRAR SESIÓN</span>
            </a>
        </div>
    </header>
    
    <main class="main-content">
        <section class="dashboard-header fade-in">
            <div class="dashboard-title">
                <i class="fas fa-tachometer-alt"></i>
                <h2>Panel de Control</h2>
            </div>
            <p class="welcome-text">
                Bienvenido al sistema ERP interno de Comercializadora LEO SAC. 
                Desde este panel podrás gestionar todas las operaciones empresariales de manera eficiente y organizada.
            </p>
            
            <div class="stats-grid">
                <div class="stat-card fade-in" style="animation-delay: 0.1s;">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">Ventas Hoy</div>
                        <div class="stat-value">S/ 15,240</div>
                    </div>
                </div>
                
                <div class="stat-card fade-in" style="animation-delay: 0.2s;">
                    <div class="stat-icon">
                        <i class="fas fa-boxes"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">Productos Stock</div>
                        <div class="stat-value">1,842</div>
                    </div>
                </div>
                
                <div class="stat-card fade-in" style="animation-delay: 0.3s;">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">Clientes Activos</div>
                        <div class="stat-value">156</div>
                    </div>
                </div>
                
                <div class="stat-card fade-in" style="animation-delay: 0.4s;">
                    <div class="stat-icon">
                        <i class="fas fa-file-invoice-dollar"></i>
                    </div>
                    <div class="stat-info">
                        <div class="stat-label">Órdenes Pendientes</div>
                        <div class="stat-value">23</div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="modules-section">
            <div class="modules-grid">
                <div class="module-card fade-in" style="animation-delay: 0.2s;">
                    <div class="module-header">
                        <div class="module-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h3 class="module-title">Ventas</h3>
                    </div>
                    <p class="module-description">
                        Gestión completa de ventas, facturación electrónica, control de pedidos y seguimiento comercial.
                    </p>
                    <div class="module-actions">
                        <a href="#" class="module-btn">
                            <i class="fas fa-arrow-right"></i>
                            <span>Acceder</span>
                        </a>
                    </div>
                </div>
                
                <div class="module-card fade-in" style="animation-delay: 0.3s;">
                    <div class="module-header">
                        <div class="module-icon">
                            <i class="fas fa-warehouse"></i>
                        </div>
                        <h3 class="module-title">Inventario</h3>
                    </div>
                    <p class="module-description">
                        Control de stock, suministros empresariales, gestión de almacén y logística de productos.
                    </p>
                    <div class="module-actions">
                        <a href="#" class="module-btn">
                            <i class="fas fa-arrow-right"></i>
                            <span>Acceder</span>
                        </a>
                    </div>
                </div>
                
                <div class="module-card fade-in" style="animation-delay: 0.4s;">
                    <div class="module-header">
                        <div class="module-icon">
                            <i class="fas fa-user-friends"></i>
                        </div>
                        <h3 class="module-title">Clientes</h3>
                    </div>
                    <p class="module-description">
                        Administración de clientes, contactos, relaciones comerciales y servicio al cliente.
                    </p>
                    <div class="module-actions">
                        <a href="#" class="module-btn">
                            <i class="fas fa-arrow-right"></i>
                            <span>Acceder</span>
                        </a>
                    </div>
                </div>
                
                <div class="module-card fade-in" style="animation-delay: 0.5s;">
                    <div class="module-header">
                        <div class="module-icon">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <h3 class="module-title">Reportes</h3>
                    </div>
                    <p class="module-description">
                        Reportes financieros, estadísticas, análisis de rendimiento y métricas empresariales.
                    </p>
                    <div class="module-actions">
                        <a href="#" class="module-btn">
                            <i class="fas fa-arrow-right"></i>
                            <span>Acceder</span>
                        </a>
                    </div>
                </div>
                
                <div class="module-card fade-in" style="animation-delay: 0.6s;">
                    <div class="module-header">
                        <div class="module-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <h3 class="module-title">Logística</h3>
                    </div>
                    <p class="module-description">
                        Gestión de envíos, distribución, control de transportes y cadena de suministro.
                    </p>
                    <div class="module-actions">
                        <a href="#" class="module-btn">
                            <i class="fas fa-arrow-right"></i>
                            <span>Acceder</span>
                        </a>
                    </div>
                </div>
                
                <div class="module-card fade-in" style="animation-delay: 0.7s;">
                    <div class="module-header">
                        <div class="module-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <h3 class="module-title">Configuración</h3>
                    </div>
                    <p class="module-description">
                        Ajustes del sistema, usuarios, parámetros empresariales y personalización.
                    </p>
                    <div class="module-actions">
                        <a href="#" class="module-btn">
                            <i class="fas fa-arrow-right"></i>
                            <span>Acceder</span>
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <p class="footer-text">© 2025 CIBERTEC - Sistema ERP Comercializadora LEO SAC</p>
        </div>
    </footer>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.fade-in');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
        });
        
        document.querySelectorAll('.module-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.classList.add('active');
            });
            
            card.addEventListener('mouseleave', function() {
                this.classList.remove('active');
            });
        });
        
        document.querySelectorAll('.stat-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                const icon = this.querySelector('.stat-icon');
                icon.style.transform = 'scale(1.1)';
                icon.style.background = 'var(--rosa)';
                icon.style.color = 'var(--blanco)';
            });
            
            card.addEventListener('mouseleave', function() {
                const icon = this.querySelector('.stat-icon');
                icon.style.transform = 'scale(1)';
                icon.style.background = 'var(--rosa-suave)';
                icon.style.color = 'var(--rosa)';
            });
        });
        
        const userName = '<%= usuario %>';
        const avatar = document.querySelector('.user-avatar');
        if (avatar && userName) {
            const initial = userName.substring(0, 1).toUpperCase();
            avatar.textContent = initial;
            
            const colors = ['#d63384', '#6f42c1', '#0d6efd', '#198754', '#fd7e14'];
            const colorIndex = initial.charCodeAt(0) % colors.length;
            avatar.style.background = colors[colorIndex];
        }
        
        function updateDateTime() {
            const now = new Date();
            const options = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            const dateTimeString = now.toLocaleDateString('es-ES', options);

        }
        
        updateDateTime();
        setInterval(updateDateTime, 60000);
    </script>
</body>
</html>