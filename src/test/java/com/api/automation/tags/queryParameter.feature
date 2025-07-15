@regression @confidence
Feature: To test GET endpoint using query parameter
  GET /normal/webapi/find

  Background: Create and Initialize the url
    Given url 'http://localhost:9897'

  Scenario: To get data using query parameter
    # Create the job entry
    # Get the newly created job entry using query param
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createjobId = getRandomValue()
    * def createJob =  call read("../../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add',_id:'#(createjobId)'}
    # Send the GET request with query param
    Given path '/normal/webapi/find'
    #	And param id = createjobId
    #	And param jobTitle = 'APITesting'
    And params {id:'#(createjobId)', jobTitle:'APITesting'}
    And headers {Accept:'application/json'}
    When method get
    Then status 200
    And print 'printing the response data'
    And match response.jobId == createjobId

  Scenario: To get data using query parameter with jobId not in the appplication
    # Create the job entry
    # Get the newly created job entry using query param
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def createjobId = getRandomValue();
    * def createJob =  call read("../../createJobEntryWithVariables.feature") {_url:'http://localhost:9897', _path:'/normal/webapi/add',_id:'#(createjobId)'}
    # Send the GET request with query param
    Given path '/normal/webapi/find'
    And param id = 89897
    And param jobTitle = 'APITesting'
    And headers {Accept:'application/json'}
    When method get
    Then status 404
