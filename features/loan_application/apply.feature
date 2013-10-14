Feature:
  In order to make a loan application
  As a Borrower
  I want to fill in my details
  Background: Start from public site
    Given I start from the home screen
    And loan product called "test loan" exists
    And "test loan" has the question "test question"
  Scenario: Capture personal details
    Given I click "Make a loan application"
    And I click "test loan"
    When I fill in my details
    And I press "Next page"
    Then I should see "test question"
  Scenario: Answer single page and question
    Given personal details are recorded
    And I am on page 1 of "test loan"
    When I answer "test question" with "yes"
    And I press "Finish my application"
    Then I should see "thank you for your application"
  Scenario: Answer two pages
    Given this is pending
