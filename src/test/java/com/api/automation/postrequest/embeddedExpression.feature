Feature: To validate the data using embedded expressions

  Background: Create and initialize base URL
    Given url 'http://localhost:9897'

  Scenario: To create a job entry in the application in json body format
    Given path '/normal/webapi/add/'
    * def getJobId = function() {return Math.floor((100) * Math.random());}
    And request {"jobId": '#(getJobId())',"jobTitle": "Web Engineering","jobDescription": "To develop web application","experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept : 'application/json' , Content-Type : 'application/json'}
    When method post
    Then status 201
    * print response
    And match response.jobTitle == 'Web Engineering'

  Scenario: To create a job entry in the application in xml request body format
    Given path '/normal/webapi/add/'
    * def getJobId = function() {return Math.floor((100) * Math.random());}
    * def jobId = getJobId()
    And request <item><jobId>#(jobId)</jobId><jobTitle>Software Engg Graphics</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Mobile Iron</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Dark</technology><technology>Gradle</technology></technology></project></project></item>
    And headers {Accept : 'application/json' , Content-Type : 'application/xml'}
    When method post
    Then status 201
    * print response
    And match response.jobId == '#(jobId)'

  Scenario: Complex Schema get end point
    #Note if this scenario fails, then restart the server and try again. it'll work
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get #send the get request
    Then status 200
    * def projectSchema = {"projectName":'#string','technology':'#[] #string'}
    * def mainSchema = {"jobId":'#number', "jobTitle":'#string',"jobDescription":'#string',"experience":'#[] #string',"project":'#[] ##(projectSchema)'}
    And match response ==
      """
      '#[] ##(mainSchema)'
      """
