//$Id$
package org.sana.util;

import java.util.Map;

import com.google.common.collect.ImmutableMap;

public class DefaultValues {
	public static Map<String, String> priceMap = ImmutableMap.of(
				"0","",
				"1","price < 10",
				"2","price between 10 and 20",
				"3","price between 20 and 30",
				"4","price > 50"
			);
}
