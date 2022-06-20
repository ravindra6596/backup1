package com.model;
import java.beans.PropertyVetoException;
import java.sql.*;
import com.mchange.v2.c3p0.*;

public class C3P0DataSource {
   private static C3P0DataSource dataSource;
   private ComboPooledDataSource comboPooledDataSource;

   private C3P0DataSource() {
      try {
         comboPooledDataSource = new ComboPooledDataSource();
         comboPooledDataSource.setDriverClass("com.mysql.jdbc.Driver");
         comboPooledDataSource.setJdbcUrl("jdbc:mysql://204.11.59.195:3306/sushaabq_navodian");
         comboPooledDataSource.setUser("sushaabq_navodia");
         comboPooledDataSource.setPassword("7-R94Kn]k9Rt");
         comboPooledDataSource.setIdleConnectionTestPeriod(100);
         comboPooledDataSource.setMaxIdleTime(100);
         comboPooledDataSource.setUnreturnedConnectionTimeout(180);
      }
      catch (PropertyVetoException ex1) {
         ex1.printStackTrace();
      }
   }

   public static C3P0DataSource getInstance() {
      if (dataSource == null)
         dataSource = new C3P0DataSource();
      return dataSource;
   }

   public Connection getConnection() {
      Connection con = null;
      try {
         con = comboPooledDataSource.getConnection();
      } catch (SQLException e) {
         e.printStackTrace();
      }
      return con;
   }
}