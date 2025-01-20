package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class ValidateXMLResponse {

	@Test
	public Karate runTest() {
		return Karate.run("validateXMLResponse").relativeTo(getClass());
	}
}
