package querySample;

import java.sql.*;
import java.util.Objects;
import java.util.Scanner;

public class Transactions {
    private Scanner sc;
    private Connection connection;
    private String username;
    private String password;
    private String url;

    public Transactions() throws ClassNotFoundException {
        sc = new Scanner(System.in);
        username = "root";
        password = "123";
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = null;
        url = "jdbc:mysql://localhost:3306/classicmodels";

    }
    public void updateNewAddressesForOffice() throws SQLException {

        System.out.print("Target city: ");
        String targetCity = sc.nextLine();

        System.out.print("Type new address line 1: ");
        String newAddressLine1 = sc.nextLine();

        System.out.print("Type new address line 2: ");
        String newAddressLine2 = sc.nextLine();



        String queryCity = "SELECT * FROM offices WHERE city = \"" + targetCity + "\";";

        try {
            connection = DriverManager.getConnection(url, username, password);
            connection.setAutoCommit(false);
            Statement statement = connection.createStatement();
            ResultSet resultSet;

            resultSet = statement.executeQuery(queryCity);
            while (resultSet.next()) {
                System.out.println("Old address line 1: " + resultSet.getString("addressLine1"));
                System.out.println("Old address line 2: " + resultSet.getString("addressLine2"));

            }

            String updateNewAddresses = String.format("""
                    UPDATE offices
                    SET
                        addressLine1 = "%s",
                        addressLine2 = "%s"
                    WHERE
                        city = "%s";""", newAddressLine1, newAddressLine2, targetCity);

            statement.execute(updateNewAddresses);

            connection.commit();

            System.out.println("New addresses were updated.");


            resultSet = statement.executeQuery(queryCity);
            while (resultSet.next()) {
                System.out.println("New address line 1: " + resultSet.getString("addressLine1"));
                System.out.println("New address line 2: " + resultSet.getString("addressLine2"));

            }
        } catch (SQLException e) {
            Objects.requireNonNull(connection).rollback();
            throw new RuntimeException(e);
        }
    }
}