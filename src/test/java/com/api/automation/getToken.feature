@ignore
Feature: To get JWT token for the user
  POST http://localhost:9898/users/sign-up

  Scenario: Register the user and generate the token
    # Register the User
    Given url 'http://localhost:9898/users/sign-up'
    And headers {Accept:'application/json', Content-Type:'application/json'}
    And request { username: '#(username)', password: '#(password)'}
    When method post
    Then status 200
    #Get the token
    Given url 'http://localhost:9898/users/authenticate'
    And headers {Accept:'application/json', Content-Type:'application/json'}
    And request { username: '#(username)', password: '#(password)'}
    When method post
    Then status 200
    * def authToken = response.token
