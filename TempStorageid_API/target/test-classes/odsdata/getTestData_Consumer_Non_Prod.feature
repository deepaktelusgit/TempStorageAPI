#Author: rajat.nolastname@telus.com
#Feature: Fetch test data from ODS Test data API for Residential customer.

Feature: Fetch Active/Suspended Consumer test data form ODS Test API for Consumer.feature file.
 
Background: some resuable code
    * url baseURL
    And configure ssl = true
    And header Content-Type = 'application/json'
    And header env = env
    And header Authorization = 'Bearer '+authInfo.response.access_token
    * print mockResponseWLS_RES_ACTIVE
    * print mockResponseWLS_RES_SUSPENDED
    * print mockResponseWLN_RES_ACTIVE
    
    
@getdata_resWLS_Active
  Scenario: WLS_RES_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'RES'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLS_RES_ACTIVE = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_RES_ACTIVE

@getdata_resWLS_Suspended
 	Scenario: WLS_RES_Suspended_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'RES'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'Suspended'
    When method get
    And print response
    And def mockResponseWLS_RES_SUSPENDED = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_RES_SUSPENDED
    
  @getdata_resWLN_Active
  Scenario: WLN_RES_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELINE'
    And param businessUnit = 'RES'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLN_RES_ACTIVE = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLN_RES_ACTIVE