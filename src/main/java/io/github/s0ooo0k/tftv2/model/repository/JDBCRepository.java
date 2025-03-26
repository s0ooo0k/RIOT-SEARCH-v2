package io.github.s0ooo0k.tftv2.model.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public interface JDBCRepository {

    // Connection 객체 기반 Statement를 만들고, SQL 실행
    default Connection getConnection(String url, String user, String password) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
}
