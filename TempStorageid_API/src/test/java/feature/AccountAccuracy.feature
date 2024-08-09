Feature: Validate account accuracy for tn/contact search update

  Background: 
    * url baseURL
    * configure ssl = true
    * header accept = 'application/json'
    * header env = env
    * header x-cloud-trace-context = 'karate-integration-test'
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * print authInfo.response.access_token
    * def data_file1 = 'tn_search_criteria1.json'
    * def data_file2 = 'tn_search_criteria2.json'
    * def data_file4 = 'tn_search_criteria4.json'
    * def data_file8 = 'tn_search_criteria8.json'

  @env=it01,it02,it03,it04
  Scenario Outline: account with exact tn match - criteria 1
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And assert response.accountList.length > 0
    And assert response.accountList[0].foundByContactSearch == false
    And assert response.accountList[0].accountMatchAccuracy == 100

    Examples: 
      | read('classpath:data/'+env+'/'+data_file1) |

  @env=it02,it04
  Scenario Outline: account with contact tn - criteria 2
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And assert response.accountList.length > 0
    And assert response.accountList[1].foundByContactSearch == true
    And assert response.accountList[1].accountMatchAccuracy == 85

    Examples: 
      | read('classpath:data/'+env+'/'+data_file2) |

  @env=it01,it02,it03,it04
  Scenario Outline: account with wireline contact tn - criteria 4
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 200
    And assert response.accountList.length == 1
    And assert response.accountList[0].foundByContactSearch == true
    And assert response.accountList[0].accountMatchAccuracy == 65

    Examples: 
      | read('classpath:data/'+env+'/'+data_file4) |

  @env=it01,it02,it03,it04
  Scenario Outline: account with contact tn zero percentage - criteria 8
    Given path 'customer/contactCenterCustomerInfo/v1/account'
    And param tn = '<request_tn>'
    When method get
    Then status 404

    Examples: 
      | read('classpath:data/'+env+'/'+data_file8) |
