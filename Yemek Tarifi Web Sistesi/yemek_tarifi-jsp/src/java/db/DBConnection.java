package db;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Sedat
 */

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() throws Exception {

        Class.forName("org.postgresql.Driver");

        String url = "jdbc:postgresql://localhost:5432/yemek_tarifi";
        String username = "postgres";
        String password = "54391015";

        return DriverManager.getConnection(url, username, password);
    }
        
}
