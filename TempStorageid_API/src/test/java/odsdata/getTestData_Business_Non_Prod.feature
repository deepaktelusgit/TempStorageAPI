#Author: rajat.nolastname@telus.com
#Feature: Fetch test data from ODS test data API.

Feature: Test Data file to fetch Active and Suspended Business TNs from ODS Test Data API
  
Background: some resuable code
    * url baseURL
    And configure ssl = true
    And header Content-Type = 'application/json'
    And header env = env
    And header Authorization = 'Bearer '+authInfo.response.access_token
    * print mockResponseWLS_BIZ_ACTIVE
    * print mockResponseWLS_BIZ_SUSPENDED
    * print mockResponseWLN_BIZ_ACTIVE

@getdatabizWLS
  Scenario: WLS_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'BIZ'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLS_BIZ_ACTIVE = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_BIZ_ACTIVE

@getdatabizWLS_Suspended
 	Scenario: WLS_BIZ_Suspended_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'BIZ'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'Suspended'
    When method get
    And print response
    And def mockResponseWLS_BIZ_SUSPENDED = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_BIZ_SUSPENDED
    
 @getdatabizWLN
  Scenario: WLN_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELINE'
    And param businessUnit = 'BIZ'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLN_BIZ_ACTIVE = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLN_BIZ_ACTIVE