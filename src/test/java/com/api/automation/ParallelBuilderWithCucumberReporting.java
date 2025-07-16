package com.api.automation;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner.Builder;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class ParallelBuilderWithCucumberReporting {

	@Test
	public void executeKarateTest() {
		Builder aRunner = new Builder();
		aRunner.path("classpath:com/api/automation");
		Results result = aRunner.parallel(5);
		System.out.println("Total Feature:=> "+result.getFeaturesTotal());
		System.out.println("Total Scenarios:=> "+result.getScenariosTotal());
		System.out.println("Passed Scenarios:=> "+result.getScenariosPassed());
		generateCucumberReport(result.getReportDir());
		//Assertions.assertEquals(0, result.getFailCount(),"There are some failures");
	}
	
	private void generateCucumberReport(String reportDirectory) {
		File reportDir = new File(reportDirectory);
		Collection<File> jsonCollection=FileUtils.listFiles(reportDir, new String[] {"karate-json"}, true);
		List<String> jsonFiles = new ArrayList<String>();
		jsonCollection.forEach(file -> jsonFiles.add(file.getAbsolutePath()));
		Configuration configuration = new Configuration(reportDir,"Karate-CucumberReport");
		ReportBuilder reportBuilder = new ReportBuilder(jsonFiles,configuration);
		reportBuilder.generateReports();
	}
}
