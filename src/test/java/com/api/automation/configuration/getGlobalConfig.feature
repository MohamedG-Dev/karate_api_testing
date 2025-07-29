Feature: To get the varaibles set by Karate-config.js file

Background: To get the value of myVarName
* def localMyVarName = myVarName
Given print "Background variable value ==> ", localMyVarName

Scenario: To get the value of username and password from karate-config.js file
* def localUsername = username
Given print "Scenario variable username value ==>", username
And print "Scenario variable password value ==>", password