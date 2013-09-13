Feature:
  In order to accept loan applications
  As a Data Manager
  I want to edit loan products
  Background: Logged in Data Manager
    Given I am logged in as a Data Manager
    And loan product called "Test product" exists
    When I click "Loan products"
  Scenario: Edit named loan product
    Given I click "Test product"
    # Note switch to show screen from index
    And I click "Test product"
    When I fill in the product name with "Test product 1"
    And I press "Update Loan product"
    Then I should see "Test product 1"
