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
    * def body = read ('classpath:data/it01/TempStoragePUT.json')
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

  Scenario: TC001_TempStorage PUT request.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id1+'/update'
    And param group = group_id1
    And param ttl = '10000'
    And request body
    And print body
    When method put
    Then status 200
    And print response

  Scenario: TC002_TempStorage GET request to validate the PUT request in above scenario.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id1+'/retrieve'
    And param group = group_id1
    When method get
    Then status 200
    And print response
    And match response.id == "it01-a-1"
    And match response.storageObject.name == "Rajat Doliya007"
    And match response.storageObject.sport.cricket == "good Garçon À la carte Maître d’hôtel"
    And match response.storageObject.sport.archery == "better"

  Scenario: TC003_TempStorage PUT request Update json without ttl.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id2+'/update'
    And param group = group_id2
    And request body
    When method put
    Then status 200
    And print response

  Scenario: TC004_TempStorage GET request to validate the PUT request in above scenario.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+storage_id2+'/retrieve'
    And param group = group_id2
    When method get
    Then status 200
    And print response
  #Scenario: TC003_TempStorage PUT request Update json without non existing storage id.
    #Given path 'customer/contactCenterTempStorage/v1/storage/101/update'
    #And param group = 'b'
    #And param ttl = '10000'
    #And request body
    #When method put
    #Then status 404
    #And print response
