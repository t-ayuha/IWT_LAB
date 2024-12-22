<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Quiz Application</title>
    <link rel="stylesheet" type="text/css" href="appli.css">
</head>
<body>
    <div>
        <h2>Online Quiz Test</h2>
        <form method="post">
            <%
                int score = 0;
                int correctCount = 0;
                int wrongCount = 0;	
                Map<Integer, String> userAnswers = new HashMap<>();
                Map<Integer, String> correctAnswers = new HashMap<>();
                boolean isSubmitted = false; // Flag to check if form is submitted

                // Retrieve user answers from the request
                Enumeration<String> parameterNames = request.getParameterNames();
                while (parameterNames.hasMoreElements()) {
                    String paramName = parameterNames.nextElement();
                    if (paramName.startsWith("answer_")) {
                        int questionId = Integer.parseInt(paramName.substring(7));
                        String userAnswer = request.getParameter(paramName);
                        userAnswers.put(questionId, userAnswer);
                    }
                }

                // Check if there are any answers submitted
                if (!userAnswers.isEmpty()) {
                    isSubmitted = true; // Set flag to true if form is submitted
                }

                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/iwt", "root", "Ayusha@12");
                     Statement st = conn.createStatement();
                     ResultSet rs = st.executeQuery("SELECT * FROM question_detail3")) {
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String question = rs.getString("quest");
                        String optionA = rs.getString("QA");
                        String optionB = rs.getString("QB");
                        String optionC = rs.getString("QC");
                        String optionD = rs.getString("QD");
                        String correctAnswer = rs.getString("correctAns");
                        correctAnswers.put(id, correctAnswer);

                        String userAnswer = userAnswers.get(id);
            %>
            <div class="table-container">
                <!-- Question -->
                <div class="question"><b>Question:</b> <%= question %></div>
                <!-- Option A -->
                <div class="option-box <% if (isSubmitted) { if ("QA".equals(correctAnswer)) out.print("correct"); else if ("QA".equals(userAnswer)) out.print("wrong"); } %>">
                    <label>
                        <input type="radio" name="answer_<%= id %>" value="QA" <%= "QA".equals(userAnswer) ? "checked" : "" %> />
                        <%= optionA %>
                    </label>
                </div>
                <!-- Option B -->
                <div class="option-box <% if (isSubmitted) { if ("QB".equals(correctAnswer)) out.print("correct"); else if ("QB".equals(userAnswer)) out.print("wrong"); } %>">
                    <label>
                        <input type="radio" name="answer_<%= id %>" value="QB" <%= "QB".equals(userAnswer) ? "checked" : "" %> />
                        <%= optionB %>
                    </label>
                </div>
                <!-- Option C -->
                <div class="option-box <% if (isSubmitted) { if ("QC".equals(correctAnswer)) out.print("correct"); else if ("QC".equals(userAnswer)) out.print("wrong"); } %>">
                    <label>
                        <input type="radio" name="answer_<%= id %>" value="QC" <%= "QC".equals(userAnswer) ? "checked" : "" %> />
                        <%= optionC %>
                    </label>
                </div>
                <!-- Option D -->
                <div class="option-box <% if (isSubmitted) { if ("QD".equals(correctAnswer)) out.print("correct"); else if ("QD".equals(userAnswer)) out.print("wrong"); } %>">
                    <label>
                        <input type="radio" name="answer_<%= id %>" value="QD" <%= "QD".equals(userAnswer) ? "checked" : "" %> />
                        <%= optionD %>
                    </label>
                </div>
            </div>
            <%
                        // Update counts only after submission
                        if (isSubmitted && userAnswer != null) {
                            if (userAnswer.equals(correctAnswer)) {
                                correctCount++;
                            } else {
                                wrongCount++;
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
            <!-- Submit button -->
            <div class="button-container">
                <button type="submit">Submit Answers</button>
            </div>
        </form>

        <!-- Score Summary -->
        <% if (isSubmitted) { %>
        <h3>Your Score: <%= correctCount %></h3>
        <h3>Correct Answers: <%= correctCount %></h3>
        <h3>Wrong Answers: <%= wrongCount %></h3>
        <% } %>
    </div>
</body>
</html>