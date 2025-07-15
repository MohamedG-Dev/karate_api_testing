@confidence
Feature: To create the job entry in test application
  Helper file for POST method /normal/webapi/add

  Scenario: To create a job entry with JSON Data
    Given url 'http://localhost:9897'
    And path '/normal/webapi/add/'
    * def getRandomValue = function(){return Math.floor((100) * Math.random());}
    * def id = getRandomValue()
    And request {"jobId": '#(id)',"jobTitle": "Web Engineering","jobDescription": "To develop web application","experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept:'application/json', Content-Type: 'application/json'}
    When method post
    And status 201
    * def responseJobId = response.jobId
    
    #In the called feature file ,always have one scenario. if u have multiple scenarios
    #The recommended approach is to combine them in a single scenario
    
   
