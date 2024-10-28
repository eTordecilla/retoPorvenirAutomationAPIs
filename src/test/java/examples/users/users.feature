Feature: Users
  Background:
    * url 'https://reqres.in'

  Scenario: Get All users
    Given path '/api/users?page=2'
    When method get
    Then status 200

  Scenario: Create a user
    * def create_user_request =
    """
        {
         "name": "elkin",
         "job": "automation"
        }
    """
    Given path '/api/users'
    And request create_user_request
    When method post
    Then status 201

    * def userId = response.id
    * print 'user ID', userId
    * def expectedName = create_user_request.name
    * def expectedJob = create_user_request.job

    And match response.name == expectedName
    And match response.job == expectedJob

  Scenario: Update a user
    * def update_user_request =
    """
        {
         "name": "Elkin D",
         "job": "Leader Automation"
        }
    """
    Given path '/api/users/{userId}'
    And request update_user_request
    When method put
    Then status 200

  Scenario: Delete a user

    Given path '/api/users/{userId}'
    When method delete
    Then status 204
