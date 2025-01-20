package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestResponseGetRunner {
	@Test
	public Karate runTest() {
//		run method of karate can take multiple feature files
		return Karate.run("get_RequestDemo","responseMatcher").relativeTo(getClass());
	}

}
