Feature: To test the get end point of the application
  To test different get end point with different data format supported by the application

  Background: 
    Given url _url
    And print '=========The Background keyword is used============'

  Scenario: To get all the data from application in JSON format
    #Given url 'http://localhost:9897/normal/webapi/all'
    Given path '/normal/webapi/all'
    When method get #send the get request
    Then status 200 #the status code of the response should be 200

	@ignore
  Scenario: To get all the data from application in JSON format using path variable
    #Given url 'http://localhost:9897'
    And path '/normal/webapi/all'
    #Note: keep spaces around '=' sign for the scenario to be execute.
    #	if the spaces around '=' are removed then the test case will fail
    And header Accept = 'application/json'
    #BasePath + ContextPath
    When method get #send the get request
    Then status 200 #the status code of the response should be 200

  Scenario: To get all the data from application in xml format using path variable
    #Given url 'http://localhost:9897'
    And path '/normal/webapi/all'
    #Note: keep spaces around '=' sign for the scenario to be execute.
    #	if the spaces around '=' are removed then the test case will fail
    And header Accept = 'application/xml'
    #BasePath + ContextPath
    When method get #send the get request
    Then status 200 #the status code of the response should be 200
