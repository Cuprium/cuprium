Feature:
  In order to accept loan applications
  As a Data Manager
  I want to create application questions
  Background: Logged in Data Manager
    Given I am logged in as a Data Manager
    And loan product called "Test product" exists
    When I click "Loan products"
    And I click "Test product"
  Scenario: Create a question
    Given I click "Create question" 
    When I fill in the question details
    And I press "Create Question"
    Then I should see "Question created"
