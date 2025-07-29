Feature: To create a job entry in the application
 use POST /normal/webapi/add to create job entry in the application
 
 Background: Create and initialize base URL
  Given url _url
  
  Scenario: To create a job entry in the application in json body format
  Given path '/normal/webapi/add/'
  And request {"jobId": 4,"jobTitle": "Web Engineering","jobDescription": "To develop web application","experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
  And headers {Accept : 'application/json' , Content-Type : 'application/json'}
  When method post
  Then status 201
  * print response
  And match response.jobTitle == 'Web Engineering'
  
  Scenario: To create a job entry in the application in xml request body format
  Given path '/normal/webapi/add/'
  And request <item><jobId>6</jobId><jobTitle>Software Engg Graphics</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Mobile Iron</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Dark</technology><technology>Gradle</technology></technology></project></project></item>
  And headers {Accept : 'application/json' , Content-Type : 'application/xml'}
  When method post
  Then status 201
  * print response
  And match response.jobId == 6
  
  Scenario: To create a job entry in the application in xml request body format and receive response in XML
  Given path '/normal/webapi/add/'
  And request <item><jobId>7</jobId><jobTitle>Software Engg Application</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Mobile Iron</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Dark</technology><technology>Gradle</technology></technology></project></project></item>
  And headers {Accept : 'application/xml' , Content-Type : 'application/xml'}
  When method post
  Then status 201
  * print response
  And match response/Job/jobId == '7'