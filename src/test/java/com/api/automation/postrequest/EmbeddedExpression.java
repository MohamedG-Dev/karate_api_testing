package com.api.automation.postrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class EmbeddedExpression {

	@Test
	public Karate runTest() {
		return Karate.run("embeddedExpression").relativeTo(getClass());
	}
}
