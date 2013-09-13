Feature:
  In order to accept loan applications
  As a Data Manager
  I want to create application questions
  Background: Logged in Data Manager
    Given I am logged in as a Data Manager
    And loan product called "Test product" exists
    And loan product "Test product" has question "test question"
    When I click "Loan products"
    And I click "Test product"
  Scenario: Edit a question
    Given I click "test question" 
    When I update the question text to "test question amended"
    And I press "Update Question"
    Then I should see "test question amended"
