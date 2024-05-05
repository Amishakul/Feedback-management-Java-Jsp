<%@ page import="java.sql.*" %>

<html>
<head>
    <title> FeedBack Management System </title>
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
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        a {
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
        <h1>Login Page</h1>
        <br><br>
        <form method="POST">
            <input type="text" name="un" placeholder="Enter username" required pattern="^[A-Za-z ]+$">
            <br><br>
            <input type="password" name="pw" placeholder="Enter password" required>
            <br><br>
            <input type="submit" value="Login" name="btn">
            <br><br>
        </form>

        <% 
        if (request.getParameter("btn") != null) {
            String un = request.getParameter("un");
            String pw = request.getParameter("pw");
            try {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                String url = "jdbc:mysql://localhost:3306/feedback_app";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");
                String sql = "select * from user where un = ? and pw = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, un);
                pst.setString(2, pw);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    session.setAttribute("un", un);
                    response.sendRedirect("home.jsp");
                } else {
                    out.println("Invalid login");
                }
                con.close();
            } catch(SQLException e ) {
                out.println("SQL issue " + e);
            }
        }
        %>
        <br><br>
        <a href="signup.jsp">New Users Click Here</a>
    </div>
</body>
</html>
