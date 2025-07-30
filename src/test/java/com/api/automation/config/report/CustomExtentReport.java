package com.api.automation.config.report;

import java.util.stream.Stream;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.gherkin.model.And;
import com.aventstack.extentreports.gherkin.model.Feature;
import com.aventstack.extentreports.gherkin.model.Given;
import com.aventstack.extentreports.gherkin.model.Scenario;
import com.aventstack.extentreports.gherkin.model.Then;
import com.aventstack.extentreports.gherkin.model.When;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;
import com.intuit.karate.Results;
import com.intuit.karate.core.Result;
import com.intuit.karate.core.ScenarioResult;
import com.intuit.karate.core.Step;

public class CustomExtentReport {
//builder design pattern

	private ExtentReports extentReports;
	private ExtentSparkReporter extentSparkReporter;
	private String reportDirectory;
	private String reportTitle = "Karate Test Execution Report";
	private Results testResults;
	private ExtentTest featureNode;
	private String featureTitle = "";
	private ExtentTest scenarioNode;
	private String scenarioTitle = "";

	public CustomExtentReport() {
		extentReports = new ExtentReports();
	}

	public CustomExtentReport withReportDir(String reportDirectory) {
		this.reportDirectory = reportDirectory;
		return this;
	}

	public CustomExtentReport withKarateResult(Results testResults) {
		this.testResults = testResults;
		return this;
	}

	public CustomExtentReport withReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
		return this;
	}

	public void generateExtenReport() {
		// 1. Check for ReportDir and TestResults, if not present then throw Exception
		if (this.reportDirectory != null && !this.reportDirectory.isEmpty() && this.testResults != null) {
			extentSparkReporter = new ExtentSparkReporter(reportDirectory);
			extentReports.attachReporter(extentSparkReporter);
			setConfig();
			Stream<ScenarioResult> scenarioResults = getScenarioResult();
			scenarioResults.forEach((scenarioResult) -> {
				String featureName = getFeatureName(scenarioResult);
				String featureDescription = getFeatureDescription(scenarioResult);
				ExtentTest featureNode = createFeatureNode(featureName, featureDescription);
				String scenarioTitle = getScenarioTitle(scenarioResult);
				ExtentTest scenarioNode = createScenarioNode(featureNode, scenarioTitle);
				scenarioResult.getStepResults().forEach((step) -> {
					// Adding the scenario step with the scenario node
					addScenarioStep(scenarioNode, step.getStep(), step.getResult());
				});
			});
			extentReports.flush();
			return;
		}
		// 2. Using test results, get the list of scenarios results
		// 3. loop over list of scenario results
		// 4. using scenario result, get the scenario object
		// 5. using scenario object, get the info about the feature file
		// 6. using same scenario object, we will get the info about the scenario
		// 7. using scenario result, get the list of step result
		// 8. loop over step result lits, get the info about the scenario step and its
		// execution status
		// 9. use all info to generate the report
		throw new RuntimeException("Missing Karate Test Result / Report Directory Location");
	}

	private Stream<ScenarioResult> getScenarioResult() {
		return this.testResults.getScenarioResults();
	}

	private String getFeatureName(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getFeature().getName();
	}

	private String getFeatureDescription(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getFeature().getDescription();
	}

	private ExtentTest createFeatureNode(String featureName, String featureDescription) {
		// if the title of the feature is same. I will return same instance of extent
		// test
		// else I will create a new instance and then return it
		if (this.featureTitle.equalsIgnoreCase(featureName)) {
			return featureNode;
		}
		this.featureTitle = featureName;
		featureNode = extentReports.createTest(Feature.class, featureName, featureDescription);
		return featureNode;
	}

	private ExtentTest createScenarioNode(ExtentTest featureNode, String scenarioTitle) {
		if (this.scenarioTitle.equalsIgnoreCase(scenarioTitle)) {
			return featureNode;
		}
		this.featureTitle = scenarioTitle;
		scenarioNode = featureNode.createNode(Scenario.class, scenarioTitle);
		return featureNode;
	}

	private String getScenarioTitle(ScenarioResult scenarioResult) {
		return scenarioResult.getScenario().getName();
	}

	private void addScenarioStep(ExtentTest scenarioNode, Step step, Result stepResult) {
		String type = step.getPrefix(); // returns Given,When,Then
		String stepTitle = step.getText();
		String status = stepResult.getStatus();
		Throwable error = stepResult.getError();
		ExtentTest stepNode;

		switch (type) {
		case "Given":
			stepNode = scenarioNode.createNode(Given.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		case "When":
			stepNode = scenarioNode.createNode(When.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		case "Then":
			stepNode = scenarioNode.createNode(Then.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		case "And":
			stepNode = scenarioNode.createNode(And.class, stepTitle);
			addStatus(stepNode, status, error);
			break;
		default:
			stepNode = scenarioNode.createNode(type + " " + stepTitle);
			break;
		}
	}

	private void addStatus(ExtentTest stepNode, String status, Throwable error) {
		switch (status) {
		case "passed":
			stepNode.pass("");
			break;
		case "failed":
			stepNode.fail(error);
			break;
		default:
			stepNode.skip("");
			break;
		}

	}
	
	private void setConfig() {
		extentSparkReporter.config().enableOfflineMode(true);
		extentSparkReporter.config().setDocumentTitle(reportTitle);
		extentSparkReporter.config().setTimelineEnabled(true);
		extentSparkReporter.config().setTheme(Theme.DARK);
	}
}
