package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestGetRunner {
//for @Test method, import statement should be as mentioned - com.intuit.karate.junit5.Karate.Test
	@Test
	public Karate runTest() {
//		the "get_RequestDemo" is the feature filename. relativeTo(getClass()) is the method that
//		is used to get path of the current class by using the following syntat - relativeTo(getClass())
		return Karate.run("get_RequestDemo").relativeTo(getClass());
	}

	@Test
	public Karate runTestUsingClassPath() {
//		inside run method if we are giving as below-mentioned, then we no need relativeTo method
		return Karate.run("classpath:com/api/automation/getrequest/get_RequestDemo.feature");
	}
}
