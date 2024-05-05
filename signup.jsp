<%@ page import="java.sql.*" %>

<html>
<head>
    <title>FeedBack Management System</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            text-align: center;
        }
        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        a {
            display: block;
            text-align: center;
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <br><br/>
    <br><br/>
    <div class="container">
        <h1>SignUp Page</h1>
        <a href="index.jsp">Already Registered</a>
        <br><br>
        <form method="POST">
            <input type="text" name="un" placeholder="Enter username" required pattern="^[A-Za-z]+$">
            <br><br>
            <input type="password" name="pw1" placeholder="Enter password" required>
            <br><br>
            <input type="password" name="pw2" placeholder="Confirm password" required>
            <br><br>
            <input type="submit" value="Sign Up" name="btn">
            <br><br>
        </form>

        <% 
        if (request.getParameter("btn") != null) { 
            String un = request.getParameter("un").trim();  // Trim the username

            if (un.length() == 0) {
                out.println("You did not enter a name");
            } else if (un.length() < 2) {
                out.println("Name should be a minimum of 2 characters");
            } else if (!un.matches("[A-Za-z]+")) {
                out.println("Name should contain only alphabets");
            } else {
                String pw1 = request.getParameter("pw1");
                String pw2 = request.getParameter("pw2");

                if (!pw1.equals(pw2)) {
                    out.println("Passwords did not match");
                    return;
                }
                try {
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/feedback_app";
                    Connection con = DriverManager.getConnection(url, "root", "amishaka");
                    String sql = "INSERT INTO user VALUES (?, ?)";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, un);
                    pst.setString(2, pw1);
                    pst.executeUpdate();
                    response.sendRedirect("index.jsp");
                    con.close();
                } catch(SQLException e) {
                    out.println("SQL issue: " + e);
                }
            }
        }
        %>
    </div>
</body>
</html>
