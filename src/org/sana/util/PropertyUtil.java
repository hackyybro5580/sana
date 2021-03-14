//$Id$
package org.sana.util;

import java.util.Properties;

import org.sana.core.PropertyInitializer;

public class PropertyUtil {

	public static String getValue(String key) {
		return PropertyInitializer.getProp().getProperty(key);
	}
}
