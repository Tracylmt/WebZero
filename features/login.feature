Feature: log into the website
    As a first time user
    I should be able to create a new account
    And later sign in with that account 

Background: Go to log in
    Given I am on the homepage 
    And I follow "Login"

Scenario: create a new account that has error
    When I follow "Sign up"
    Then I should see "Sign up"
    Then I fill in "Email" with "test"
    Then I fill in "Password" with "test"
    Then I fill in "Password confirmation" with "test"
    Then I press "Sign up"
    Then I should see "errors prohibited this user from being saved"

Scenario: create a valid new account 
    When I follow "Sign up"
    Then I should see "Sign up"
    Then I fill in "Email" with "test@test.com"
    Then I fill in "Password" with "123456"
    Then I fill in "Password confirmation" with "123456"
    Then I press "Sign up"
    Then I should see "Hello test@test.com"

Scenario: forgot password
    When I follow "Forgot your password"
    And I fill in "Email" with "test@test.com"
    And I press "Send me reset password instructions"
    Then I should see "1 error prohibited this user from being saved"

Scenario: log in 
    Given a valid user
    When I fill in "Email" with "test@test.com"
    And I fill in "Password" with "123456"
    And I check "Remember me"
    And I press "Log in"
    Then I should see "Hello test@test.com"