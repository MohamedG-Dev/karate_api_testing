package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class KarateVariable {

	@Test
	public Karate runTest() {
		return Karate.run("karateVariables.feature").relativeTo(getClass());
	}
}
