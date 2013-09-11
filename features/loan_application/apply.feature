Feature:
  In order to make a loan application
  As a Borrower
  I want to fill in my details
  Background: Start from public site
    Given I start from the home screen
  Scenario: Capture personal details
    Given I click "Make a loan application"
    When I fill in my details
    And I press "Next page"
    Then I should see "Page 2"
