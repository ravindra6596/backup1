package com.karsanhelthcare.Dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.model.C3P0DataSource;

public class applieddatadao {
	public applieddata getdata() {
		try {
			Connection conn = C3P0DataSource.getInstance().getConnection();
			Statement st = conn.createStatement();
			ResultSet Rs = st.executeQuery(
					"ResultSet rs = con.createStatement().executeQuery(\"select * from other_expenses inner join employee on employee.eid = other_expenses.eid order by mail_status");
			while (Rs.next()) {
				applieddata ad = new applieddata();
				// ad.setName( Rs.getString("name") );

				ad.setName(Rs.getString("name"));
				ad.setAmount(Rs.getString("amount"));
				ad.setMailStatus(Rs.getString("mail_status"));
				ad.setDetail(Rs.getString("details"));
				ad.setUpdated_at(Rs.getString("updated_at"));
				return ad;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

}
//	applieddata ad=new applieddata();
//	 public static String driver = "com.mysql.jdbc.Driver";
//	    public static String url ="jdbc:mysql://karsan-databases.cwqx3twsaxbo.us-east-2.rds.amazonaws.com:3306/karsan_ems";
//	    public static String user = "karsan_admin";
//	    public static String password = "$P$BHr5LH1WY80lnvI49AW8YFwnSIMUf1";
//	    String Query="select * from other_expenses inner join employee on employee.eid = other_expenses.eid order by mail_status";
//    	public applieddata getdatadetail()
//	{
//		try {
//			Class.forName("com.mysql.jdbc.Driver");
//			Connection con=DriverManager.getConnection(url,user,password);
//			Statement st=con.createStatement();
//			   ResultSet set=st.executeQuery(Query);
//			   while(set.next())
//			   {
//				   set.setName("name");
//				   
//				   
//		}
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return null;
//		
//	}	
