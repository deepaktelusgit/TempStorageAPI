#Author: rajat.nolastname@telus.com
Feature: Validate the Customer Info API response for WLS/WLN Customer search criteria BAN

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def mockResponseWLS_CORP_ACTIVE = callonce read("../odsdata/getTestData_CORP_Non_Prod.feature@getdataCorpActive")
    * def mockResponseWLS_RES_ACTIVE = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLS_Active")
    * def mockResponseWLN_RES_ACTIVE = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLN_Active")
    * def mockResponseWLN_BIZ_ACTIVE = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLN")
    * def mockResponseWLS_BIZ_ACTIVE = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLS")
    * print mockResponseWLS_CORP_ACTIVE
    * print mockResponseWLN_RES_ACTIVE

  Scenario Outline: TC002_Validate account type code, BU and Domain for a WLN_BIZ_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]
    And match response.accountList[*].domain == ["wireline"]

    Examples: 
      | mockResponseWLN_BIZ_ACTIVE.mockResponseWLN_BIZ_ACTIVE |

  Scenario Outline: TC003_Validate account type code and domain for WLS_BIZ_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].domain == ["wireless"]

    Examples: 
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |

  Scenario Outline: TC004_Validate Account type and billing type for WLS_CORP_ACTIVE_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["C"]
    * print response
    * print mockResponseWLS_CORP_ACTIVE

    Examples: 
      | mockResponseWLS_CORP_ACTIVE.mockResponseWLS_CORP_ACTIVE |

  Scenario Outline: TC005_Validate Account type code for WLS_RES_ACTIVE_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["I"]

    Examples: 
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC006_Validate account type code and business unit for WLN_RES_ACTIVE_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["R"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      | mockResponseWLN_RES_ACTIVE.mockResponseWLN_RES_ACTIVE |

  Scenario Outline: TC007_Validate account type code and business unit for WLS_RES_ACTIVE_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      #| read('classpath:data/'+data_file7) |
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |
