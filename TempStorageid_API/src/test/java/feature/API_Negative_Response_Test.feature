@env=it01,it02,it03,it04
Feature: Validate the 404/400 error responses for Customer Info API for various TNs and BANs

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * header x-cloud-trace-context = 'karate-integration-test'
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * print env

  Scenario: TC001_Validate 404 notfounderror for BAN not found
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '70970024'
    When method get
    Then status 404
    And print response

  Scenario: TC002_Validate 404 notfounderror for TN not found
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '4161404453'
    When method get
    Then status 404
    And print response

  Scenario: TC003_Validate 404 notfounderror for TN and BAN not found
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '4161404453'
    And param ban = '70970024'
    When method get
    Then status 404
    And print response

  Scenario: TC004_Validate 400 error for Invalid BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '4r5t6y6y'
    When method get
    Then status 400
    And print response

  Scenario: TC005_Validate 400 error for invalid TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '7801234567'
    When method get
    Then status 400
    And print response

  Scenario: TC006_Validate 400 error for invalid BAN and TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '7801234567'
    And param ban = '4r5t6y6y'
    When method get
    Then status 400
