Feature: To send the Get request
  GET http://localhost:9898/auth/webapi/all

  Scenario: Send the GET request with JWT token
    * def token = call read("../../getToken.feature"){username:'John Wick',password: 'continental grounds'}
    Given url 'http://localhost:9898/auth/webapi/all'
    And headers {Accept: 'application/json', Authorization:'#("Bearer " + token.authToken)'}
    When method get
    Then status 200

  Scenario: Send the GET request with JWT token
    Given url 'http://localhost:9898/auth/webapi/all'
    And headers {Accept: 'application/json'}
    When method get
    Then status 401
