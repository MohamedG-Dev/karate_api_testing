Feature: To validate JSON array using GET end point
  To validate the get end point response JSON array

  Background: setup the base url
    Given url 'http://localhost:9897'

  Scenario: to get the data in the json format and validate JSON array
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response
    And match response.[0].jobId == 1
    And match response.[0].experience[1] == 'Apple'
    And match response.[0].project[0].projectName == 'Movie App'
    And match response.[0].project[0].technology[2] == 'Gradle'
    #validate the size of the array
    And match response.[0].experience == '#[3]'
    And match response.[0].project[0].technology == '#[3]'
    #validate using wild card - *
    #the below statement will fail the test case
    #And match response.[0].experience[*] == 'Apple'
    And match response.[0].experience[*] == ["Google","Apple","Mobile Iron"]
    And match response.[0].project[0].technology[*] == ["Kotlin","SQL Lite","Gradle"]
    #validate using wild card and contains keyword
    And match response.[0].experience[*] contains 'Apple'
    And match response.[0].project[0].technology[*] contains ['SQL Lite']
    And match response.[*].jobId contains 1
