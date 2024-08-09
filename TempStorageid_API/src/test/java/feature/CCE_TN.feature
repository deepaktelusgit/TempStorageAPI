#Author: rajat.nolastname@telus.com
Feature: Validate Customer Info API response for WLS/WLN customer for search criteria TN

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file = 'tn_feature_data.json'
    * def data_file1 = 'tn_kb_corp_Customer-account_feature_data.json'
    * def mockResponseWLS_RES_SUSPENDED = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLS_Suspended")
    * def mockResponseWLS_RES_ACTIVE = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLS_Active")
    * def mockResponseWLN_RES_ACTIVE = callonce read("../odsdata/getTestData_Consumer_Non_Prod.feature@getdata_resWLN_Active")
    * def mockResponseWLS_BIZ_ACTIVE = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLS")
    * def mockResponseWLN_BIZ_ACTIVE = callonce read("../odsdata/getTestData_Business_Non_Prod.feature@getdatabizWLN")
    * def data_file5 = 'tn_feature_data_morethan3acct.json'

  Scenario Outline: TC001_Get_CCE_tn_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file) |

  Scenario Outline: TC002_Get_CCE_kb_tn_Corp_customeraccount_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]

    #And match response.accountList[*].businessUnit == ["corp"]
    Examples: 
      | read('classpath:data/'+env+'/'+data_file1) |

  Scenario Outline: TC003_Validate Billing type and account type code for WLS_RES_ACTIVE_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].businessUnit == ["res"]
    And print response

    Examples: 
      | mockResponseWLS_RES_ACTIVE.mockResponseWLS_RES_ACTIVE |

  Scenario Outline: TC004_Validate account state for WLS_RES_SUSPENDED_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].state == ["suspended"]

    Examples: 
      | mockResponseWLS_RES_SUSPENDED.mockResponseWLS_RES_SUSPENDED |

  Scenario Outline: TC005_Validate account type code and business unit for WLN_RES_ACTIVE_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["R"]
    And match response.accountList[*].businessUnit == ["res"]

    Examples: 
      | mockResponseWLN_RES_ACTIVE.mockResponseWLN_RES_ACTIVE |

  Scenario Outline: TC006_Validate account type code and BU for WLS_BIZ_ACTIVE_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]

    Examples: 
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |

  Scenario Outline: TC007_Validate account type code, state and product type code for WLS_BIZ_ACTIVE_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].state == ["active"]
    And match response.accountList[*].products[*].productTypeCd == ["C"]

    Examples: 
      | mockResponseWLS_BIZ_ACTIVE.mockResponseWLS_BIZ_ACTIVE |

  Scenario Outline: TC008_Validate account type code for a WLS biz customer with more than 3 accounts via TN search.
    # This scenario can't be executed with dynamic data from Test API as it specifically tests for a suscriber count of more than 3
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file5) |

  Scenario Outline: TC009_Validate account type code and BU for a WLN_BIZ_ACTIVE_TN
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    When method get
    Then status 200
    #And match response.accountList[*].billingType == ["postpaid"]
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit == ["biz"]

    Examples: 
      | mockResponseWLN_BIZ_ACTIVE.mockResponseWLN_BIZ_ACTIVE |
