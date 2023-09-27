package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    Connection connection;
    
    String driver = "com.mysql.cj.jdbc.Driver";
    String stringConnection = "jdbc:mysql://localhost:3306/adminempresa";
    String user = "root";
    String password = "";

    public Conexion() {
        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(stringConnection, user, password);
            
            if (connection != null){
                System.out.println("conexion establecida");           
            }
            
        } catch (ClassNotFoundException | SQLException e){
            System.out.println("error de conexion");
        }
    }
    
    public Connection getConnection(){
        return connection;
    }
    
}
