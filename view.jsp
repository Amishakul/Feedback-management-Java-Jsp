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
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
<center>
    <div class="nav">
        <a href="home.jsp">Home</a>
        <a href="delete.jsp">Delete your feedback</a>
    </div>
    <br><br/>
    <h1>View Feedbacks from our Students</h1>
    <%
        String un = (String) session.getAttribute("un");
        if (un == null) {
            response.sendRedirect("index.jsp");
        } 
    %>
    <table border="5">
        <tr>
            <th>Name</th>
            <th>Ratings</th>
            <th>Query/Feedbacks</th>
        </tr>

        <%
            try {
                DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                String url = "jdbc:mysql://localhost:3306/feedback_app";
                Connection con = DriverManager.getConnection(url, "root", "amishaka");
                String sql = "SELECT name, feedback, query FROM student";
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getString(1) %></td>
                        <td><%= rs.getString(2) %></td>
                        <td><%= rs.getString(3) %></td>
                    </tr>
        <%
                }
                con.close();
            } catch (SQLException e) {
                out.println("SQL issue " + e);
            }
        %>
    </table>
</center>
</body>
</html>
