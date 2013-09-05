Feature:
  In order to run client accounts
  As a Data Manager
  I want to record payments and withdrawals
  Background: Logged in Data Manager
    Given I am logged in as a Data Manager
    When I click "Payments/Withdrawals"
    And account "acc1234" has a balance of 2.00
  Scenario: Record payment
    Given I click "Payments in"
    And I search for "acc1234"
    And I click the first account
    And I enter 5.00 in payment amount
    When I press "Create Payment"
    Then I should see "Payment of &pound;5.00 made to acc1234"
    And I should see "Balance &pound;7.00"
 Scenario: Record withdrawal
    Given I click "Withdrawals"
    And I search for "acc1234"
    And I click the first account
    And I enter 1.00 in withdrawal amount
    When I press "Create Withdrawal"
    Then I should see "Withdrawal of &pound;1.00 made to acc1234"
    And I should see "Balance &pound;1.00"
 Scenario: Withdrawal over limit
    Given I click "Withdrawals"
    And I search for "acc1234"
    And I click the first account
    And I enter 3.00 in withdrawal amount
    When I press "Create Withdrawal"
    Then I should see :debit_balance_not_allowed
    And I should see "Balance &pound;2.00"

