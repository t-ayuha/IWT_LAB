<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | e-GRAD Portal</title>
    <link rel="stylesheet" href="log.css">
</head>
<body>
<%
    String message = ""; // For success or error messages

    // Handle logout
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("home.html");
        return;
    }

    // Handle login
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/iwt", "root", "Ayusha@12");

            // Prepare SQL query
            String sql = "SELECT * FROM register WHERE email = ?  AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            // Execute the query
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Set session attributes
                session.setAttribute("loggedIn", true);
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("branch", rs.getString("branch"));
                session.setAttribute("age", rs.getString("age"));
                session.setAttribute("gender", rs.getString("gender"));
                session.setAttribute("address", rs.getString("address"));
                session.setAttribute("skills", rs.getString("skills"));

                // Redirect to home.html
                response.sendRedirect("home.html");
                return;
            } else {
                message = "Invalid email or password.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
<div class="login-container">
    <h1>Login</h1>
    <% if (!message.isEmpty()) { %>
    <p style="color: red;"><%= message %></p>
    <% } %>
    <form action="login.jsp" method="POST">
        <label for="email">E-mail:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Login</button>
        <p>Don't have an account? <a href="registration.jsp">Register here</a></p>
    </form>
</div>
</body>
</html>
