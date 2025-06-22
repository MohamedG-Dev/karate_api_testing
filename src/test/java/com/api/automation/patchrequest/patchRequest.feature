Feature: To test the patch end point for updating the job description
  PATCH /normal/webapi/update/details

  Background: Create and Initialize url
    Given url 'http://localhost:9897'

  Scenario: To update the job description for the newly created job entry
    #	Create a new job entry
    # using the patch request update the job description of newly added job entry
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897',_path:'/normal/webapi/add',_id:'#(createJobId)'}
    # Patch Request
    * def jobDes = 'To perform API testing and validate the data'
    Given path '/normal/webapi/update/details'
    And params {id:'#(createJobId)',jobTitle:'APITesting',jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 200
    And match response.jobDescription == jobDes

  Scenario: To update job description for the newly created job entry with non-existing job id
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897',_path:'/normal/webapi/add',_id:'#(createJobId)'}
    * def jobDes = "To Validate the database data"
    Given path '/normal/webapi/update/details'
    And params {id:'-11',jobTitle:'APITesting',jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 404

  Scenario: To update job description for the newly created job entry without jobTitle parameter
    * def getRandomValue = function() { return Math.floor((100) * Math.random());}
    * def createJobId = getRandomValue()
    * def createJob = call read("../createJobEntryWithVariables.feature") {_url:'http://localhost:9897',_path:'/normal/webapi/add',_id:'#(createJobId)'}
    * def jobDes = "To validate database"
    Given path '/normal/webapi/update/details'
    And params {id:'#(createJobId)',jobDescription:'#(jobDes)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 400
    And match response.message == "Required String parameter 'jobTitle' is not present"
