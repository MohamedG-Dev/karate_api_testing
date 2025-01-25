Feature: To validate the GET end point from an external file
  To validate the get end point response from an external file

  Background: setup the base url
    Given url 'http://localhost:9897'

  Scenario: to get the data in the json format from an external file
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    #And print response
    # Create a vraible to store the data from an external file
    #* def expectedResponse = read(karate.properties['user.dir']+ '/src/test/resources/jsonResponse.json')
    * def expectedResponse = read('jsonResponse.json')
    * print expectedResponse
    And match response == expectedResponse
    
    Scenario: to get the data in the xml format from an external file
    Given path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    * def expectedXMLResponse = read('xmlResponse.xml')
    * print expectedXMLResponse
    And match expectedXMLResponse == response
   	

  