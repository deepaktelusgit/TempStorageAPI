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
    * def data_file = 'tn_Cods_Consumer_Customer-account_feature_pr_data.json'
    * def data_file10 = 'ban_feature_pr_data_400.json'
    * def data_file11 = 'ban_feature_pr_data_404.json'
    * def data_file12 = 'tn_Contact_Search_logic_Change_data.json'
    * def data_file1 = 'shs_only_product.json'
    * def data_file2 = 'shs_fibre_product.json'

  Scenario Outline: TC003_CCCI_API_GET_Wireline_Consumer_TN_Accounts_200
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And match response.accountList[*].accountTypeCd contains any ["I","R"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file) |

  Scenario Outline: TC001_notfounderror_Get_CCE_Ban_Info
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<ban>'
    When method get
    Then status 400

    Examples: 
      | read('classpath:data/'+env+'/'+data_file10) |
      
  Scenario Outline: validate tn search account accuracy change
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And assert response.accountList.length > 0
    And assert response.accountList[0].foundByContactSearch == false
    And assert response.accountList[0].accountMatchAccuracy == 100
    And assert response.accountList[1].foundByContactSearch == true
    And assert response.accountList[1].accountMatchAccuracy >= 50
   
    Examples: 
      | read('classpath:data/'+env+'/'+data_file12) |
      
  Scenario Outline: Account with SHS only product
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<request_ban>'
    When method get
    Then status 200
    And assert response.accountList[0].domain == "wireline"
    And match response.accountList[0].accountTags contains ["SHS"]
    And match response.accountList[0].accountTags !contains ["NON_FIBRE"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file1) |

  Scenario Outline: Account with SHS and fibre product
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param ban = '<request_ban>'
    When method get
    Then status 200
    And assert response.accountList[0].domain == "wireline"
    And match response.accountList[0].accountTags contains ["SHS"]
    And match response.accountList[0].accountTags contains ["FIBRE"]

    Examples: 
      | read('classpath:data/'+env+'/'+data_file2) |
