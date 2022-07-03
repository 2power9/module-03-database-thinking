package querySample;


import java.sql.SQLException;

public class QueryDemo {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Transactions trans = new Transactions();
        trans.updateNewAddressesForOffice();
    }
}