Feature: To use the Json Path expression

  Background: To set up the background
    Given url 'http://localhost:9897'

  Scenario: To get the value using json path expression
    Given path 'normal/webapi/all'
    When method get
    Then status 200
    # Syntax - karate.jsonPath(doc,jsonPathExpression)
    * def jobTitle = karate.jsonPath(response, "$[?(@.jobId == 1)].jobTitle")
    * def jobDescription = karate.jsonPath(response, "$[?(@.jobId == 1)].jobDescription")
    * def experience = karate.jsonPath(response, "$[?(@.jobId == 1)].experience")
    And print "Job Title ===> ",jobTitle
    And print "Job Description ====> ",jobDescription
    And print "Experience ====> ",experience
