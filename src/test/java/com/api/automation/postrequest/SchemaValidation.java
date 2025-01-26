package com.api.automation.postrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class SchemaValidation {

	@Test
	public Karate run() {
		return Karate.run("schemaValidation").relativeTo(getClass());
	}
}
