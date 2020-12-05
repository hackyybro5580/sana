//$Id$
package org.sana.core;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.sana.util.SQLUtil;

public class PropertyInitializer implements ServletContextListener{
	public static Properties prop;
	public static Properties getProp() {
		return prop;
	}

	public void contextInitialized(ServletContextEvent e) {
		try {
			ServletContext context = e.getServletContext();
			if(prop==null) {
				prop = readPropertiesFile(context.getRealPath("DBValue.properties"));
			}
			
			if(SQLUtil.initDB()) {
				if(!SQLUtil.loadTable()) {
					SQLUtil.loadTable();
				}
			}
		}catch(Exception e1) {
			
		}	
	 }
	 
	 public Properties readPropertiesFile(String fileName) throws Exception{
	      FileInputStream fis = null;
	      Properties prop = null;
	      try {
	         fis = new FileInputStream(fileName);
	         prop = new Properties();
	         prop.load(fis);
	      }catch(Exception e) {
	    	  
	      }
	      finally {
	         fis.close();
	      }
	      return prop;
	   }
	 public void contextDestroyed(ServletContextEvent e) {

	 }  
}
