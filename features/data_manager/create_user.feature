Feature:
  In order to work with clients
  As a Data Manager
  I want to create them
  Scenario: Create client
    Given I am logged in as a Data Manager
    When I click "Clients"
    And I click "Create new client"
    And I fill in the client information
    And I press "Create Client"
    Then I should see the client information
