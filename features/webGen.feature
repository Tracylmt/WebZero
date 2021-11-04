Feature: generating a website
    After I logged in
    I should be able to upload a file
    And generate a website 

Background: log in
    Given I am on the homepage 
    And I follow "Login"
    And I am a valid user 
    And I fill in "Email" with "test@test.com"
    And I fill in "Password" with "123456"
    And I check "Remember me"
    And I press "Log in"
    Then I should see "Hello test@test.com"

Scenario: see previous website 
    When I follow "See some existing WebZero Build Websites"
    Then I should see "Websites"
    And I should see "Website address"
    And I should see "Username"

Scenario: upload 
    Given some file is selected
    And I press "Upload Resume"