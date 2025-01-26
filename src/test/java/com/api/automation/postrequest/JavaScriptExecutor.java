package com.api.automation.postrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class JavaScriptExecutor {

	@Test
	public Karate runTest() {
		return Karate.run("javascriptExecutor").relativeTo(getClass());
	}
}
