package com.api.automation;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.intuit.karate.Runner;

public class ParallelRunnerWithTags {
//Fetching results for parallel run
	private static final String CLASS_PATH = "classpath:";
	private static final String DELIMITER = ",";

	@Test
	public void executeKarateTest() {
		// Runner.builder().path("classpath:com/api/automation").tags("@smoke",
		// "@regression").parallel(5);
		// another way
		Runner.builder().path(getLocation()).tags(getTags()).parallel(5);

	}

//	private List<String> getTags(){
//		String aTags = System.getProperty("tags","@confidence");
//		List<String> aTagList = Arrays.asList(aTags);
//		return aTagList;
//	}
//	
//	private List<String> getLocation(){
//		String aLocations = System.getProperty("location","com/api/automation");
//		List<String> aTagList = Arrays.asList(CLASS_PATH + aLocations);
//		return aTagList;
//	}

	// Enhancing the Parallel runner
	// step1- provide the values for location and tags property. All the values will
	// be separated by ","
	// Read the values , split them using "," and create a list out of it.

	private List<String> getTags() {
		String aTags = System.getProperty("tags", "@confidence");
		List<String> aTagList = Collections.emptyList();
		// First check for the delimiter (,)
		// if the aTags has the delimiter then split the string using the delimiter
		// And create the list out of it
		// if aTags does not have delimiter, use the old logic
		if (aTags.contains(",")) {
			String tagArray[] = aTags.split(DELIMITER);
			aTagList = Arrays.asList(tagArray);
			return aTagList;
		} else {
			aTagList = Arrays.asList(aTags);
			return aTagList;
		}

	}

	private List<String> getLocation() {
		String aLocation = System.getProperty("location", "com/api/automation");
		List<String> aLocationList = Collections.emptyList();
		if (aLocation.contains(DELIMITER)) {
			String aLocationArray[] = aLocation.split(",");
			aLocationList = Arrays.asList(aLocationArray);
			aLocationList.replaceAll((entry) -> {
				return CLASS_PATH + entry;
			});
			return aLocationList;
		} else {
			aLocationList = Arrays.asList(CLASS_PATH + aLocation);
			return aLocationList;
		}
	}
}
//Note: tags("@smoke","@regression") => This forms "@smoke","@regression" AND condition. 
// it'll execute the scenarios which has @smoke and @regression tags.