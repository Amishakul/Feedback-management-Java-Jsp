<%@ page import="java.sql.*" %>

<html>
<head>
    <title>FeedBack Management System</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }
        .nav {
            background-color: #007bff;
            padding: 10px;
            margin-bottom: 20px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }
        .nav a:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        input[type="email"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        input[type="email"]:focus,
        input[type="submit"]:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px #007bff;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete?");
        }
    </script>
</head>
<body>
<center>
    <div class="nav">
        <a href="home.jsp">Home</a>
        <a href="view.jsp">View Feedbacks</a>
    </div>
    <br><br/>
    <br><br/>
    <br><br/>
    <div class="container">
        <h1>Delete Your Feedback</h1>
        <%
            String un = (String) session.getAttribute("un");
            if (un == null) {
                response.sendRedirect("index.jsp");
            } 
        %>
        <form method="POST">
            <input type="email" name="email" placeholder="Enter your registered email ID" required>
            <br><br>
            <input type="submit" value="Delete" name="btn" onclick="return confirmDelete()">
            <br><br>
        </form>

        <%
            if (request.getParameter("btn") != null) {
                String email = request.getParameter("email");
                
                try {
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/feedback_app";
                    Connection con = DriverManager.getConnection(url, "root", "amishaka");
                    String sql = "DELETE FROM student WHERE email=?";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, email);
                    int r = pst.executeUpdate();

                    out.println(r + " record deleted");
                    con.close();
                } catch (SQLException e) {
                    out.println("SQL issue: " + e);
                }
            }
        %>
    </div>
</center>
</body>
</html>
