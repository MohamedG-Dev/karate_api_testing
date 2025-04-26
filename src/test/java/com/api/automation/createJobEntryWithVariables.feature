Feature: To create the job entry in test application
  Helper file for POST method /normal/webapi/add

#Variable values will be passed from the calling feature file
  Scenario: To create a job entry with JSON Data
    Given url _url
    And path _path
    And print "Helper == >", _url
    And print "Helper == >", _path
    And print "Helper == >", _id
    * def getRandomValue = function(){return Math.floor((100) * Math.random());}
    * def id = getRandomValue()
    And request {"jobId": '#(_id)',"jobTitle": "Web Engineering","jobDescription": "To develop web application","experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept:'application/json', Content-Type: 'application/json'}
    When method post
    And status 201
    * def responseJobId = response.jobId
    
    
    
   
