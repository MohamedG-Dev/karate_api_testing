Feature: Variables creation in Karate Framework
#
#Syntax for variable creation: <Gherkin keyword> <def> <variable_name> = <value>

Background: Create and Initialize variables
* def app_name = "google"
* def page_load_timeout = 20

Scenario: To create a karate variable
#use variable for repeating value
#Storing the data in external file
#In matcher expression
#Passing the data from one feature file to another

Given def var_int = 10
And def var_string = 'Karate'
Then print 'Integer variable value===>',var_int
Then print 'String varibale value====>',var_string 
* def var_int02 = var_int + 5
And print 'value of var_int02 is======>',var_int02
And print 'Background section variable=====>',app_name,page_load_timeout

Scenario: Access the variable
* def var_int = 11
* def var_string = "Access variable"
* def var_int02 = var_int + 1
Given print 'Integer variable value====>',var_int
And print 'String variable value=====>',var_string
And print 'value of var_int02 is=====>',var_int02
And print 'Background section variable=====>',app_name,page_load_timeout