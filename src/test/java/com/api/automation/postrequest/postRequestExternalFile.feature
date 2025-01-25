Feature: To create a job entry in the application using external file
 use POST /normal/webapi/add to create job entry in the application
 
 Background: Create and initialize base URL
  Given url 'http://localhost:9897'
  
  Scenario: To create a job entry in the application in json body format
  Given path '/normal/webapi/add/'
  * def requestBody = read('postRequestBody.json')
  And request requestBody
  And headers {Accept : 'application/json' , Content-Type : 'application/json'}
  When method post
  Then status 201
  * print response
  And match response.jobTitle == 'Web Development'
  
  Scenario: To create a job entry in the application in xml request body format
  Given path '/normal/webapi/add/'
  * def requestBody = read('postRequestBody.xml')
  And request requestBody
  And headers {Accept : 'application/json' , Content-Type : 'application/xml'}
  When method post
  Then status 201
  * print response
  And match response.jobId == 10