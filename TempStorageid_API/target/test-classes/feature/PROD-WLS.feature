@env=pr
Feature: Validate the response for different bans

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * header x-cloud-trace-context = 'karate-integration-test'
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file3 = 'ban_kb_Business_customer-account_pr_data.json'
    * def data_file9 = 'tn_ban_kb_corp_customer-account_feature_pr_data.json'
    * def data_file10 = 'ban_feature_pr_data_400.json'
    * def data_file11 = 'ban_feature_pr_data_404.json'
    * def data_file12 = 'tn_feature_pr_data_400.json'
    * def data_file13 = 'tn_feature_pr_data_404.json'
    * def data_file14 = 'tn_ban_feature_pr_data_400.json'
    * def data_file15 = 'tn_ban_feature_pr_data_404.json'
    * def data_file16 = 'tn_Kb_Consumer_Customer-account_feature_pr_data.json'

  Scenario Outline: TC001_Get_CCE_Ban_business_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["B"]
    And match response.accountList[*].businessUnit contains any ["biz", "res"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file3) |

  Scenario Outline: TC005_CCCI_API_GET_kb_tn_ban_Corp_customeraccount_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<tn>'
    And param ban = '<ban>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["C"]
    And match response.accountList[*].businessUnit == ["corp"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file9) |

  Scenario Outline: TC001_Get_CCE_Ban_Kb_Consumer_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd == ["I"]
    And match response.accountList[*].products[*].languageCd contains any ["EN","FR","CA","MA"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file16) |

  

  Scenario Outline: TC001_notfounderror_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 404

    Examples: 
      | read('classpath:data/'+env+'/'+data_file11) |
