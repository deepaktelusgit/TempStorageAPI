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
    * def value = karate.callSingle('classpath:feature/TempStorage_a_POST.feature')
    * print authInfo.response.access_token
    * print value
    * def str1 = get[0] value..storage_id
    * print str1
    * def grp1 = get[0] value..group
    * print grp1
    * def str2 = get[1] value..storage_id
    * print str2
    * def grp2 = get[1] value..group
    * print grp2

  Scenario: TC001_TempStorage GET request by storageid and group.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+str1+'/retrieve'
    And param group = grp1
    When method get
    Then status 200
    And print response
    And match response.id == "it01-a-1"
    And match response.storageObject.name == "Deepak Rawat1"
    And match response.storageObject.sport.hockey == "good Garçon À la carte Maître d’hôtel"
    And match response.storageObject.sport.football == "better"

  Scenario: TC002_TempStorage GET JSON by key under multiple groups.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+str2+'/retrieve'
    # And param group = grp2
    When method get
    Then status 409
    #And match response.id == "it01-b-2"
    #And match response.storageObject.name == "Deepak Rawat1"
    #And match response.storageObject.sport.hockey == "good Garçon À la carte Maître d’hôtel"
    #And match response.storageObject.sport.football == "better"
    And print response

  Scenario: TC003_TempStorage GET JSON by Storageid while under only one group.
    Given path 'customer/contactCenterTempStorage/v1/storage/'+str1+'/retrieve'
    When method get
    Then status 200
    And match response.id == "it01-a-1"
    And match response.storageObject.name == "Deepak Rawat1"
    And match response.storageObject.sport.hockey == "good Garçon À la carte Maître d’hôtel"
    And match response.storageObject.sport.football == "better"
    And print response

  Scenario: TC004_TempStorage GET request with Storageid which is non existing.
    Given path 'customer/contactCenterTempStorage/v1/storage/101/retrieve'
    And param group = grp2
    And param ttl = '10000'
    When method get
    Then status 404
    And print response
