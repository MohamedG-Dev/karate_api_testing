Feature: To test delete End Point
  DELETE /normal/webapi/remove/{id}

  Background: Create and Initialize base URL
    Given url 'http://localhost:9897'

	@smoke
  Scenario: To delete the job entry from application job id
    #	Create a new JobEntry
    # delete the newly created job entry
    # Get request with query parameter and validate for 404
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createJobId = getRandomValue()
    * def createjob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897',_path:'/normal/webapi/add',_id:'#(createJobId)'}
    # delete request
    Given path '/normal/webapi/remove/'+ createJobId
    And headers {Accept: 'application/json'}
    When method delete
    Then status 200
    # Get request
    Given path '/normal/webapi/find'
    And params {id:'#(createJobId)',jobTitle:'APITesting'}
    When method get
    Then status 404

	@regression
  Scenario: To delete the job entry from application job id and try deleting the same job entry twice
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createJobId = getRandomValue()
    * def createjob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897',_path:'/normal/webapi/add',_id:'#(createJobId)'}
    # delete request
    Given path '/normal/webapi/remove/'+ createJobId
    And headers {Accept: 'application/json'}
    When method delete
    Then status 200
    # delete request
    Given path '/normal/webapi/remove/'+ createJobId
    And headers {Accept: 'application/json'}
    When method delete
    Then status 404

  Scenario: To demo request Chaining
    # Create a new job entry
    # Extract the job id and job title from the response of POST request
    # Send the path request, Value of query parameter will be set by info extracted from previous request
    # Extract the job id and job title from the job response of patch request
    # Get request with query parameter, value of query param is set by info extracted from response patch request
    # Add the validation on job description in the response of get request
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897',_path:'/normal/webapi/add',_id:'#(createJobId)'}
    * def jobID = createJob.response.jobId
    * def jobTitle = createJob.response.jobTitle
    #Patch request
    * def jobDes = 'To Perform API testing and database testing'
    Given path '/normal/webapi/update/details'
    And params {id:'#(jobID)',jobTitle:'#(jobTitle)',jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    And status 200
    * def jobID = response.jobId
    * def jobTitle = response.jobTitle
    #Get request
    Given path 'normal/webapi/find'
    And params {id:'#(jobID)',jobTitle:'#(jobTitle)'}
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.jobDescription == jobDes
