Feature: To test the get end point of the application
  To test different get end point with different data format supported by the application

  Scenario: To test the get end point with JSON data
    Given the application url 'www.google.com'
    And the context path is '/getdata'
    When I send the get request
    Then The status code should be 200
    And the response format should be in JSON

  Scenario: To test the get end point with XML data
    Given the application url 'www.google.com'
    And the context path is '/getdata'
    When I send the get request
    Then The status code should be 200
    And the response format should be in JSON
