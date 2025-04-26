package com.api.automation;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class ParallelRunner {
//Fetching results for parallel run
	@Test
	public void executeKarateTest() {
		Results result=Runner.path("classpath:com/api/automation").parallel(5);
		System.out.println("Total Feature:=> "+result.getFeaturesTotal());
		System.out.println("Total Scenarios:=> "+result.getScenariosTotal());
		System.out.println("Passed Scenarios:=> "+result.getScenariosPassed());
		Assertions.assertEquals(0, result.getFailCount(),"There are some failures");
	}
}
