Feature: To create a job description in the test application

  Background: Read the data  from the CSV file
    * def testdata = read('testdata.csv')
    * print testdata

  #<method> is added to differentiate the scenario for a unique name
  #And this capabiltiy is onyl available in the Karate framework.
  Scenario Outline: To create a job description in the job title <method>
    Given print '<url>'
    Then print '<path>'
    When print '<method>'
    And print '<status>'

    Examples: 
      | url                   | path                | method | status |
      | http://localhost:9897 | /normal/webapi/all  | get    |    200 |
      | http://localhost:9897 | /normal//webapi/add | post   |    201 |

  Scenario Outline: To create a job entry in the application in json body format <status>
    Given url 'http://localhost:9897'
    And path '/normal/webapi/add/'
    #Embedded expressions are used- '#(jobId)','#(jobTitle)''#(jobDescription)'
    And request {"jobId": '#(jobId)',"jobTitle": '#(jobTitle)',"jobDescription": '#(jobDescription)',"experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept : 'application/json' , Content-Type : 'application/json'}
    When method post
    #To use the integer value we just give the column without quotes. e.g: <status>
    Then status <status>

    Examples: 
      | jobId | jobTitle            | jobDescription       | status |
      |   101 | Functional Tester   | Regression Testing   |    201 |
      | id    | Functional Tester02 | Regression Testing02 |    400 |
      | false | Functional Tester03 | Regression Testing03 |    400 |

  Scenario Outline: To create a job entry in the application in json body format CSV file - <jobId>
    Given url 'http://localhost:9897'
    And path '/normal/webapi/add/'
    #Embedded expressions are used- '#(jobId)','#(jobTitle)''#(jobDescription)'
    And request {"jobId": '#(jobId)',"jobTitle": '#(jobTitle)',"jobDescription": '#(jobDescription)',"experience": ["Google","Apple","Microsoft"],"project": [{"projectName": "Web App","technology": ["JAVA","Spring boot","Maven"]}]}
    And headers {Accept : 'application/json' , Content-Type : 'application/json'}
    When method post
    #To use the integer value we just give the column without quotes. e.g: <status>
    Then status <status>

    Examples: 
      #| testdata |
      | read('testdata.csv') |
