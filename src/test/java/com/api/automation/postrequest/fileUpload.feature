Feature: To upload a file using Karate framework

  Background: Setup Base path
    Given url 'http://localhost:9897'

  Scenario: To upload a file
    Given path '/normal/webapi/upload'
    # location of the file, name of the file,content-type header file
    # multipart file is one keyword
    And multipart file file = {read:'fileUpload.txt',filename:'fileUpload.txt',Content-type: 'multipart/form-data'}
    When method post
    Then status 200
    And print response
    
    Scenario: To upload a file from a different package
    Given path '/normal/webapi/upload'
    * def fileLocation = '../getrequest/jsonResponse.json'
    # location of the file, name of the file,content-type header file
    # multipart file is one keyword
    And multipart file file = {read:'#(fileLocation)',filename:'jsonResponse.json',Content-type: 'multipart/form-data'}
    When method post
    Then status 200
    And print response
    And match response.message contains 'jsonResponse.json'
