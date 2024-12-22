<%@ page import="java.io.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link rel="stylesheet" href="navbar.css">
     <link rel="stylesheet" href="registration.css">
    <script src="registration.js" defer></script>
</head>
<body>
   <!--   <div class="header">
        <div class="logo">
            <a href="home.html">
                <img src="https://media.istockphoto.com/id/912373688/photo/graduation-day-back-view-of-asian-woman-with-graduation-cap-and-gown-holding-diploma.jpg?s=2048x2048&w=is&k=20&c=ouJTNUrxLdYPEBceOLm5PyNfEIl2GMTxMyezkQMqaOI=" alt="Graduation Cap and Diploma">
            </a>
        </div>
        <ul class="navbar">
            <li><a href="eexam.html">e-Exam</a></li>
            <li><a href="openforum.html">Openforum</a></li>
            <li><a href="eRepository.html">e-Repository</a></li>
            <li><a href="myWall.html">MyWall</a></li>
            <li><a href="login.html">Login/Register</a></li>
        </ul>
        <div class="search-box">
            <input type="text" placeholder="Search...">
        </div>
    </div>-->
    <h1 style="text-align: center;">Registration Form</h1>
    <%
        String message = "";
        if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                String name = request.getParameter("name");
                String id = request.getParameter("id");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String age = request.getParameter("age");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                String branch = request.getParameter("branch");
                String[] skills = request.getParameterValues("skills");
      

                String skillSet = skills != null ? String.join(", ", skills) : "";

                // Database Connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/iwt", "root", "Ayusha@12");
                PreparedStatement pst = conn.prepareStatement("INSERT INTO register(name, id, password, email, age, gender, address, branch, skills) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                pst.setString(1, name);
                pst.setString(2, id);
                pst.setString(3, password);
                pst.setString(4, email);
                pst.setString(5, age);
                pst.setString(6, gender);
                pst.setString(7, address);
                pst.setString(8, branch);
                pst.setString(9, skillSet);

                // Save the uploaded resume
                //if (resume != null && fileName != null && !fileName.isEmpty()) {
                  //  String uploadPath = application.getRealPath("") + "uploads" + File.separator + fileName;
                    //File fileSaveDir = new File(uploadPath);
                //    resume.write(uploadPath);
                //    pst.setString(10, fileName);
                //} else {
                //   pst.setString(10, null);
                //}

                int row = pst.executeUpdate();
                if (row > 0) {
                    message = "Registration successful!";
                    response.sendRedirect("login.jsp"); 
                    return;
                } else {
                    message = "Registration failed. Please try again.";
                }
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        }
    %>
    <form method="post"	>
        <table border="1" cellpadding="10" cellspacing="0" style="margin: 0 auto;">
            <tr>
                <td><label for="name">Name:</label></td>
                <td><input type="text" id="name" name="name" required></td>
            </tr>
            <tr>
                <td><label for="id">ID:</label></td>
                <td><input type="text" id="id" name="id" required></td>
            </tr>
            <tr>
                <td><label for="password">Password:</label></td>
                <td><input type="password" id="password" name="password" required></td>
            </tr>
            <tr>
                <td><label for="email">E-Mail ID:</label></td>
                <td><input type="email" id="email" name="email" required></td>
            </tr>
            <tr>
                <td><label for="age">Age:</label></td>
                <td><input type="number" id="age" name="age" required></td>
            </tr>
            <tr>
                <td>Gender:</td>
                <td>
                    <input type="radio" id="male" name="gender" value="male">
                    <label for="male">Male</label><br>
                    <input type="radio" id="female" name="gender" value="female">
                    <label for="female">Female</label><br>
                    <input type="radio" id="other" name="gender" value="other">
                    <label for="other">Other</label>
                </td>
            </tr>
            <tr>
                <td><label for="address">College Address:</label></td>
                <td><textarea id="address" name="address" rows="4" cols="30" required></textarea></td>
            </tr>
            <tr>
                <td><label for="branch">Branch:</label></td>
                <td>
                    <select id="branch" name="branch" required>
                        <option value="cs">Computer Science & Engineering</option>
                        <option value="it">Computer Science & Technology</option>
                        <option value="ee">Electrical & Electronics Engineering</option>
                        <option value="ece">Electronics & Communication Engineering</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Technical Skills:</td>
                <td>
                    <input type="checkbox" id="c" name="skills" value="c">
                    <label for="c">C</label><br>
                    <input type="checkbox" id="java" name="skills" value="java">
                    <label for="java">Java</label><br>
                    <input type="checkbox" id="python" name="skills" value="python">
                    <label for="python">Python</label><br>
                    <input type="checkbox" id="jsp" name="skills" value="jsp">
                    <label for="jsp">JSP</label>
                </td>
            </tr>
            <!--  <tr>
                <td><label for="resume">Resume Upload:</label></td>
                <td><input type="file" id="resume" name="resume" required></td>
            </tr>
            -->
            <tr>
                <td colspan="2" style="text-align: center;">
                    <input type="submit" value="Submit">
                    <input type="reset" value="Reset">
                </td>
            </tr>
        </table>
    </form>
    <% if (!message.isEmpty()) { %>
    <div style="text-align: center; color: green;">
        <h3><%= message %></h3>
    </div>
    <% } %>
    <div class="footer">
        <ul>
            <li><a href="#">About Us</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="#">Address</a></li>
        </ul>
    </div>
</body>
</html>
