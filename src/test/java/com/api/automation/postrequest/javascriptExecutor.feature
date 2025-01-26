 Feature: To Execute javascript function

  Scenario: Execute javascript function with or without parameter
    * def getIntValue = function() {return 10;}
    Then print "Function value =>",getIntValue()
    # Math,floor and random all are JavaScript standard function
    * def getRandomValue = function() {return Math.floor((100) * Math.random());}
    Then print "Random value is===>",getRandomValue()
    * def getStringValue = function(arg) {return "Hello" +arg;}
    Then print "String value is===>",getStringValue("World")
