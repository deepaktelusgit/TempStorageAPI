#Author: rajat.nolastname@telus.com
Feature: Validate the Customer Info API response payload for WLS/WLN customers for search criteria TN and BAN.

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def mockResponseWLS_RES_ACTIVE = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLS_Active")
    * def mockResponseWLN_BIZ_ACTIVE = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLN")
    * def mockResponseWLS_BIZ_ACTIVE = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLS")
    * def mockResponseWLS_CORP_ACTIVE = callonce read("../odsdata/getTestData_CORP_Non_Prod.feature@getdataCorpActive")
    * def mockResponseWLS_CORP_SUSPENDED = callonce read("../odsdata/getTestData_CORP_Non_Prod.feature@getdataCorpSuspended")
    * def mockResponseWLS_CORP_CANCELLED = callonce read("../odsdata/getTestData_CORP_Non_Prod.feature@getdataCorpCancelled")
    * def mockResponseWLN_RES_ACTIVE = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLN_Active")
    * def mockResponseWLS_BIZ_SUSPENDED = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLS_Suspended")

  Scenario Outline: TC001_Validate CustomerInfo fetched against TN and BAN combination for WLS_RES_ACTIVE
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And assert response.accountList != null
    And assert response.accountList[0].domain == "wireless"

    Examples: 
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC002_Validate CustomerInfo fetched for WLN_BIZ_ACTIVE customer for TN and BAN combination
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]

    Examples: 
      | mockResponseWLN_BIZ_ACTIVE.mockResponseWLN_BIZ_ACTIVE |

  Scenario Outline: TC003_Validate account type code from CustomerInfo API for WLS_BIZ_ACTIVE customer against TN and BAN combination
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]

    Examples: 
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |

  Scenario Outline: TC004_Validate account type code from CustomerInfo API WLS_CORP_ACTIVE account against TN and BAN combination
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]

    Examples: 
      | mockResponseWLS_CORP_ACTIVE.mockResponseWLS_CORP_ACTIVE |

  Scenario Outline: TC005_Validate account type and status code for WLS_CORP_SUSPENDED_BAN_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]
    And match response.accountList[*].products[*].statusCd == ["suspended"]
    * print response
    * print mockResponseWLS_CORP_SUSPENDED

    Examples: 
      | mockResponseWLS_CORP_SUSPENDED.mockResponseWLS_CORP_SUSPENDED |

  Scenario Outline: TC006_Validate account type and status code for WLS_CORP_SUSPENDED_BAN_TN
    * print mockResponseWLS_CORP_CANCELLED
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]
    And match response.accountList[*].products[*].statusCd == ["cancelled"]
    * print response

    Examples: 
      | mockResponseWLS_CORP_CANCELLED.mockResponseWLS_CORP_CANCELLED |

  Scenario Outline: TC007_Validate account type code and business unit for WLN_RES_ACTIVE_TN_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["R"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      | mockResponseWLN_RES_ACTIVE.mockResponseWLN_RES_ACTIVE |

  Scenario Outline: TC008_Validate account type code and business unit for WLS_RES_ACTIVE_BAN_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC009_Validate account type code and status code for WLS_BIZ_SUSPENDED_TN_BAN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].products[*].statusCd == ["suspended"]

    Examples: 
      | mockResponseWLS_BIZ_SUSPENDED.mockResponseWLS_BIZ_SUSPENDED |
