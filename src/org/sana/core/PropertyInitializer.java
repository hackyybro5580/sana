//$Id$
package org.sana.core;

import java.io.FileInputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.sana.util.SQLUtil;

public class PropertyInitializer implements ServletContextListener {
	private final static Logger LOGGER = Logger.getLogger(PropertyInitializer.class.getName());

	public static Properties prop;

	public static Properties getProp() {
		return prop;
	}

	public void contextInitialized(ServletContextEvent e) {
		try {
			ServletContext context = e.getServletContext();
			if (prop == null) {
				prop = readPropertiesFile(context.getRealPath("DBValue.properties"));
			}

			if (SQLUtil.initDB()) {
				if (!SQLUtil.loadTable()) {
					SQLUtil.loadTable();
				}
			}
		} catch (Exception e1) {
			LOGGER.log(Level.SEVERE, "Exception in contextInitialized method!", e);
		}
	}

	public Properties readPropertiesFile(String fileName) throws Exception {
		FileInputStream fis = null;
		Properties prop = null;
		try {
			fis = new FileInputStream(fileName);
			prop = new Properties();
			prop.load(fis);
		} catch (Exception e) {
			LOGGER.log(Level.SEVERE, "Exception in readPropertiesFile method!", e);
		} finally {
			fis.close();
		}
		return prop;
	}

	public void contextDestroyed(ServletContextEvent e) {

	}
}