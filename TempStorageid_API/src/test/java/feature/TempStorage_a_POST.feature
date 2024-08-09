@it01
Feature: Title of your feature
  I want to use this template for my feature file

  Background: 
    * url baseURL
    * configure ssl = true
    * header env = env
    * header Content-Type = 'application/json'
    * configure readTimeout = 20000
    * header Authorization = 'Bearer '+authInfo.response.access_token;
    * def body = read ('classpath:data/it01/TempStoragePOST.json')
    * def post_response = ''
    * def str = read ('classpath:data/it01/datastorage.csv')
    * print str
    * def storage_id1 = get[0] str..storage_id
    * print storage_id1
    * def storage_id2 = get[1] str..storage_id
    * print storage_id1
    * def grp = read ('classpath:data/it01/datagroup.csv')
    * def group_id1 = get[0] str..group
    * def group_id2 = get[1] str..group
    * print group_id1
    * print authInfo.response.access_token

  Scenario: TC001_TempStorage POST JSON with group and Storage id.
    * print storage_id1
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id1+'/create'
    And param group = group_id1
    And param ttl = '10000'
    And request body
    When method post
    Then status 201
    And print response

  Scenario: TC002_TempStorage POST JSON with another Storage id and same body.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id2+'/create'
    And print storage_id2
    And param group = group_id1
    And param ttl = '10000'
    And request body
    When method post
    Then status 201
    And print response

  Scenario: TC003_TempStorage POST JSON with another group id and same body.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id2+'/create'
    And print storage_id2
    And param group = group_id2
    And param ttl = '10000'
    And request body
    When method post
    Then status 201
    And print response
