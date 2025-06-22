package com.api.automation.patchrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class PatchRequestRunner {

	@Test
	public Karate testRun() {
		return Karate.run("patchRequest").relativeTo(getClass());
	}

}
