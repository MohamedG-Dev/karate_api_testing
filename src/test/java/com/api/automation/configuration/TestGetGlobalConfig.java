package com.api.automation.configuration;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestGetGlobalConfig {

	@Test
	public Karate runTest() {
		return Karate.run("getGlobalConfig","get_RequestDemo","postRequest").relativeTo(getClass());
	}
}
