<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/includes/head.jsp"%>
    <title>E-Commerce Cart</title>

    <!-- ✅ Spline Viewer Script -->
    <script type="module" src="https://unpkg.com/@splinetool/viewer@1.9.82/build/spline-viewer.js"></script>

    <!-- ✅ Styling -->
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background-color: white; /* ✅ Back to white or your theme base */
            font-family: Arial, sans-serif;
        }

        /* ✅ Original Navbar Style (remove transparency) */
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background-color: white !important; /* ✅ Match your original navbar background */
            border-bottom: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .spline-container {
            height: calc(100vh - 70px);
            width: 100%;
            margin-top: 70px;
            position: relative;
            box-sizing: border-box;
            overflow: hidden;
        }

        spline-viewer {
            width: 100%;
            height: 100%;
            display: block;
            transform: scale(1.4);
            transform-origin: center center;
        }

        .welcome-text {
            position: absolute;
            top: 45%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            text-align: center;
            z-index: 10;
        }

        .welcome-text h1 {
            font-size: 48px;
            font-weight: bold;
            text-shadow: 2px 2px 5px rgba(0,0,0,0.7);
        }
    </style>
</head>
<body>

    <!-- ✅ Navbar -->
    <%@include file="/includes/navbar.jsp"%>

    <!-- ✅ Spline Scene with Welcome Text -->
    <div class="spline-container">
        <div class="welcome-text">
        </div>
        <spline-viewer url="https://prod.spline.design/NpjC2gKmrj1pVdqt/scene.splinecode"></spline-viewer>
    </div>

    <!-- ✅ Footer -->
    <%@include file="/includes/footer.jsp"%>

    <!-- ✅ Hide Spline Logo and UI Elements -->
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            const hideSplineBadge = () => {
                const spline = document.querySelector('spline-viewer');
                if (spline && spline.shadowRoot) {
                    const logo = spline.shadowRoot.querySelector('a[href*="spline.design"]');
                    const menu = spline.shadowRoot.querySelector('.menu');
                    if (logo) logo.style.display = 'none';
                    if (menu) menu.style.display = 'none';
                    return true;
                }
                return false;
            };

            const interval = setInterval(() => {
                if (hideSplineBadge()) clearInterval(interval);
            }, 100);
        });
    </script>

</body>
</html>