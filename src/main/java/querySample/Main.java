package querySample;

import java.sql.*;

public class Main {
    public static void main(String[] args) throws ClassNotFoundException {
        System.out.println("Hello world!");
        String url = "jdbc:mysql://localhost:3306/classicmodels";

        String username = "root";
        String password = "123";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = null;



        try {
            connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();
            String querySample = "SELECT * FROM offices WHERE offices.city = \"Boston\";";
            ResultSet rs = statement.executeQuery(querySample);
            while (rs.next()) {
                System.out.println(rs.getString(1));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}