//$Id$
package org.sana.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;
import org.sana.tables.PRODUCTS;


public class SQLUtil {

	public static boolean initDB() throws Exception {
		Connection con = null;
		Boolean result = Boolean.FALSE;
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			con = DriverManager.getConnection("jdbc:mysql://aa1gtctnsfsrp6b.cwttjuc3j7hh.ap-south-1.rds.amazonaws.com:3306/sana?characterEncoding=utf8","root","sanacards#2020#");
			//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			result = Boolean.TRUE;
		}catch(Exception e1){
			String message = e1.getMessage();
			if(message!=null && message.startsWith("Unknown database")) {
				try {
				con = DriverManager.getConnection("jdbc:mysql://aa1gtctnsfsrp6b.cwttjuc3j7hh.ap-south-1.rds.amazonaws.com:3306?characterEncoding=utf8","root","sanacards#2020#");
				//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/","root","");
				Statement smt = con.createStatement();
				smt.executeUpdate("create database sana");
				}catch(Exception e) {
					int a = 1;
				}
				result = Boolean.TRUE;
			}
		}finally {
			if(con!=null) {
				con.close();
			}
		}
		return result;
	}
	
	public static boolean loadTable() throws Exception {
		Connection con = null;
		Boolean result = Boolean.FALSE;
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			con = DriverManager.getConnection("jdbc:mysql://aa1gtctnsfsrp6b.cwttjuc3j7hh.ap-south-1.rds.amazonaws.com:3306/sana","root","sanacards#2020#");
			//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			smt.executeUpdate("create table products(ID varchar(50), NAME varchar(50), PRICE FLOAT, IMG_PATH varchar(100), TYPE varchar(25), SUBCATEGORY varchar(30), ORIENTATION varchar(15), DESCRIPTION text, COLOR varchar(25))");
			
			String insertquery = "insert into products values(";
			String[] productsArray = DefaultValues.productArray;
			
			for(String product : productsArray) {
				JSONArray item = new JSONArray(PropertyUtil.getValue(product));
				for(int i=0;i<item.length();i++) {
					JSONObject itemObj = item.getJSONObject(i);
					smt.addBatch(insertquery + "'" + itemObj.get("id")+ "'" +","+  "'" +itemObj.get("name")+ "'" +","+itemObj.get("price")+","+ "'" +itemObj.get("path")+ "'" +","+ "'" +itemObj.get("type")+ "'" +","+ "'" +itemObj.get("subcategory")+ "'" +","+ "'" +itemObj.get("orientation")+ "'" +","+ "'" +itemObj.get("description")+ "'"+", "+ "'" +itemObj.get("color")+ "'" +");");
				}
			}
			smt.executeBatch();
			result = Boolean.TRUE;
		}
		catch(SQLException e) {
			String message = e.getMessage();
			if(message!=null && message.endsWith("already exists")) {
				con = DriverManager.getConnection("jdbc:mysql://aa1gtctnsfsrp6b.cwttjuc3j7hh.ap-south-1.rds.amazonaws.com:3306/sana","root","sanacards#2020#");
				//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
				Statement smt = con.createStatement();
				smt.executeUpdate("drop table products");
				result = Boolean.FALSE;
			}
		}
		catch(Exception e1) {
					
		}
		finally {
			if(con!=null) {
				con.close();
			}
		}
		return result;
	}
	
	public static JSONArray getProductsWithCriteria(String criteria) {
		Connection con = null;
		JSONArray responseArray = new JSONArray();
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			con = DriverManager.getConnection("jdbc:mysql://aa1gtctnsfsrp6b.cwttjuc3j7hh.ap-south-1.rds.amazonaws.com:3306/sana","root","sanacards#2020#");
			//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			ResultSet rs = smt.executeQuery(criteria);
			JSONObject obj = null;
			while(rs.next()) {
				obj = new JSONObject();
				obj.put("id", rs.getString(PRODUCTS.ID));
				obj.put("name", rs.getString(PRODUCTS.NAME));
				obj.put("price", rs.getString(PRODUCTS.PRICE));
				obj.put("path", rs.getString(PRODUCTS.IMG_PATH));
				obj.put("type", rs.getString(PRODUCTS.TYPE));
				obj.put("subcategory", rs.getString(PRODUCTS.SUBCATEGORY));
				obj.put("orientation", rs.getString(PRODUCTS.ORIENTATION));
				obj.put("description", rs.getString(PRODUCTS.DESCRIPTION));
				obj.put("color", rs.getString(PRODUCTS.COLOR));
				responseArray.put(obj);
			}
			rs.close();
		}catch(Exception e) {
			return new JSONArray();
		}finally {
			try {
				if(con!=null) {
					con.close();
				}
			}catch(Exception e) {
				return new JSONArray();
			}
		}
		return responseArray;
	}
	
	public static int getRowsCount(String criteria) {
		Connection con = null;
		int rowsCount = 0;
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			con = DriverManager.getConnection("jdbc:mysql://aa1gtctnsfsrp6b.cwttjuc3j7hh.ap-south-1.rds.amazonaws.com:3306/sana","root","sanacards#2020#");
			//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sana","root","");
			Statement smt = con.createStatement();
			ResultSet rs = smt.executeQuery(criteria);
			rs.next();
			rowsCount = rs.getInt(1);
			rs.close();
		}catch(Exception e) {
			return 0;
		}finally {
			try {
				if(con!=null) {
					con.close();
				}
			}catch(Exception e) {
				return 0;
			}
		}
		return rowsCount;
	}
}
