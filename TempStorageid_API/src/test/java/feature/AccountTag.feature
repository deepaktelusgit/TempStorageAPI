@env=it01,it02,it03,it04
Feature: Validate SHS Account Tag Assignment

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * header x-cloud-trace-context = 'karate-integration-test'
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file1 = 'shs_only_product.json'
    * def data_file2 = 'shs_fibre_product.json'
 
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
