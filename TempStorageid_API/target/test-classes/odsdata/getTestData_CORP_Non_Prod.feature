#Author: rajat.nolastname@telus.com
#Feature: Fetch test data from ODS test data API for Corporate customers.

Feature: Fetch test data from ODS Test API for Corporate customers.
  
Background: some resuable code
    * url baseURL
    And configure ssl = true
    And header Content-Type = 'application/json'
    And header env = env
    And header Authorization = 'Bearer '+authInfo.response.access_token
    * print mockResponseWLS_CORP_ACTIVE
    * print mockResponseWLS_CORP_SUSPENDED
    * print mockResponseWLS_CORP_CANCELLED

	@getdataCorpActive
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'CORP'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'ACTIVE'
    When method get
    And print response
    And def mockResponseWLS_CORP_ACTIVE = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_CORP_ACTIVE

	@getdataCorpSuspended
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'CORP'
    And param brand = 'TELUS'
    And param limit = '1'
    And param status = 'SUSPENDED'
    When method get
    And print response
    And def mockResponseWLS_CORP_SUSPENDED = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_CORP_SUSPENDED
    
  @getdataCorpCancelled
  Scenario: WLS_REZ_BIZ_Active_Account
    Given path 'customer/contactCenterOdsData/v1/account'
    And param lob = 'WIRELESS'
    And param businessUnit = 'CORP'
    And param brand = 'TELUS'
    And param limit = '5'
    And param status = 'Cancelled'
    When method get
    And print response
    And def mockResponseWLS_CORP_CANCELLED = response
    And karate.write(response, "testdata/output.json")
    * print mockResponseWLS_CORP_CANCELLED