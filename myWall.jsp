<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Database connection settings
    String jdbcURL = "jdbc:mysql://localhost:3306/iwt";
    String dbUser = "root";
    String dbPassword = "Ayusha@12";

    // Retrieving session data for the logged-in user
    String userEmail = (String) session.getAttribute("email");

    // Redirect to login if email is not present in session
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Declare variables to store user data
    String userId = null;
    String userName = null;
    String userAge = null;
    String userGender = null;
    String userAddress = null;
    String userBranch = null;
    String userSkills = null;

    // Fetch user details from the database
    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Query to retrieve user data
        String query = "SELECT * FROM register WHERE email = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, userEmail);
        ResultSet resultSet = preparedStatement.executeQuery();

        // Extract user data
        if (resultSet.next()) {
            userId = resultSet.getString("id");
            userName = resultSet.getString("name");
            userAge = resultSet.getString("age");
            userGender = resultSet.getString("gender");
            userAddress = resultSet.getString("address");
            userBranch = resultSet.getString("branch");
            userSkills = resultSet.getString("skills");
        } else {
            // If no user is found, redirect to login
            response.sendRedirect("login.jsp?error=not_found");
            return;
        }

        // Close resources
        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp"); // Redirect to an error page in case of issues
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="stylesheet" href="myWall.css">
    <link rel="stylesheet" href="navbar.css">
</head>
<body>
<!-- Header Section -->
    <div class="header">
        <div class="logo">
<a href="home.html">
            <img src="https://media.istockphoto.com/id/912373688/photo/graduation-day-back-view-of-asian-woman-with-graduation-cap-and-gown-holding-diploma.jpg?s=2048x2048&w=is&k=20&c=ouJTNUrxLdYPEBceOLm5PyNfEIl2GMTxMyezkQMqaOI=" alt="Graduation Cap and Diploma">
        </a>        </div>
        <ul class="navbar">
            <li><a href="eexam.html">e-Exam</a></li>
            <li><a href="openforum.html">Openforum</a></li>
            <li><a href="eRepository.html">e-Repository</a></li>
            <li><a href="myWall.jsp">MyWall</a></li>
            <li><a href="login.jsp">Log-out</a></li>
        </ul>
        <div class="search-box">
            <input type="text" placeholder="Search...">
        </div>
    </div>
    <div class="container">
        
        <div class="profile-container">
            <!-- User Card -->
            <div class="user-card">
            <h2>My Profile</h2>

        <!-- Back Button -->
        <div class="back-button">
            <button><a href="login.jsp" class="back-link">Back to Login</a></button>
        </div>
            
                <h3 class="user-name"><%= userName %></h3>
                <p class="user-role"><strong>Technical Skills:</strong> <%= userSkills %></p>
                <p><strong>Age:</strong> <%= userAge %></p>
            </div>

            <!-- Profile Details -->
            <div class="profile-details">
                <h2>Profile Details</h2>
                <p><strong>Id:</strong> <%= userId %></p>
                <p><strong>Email:</strong> <%= userEmail %></p>
                <p><strong>Branch:</strong> <%= userBranch %></p>
                <p><strong>Gender:</strong> <%= userGender %></p>
                <p><strong>Address:</strong> <%= userAddress %></p>

                
            </div>
            
        </div>
        <div class="footer">
                    <p>Thank you for visiting your profile.</p>
                </div>
    </div>
</body>
</html>
