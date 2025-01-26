Feature: Validate the JSON Schema
  To validate the JSON schema for POST /normal/webapi/add

  Background: Create and initialize base URL
    Given url 'http://localhost:9897'

  Scenario: To create the job entry using JSON format
    Given path '/normal/webapi/add'
    * def requestBody = read('postRequestBody.json')
    And request requestBody
    And headers {Accept : 'application/json' , Content-Type: 'application/json'}
    When method post
    And status 201
    And match response ==
      """
      {
      "jobId":"#number",
      "jobTitle":"#string",
      "jobDescription":"#string",
      "experience":'#[] #string',
      'project':'#[] #object'
      }
      """
