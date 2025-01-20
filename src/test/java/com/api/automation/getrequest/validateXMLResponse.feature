Feature: To validate XML array using GET end point
  To validate the get end point response XML array

  Background: setup the base url
    Given url 'http://localhost:9897'

  Scenario: to get the data in the json format and validate XML array
    Given path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And print response
    And match response/List/item/jobId == '1'
    And match response/List/item/jobTitle == 'Software Engg'
    And match response/List/item/experience/experience[2] == 'Apple'
    And match response/List/item/project/project/projectName == 'Movie App'
    And match response/List/item/project/project/technology/technology[3] == 'Gradle'
    #skip the response keyword
    And match /List/item/jobDescription == 'To develop andriod application'
   	#Traverse XML similarly like JSON
   	And match response.List.item.experience.experience[1] == 'Apple'
   	And match response.List.item.project.project.projectName == 'Movie App'
   	And match response.List.item.project.project.technology.technology[1] == 'SQL Lite'
    