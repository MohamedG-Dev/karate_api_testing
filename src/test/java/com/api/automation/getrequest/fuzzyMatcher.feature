Feature: To validate Fuzzy matcher using GET end point
  To validate the get end point response with Fuzzy matcher

  Background: setup the base url
    Given url 'http://localhost:9897'

  Scenario: to get the data and validate in fuzzy matchers using JSON format response
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response
    And match response.[0].jobId == '#present'
    And match response.[0].jobId == '#number'
    And match response.[0].experience[1] == '#notnull'
    And match response.[0].project[0].projectName == '#ignore'
    And match response.[0].project[0].technology == '#array'
    And match response.[0].jobTitle == '#string'
    #Complex fuzzy matcher
    And match response.[0].jobId == '#? _ == 1'
    #the below condition checks that the value of jobTitle should be string
    #and the length should be greater than 1
    And match response.[0].jobTitle == '#string? _.length >=1'
    #to validate the array
    #the below statement checks that the experience is an array type
    # '#[]' -> means check the value is an array type
    And match response.[0].experience == '#[]'
    # '#[3]' -> means check the size of an array is [3]
    And match response.[0].experience == '#[3]'
    # make sure the given array is of string type
    And match response.[0].experience == '#[3] #string'
    And match response.[0].experience == '#[3] #string? _.length >= 2'
    
    
    Scenario: to get the data and validate in fuzzy matchers using XML format response
    Given path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And print response
    And match response/List/item/jobId == '#notnull'
    And match response/List/item/jobTitle == '#string'
    And match response/List/item/experience/experience[2] == '#notnull'
    And match response/List/item/project/project/projectName == '#present'
    And match response/List/item/project/project/technology/technology[3] == '#ignore'
    #Complex fuzzy matcher
    And match response/List/item/jobTitle == '#string? _.length >=1'
    And match response/List/item/JobTitle.id == '#notpresent'
    
    
