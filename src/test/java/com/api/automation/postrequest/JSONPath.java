package com.api.automation.postrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class JSONPath {

	@Test
	public Karate runTest() {
		return Karate.run("jsonPath.feature").relativeTo(getClass());
	}
}
