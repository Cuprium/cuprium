Feature:
  In order to accept loan applications
  As a Data Manager
  I want to create loan products
  Background: Logged in Data Manager
    Given I am logged in as a Data Manager
    When I click "Loan products"
  Scenario: Create named loan product
    Given I click "Create new loan product"
    When I fill in the product name with "Test product"
    And I press "Create Loan product"
    Then I should see "Test product"
    # Edit tbd
