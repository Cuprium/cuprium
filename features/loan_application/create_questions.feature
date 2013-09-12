Feature:
  In order to accept loan applications
  As a Data Manager
  I want to create application questions
  Background: Logged in Data Manager
    Given I am logged in as a Data Manager
    When I click "Loan products"
  Scenario: Create named loan product
    Given I click "Create new loan type"
    When I fill in the type name with "Test type"
    And I press "Save loan type"
    Then I should see "Test Type"
