Feature: To test the updation of the job entry in the test application
  Test the end point PUT /normal/webapi/update

  Background: Create and Initialize the url
    Given url 'http://localhost:9897'

  Scenario: To update the Job Entry for existing Job in JSON format
    #Create a job entry
    #Update the Job Entry using PUT request
    #Using JsonPath verify the updation of details in Job entry
    Given path '/normal/webapi/add'
    #Generate a random Job id using javascript
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def id = getRandomValue()
    And request {"jobId": '#(id)',"jobTitle": "Web Engineering","jobDescription": "To develop web application","experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept:'application/json', Content-Type: 'application/json'}
    When method post
    And status 201
    #PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
        "jobId": '#(id)',
        "jobTitle": "Automation & Performance Testing",
        "jobDescription": "To test Web and Database application",
        "experience": [
            "Web",
            "Load",
            "Mobile Android"
        ],
        "project": [
            {
                "projectName": "Testing App",
                "technology": [
                    "Kotlin",
                    "SQL Lite",
                    "Gradle",
                    "Spec Flow"
                ]
            },
            {
                "projectName": "Database Testing App",
                "technology": [
                    "Oracle",
                    "SQL Lite",
                    "MySQl",
                    "MongoDB"
                ]
            }
        ]
      }
      """
    And headers {Accept: 'application/json',Content-Type:'application/json'}
    When method put
    Then status 200
    * def projectArray = karate.jsonPath(response,"$[?(@.jobId == " + id + ")].project")
    * print projectArray
    And match projectArray[0] == '#[2]'

  #	Negative test case
  Scenario: To update the Job Entry for existing Job in JSON format
    #Create a job entry
    #Update the Job Entry using PUT request
    #Using JsonPath verify the updation of details in Job entry
    Given path '/normal/webapi/add'
    #Generate a random Job id using javascript
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    * def id = getRandomValue()
    And request {"jobId": '#(id)',"jobTitle": "Web Engineering","jobDescription": "To develop web application","experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept:'application/json', Content-Type: 'application/json'}
    When method post
    And status 201
    #PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
        "jobId": '#(getRandomValue())',
        "jobTitle": "Automation & Performance Testing",
        "jobDescription": "To test Web and Database application",
        "experience": [
            "Web",
            "Load",
            "Mobile Android"
        ],
        "project": [
            {
                "projectName": "Testing App",
                "technology": [
                    "Kotlin",
                    "SQL Lite",
                    "Gradle",
                    "Spec Flow"
                ]
            },
            {
                "projectName": "Database Testing App",
                "technology": [
                    "Oracle",
                    "SQL Lite",
                    "MySQl",
                    "MongoDB"
                ]
            }
        ]
      }
      """
    And headers {Accept: 'application/json',Content-Type:'application/json'}
    When method put
    Then status 404

  # We will use the shared context to get the variables from the called feature file
  # Shared Context -  behavior where all key-value pairs in the returned map-like object
  # get automatically added as variables - applies to the calling of *.feature files
  # "." operators are used to access the variables
  Scenario: To update job entry for existing job in JSON format by calling another feature file using Shared Context
    #	<Gherking keyword> <call> <read(<location of the file>)>
    #".."> refers to the current directory
    * def postRequest = call read("../createJobEntry.feature")
    And print "calling feature file == > ", postRequest.id
    And print "calling feature file == > ", postRequest.getRandomValue()
    #PUT request
    Given path '/normal/webapi/update'
    And request
      """
      {
        "jobId": '#(postRequest.id)',
        "jobTitle": "Automation & Performance Testing",
        "jobDescription": "To test Web and Database application",
        "experience": [
            "Web",
            "Load",
            "Mobile Android"
        ],
        "project": [
            {
                "projectName": "Testing App",
                "technology": [
                    "Kotlin",
                    "SQL Lite",
                    "Gradle",
                    "Spec Flow"
                ]
            },
            {
                "projectName": "Database Testing App",
                "technology": [
                    "Oracle",
                    "SQL Lite",
                    "MySQl",
                    "MongoDB"
                ]
            }
        ]
      }
      """
    And headers {Accept:'application/json', Content-Type: 'application/json'}
    When method put
    And status 200
    * def projectArray = karate.jsonPath(response,"$[?(@.jobId == "+postRequest.id+")].project")
    And print projectArray
    And match projectArray[0] == '#[2]'

    
    #Passing variables to called feature file from calling feature file
    	#All variables should be specified in form of JSON object
    Scenario: To update the Job entry for the existing job in JSON format by calling another feature file with variables
    #<Gherkin keyword> <call> <read(<location of file>)>
    #Given call read("../createJobEntry.feature") {var1:value, var2:value}
    * def getRandomValue = function(){return Math.floor((100) * Math.random());}
    * def id = getRandomValue()
    * def postRequest = call read("../createJobEntryWithVariables.feature") { _url:'http://localhost:9897', _path:'/normal/webapi/add/', _id:'#(id)'}