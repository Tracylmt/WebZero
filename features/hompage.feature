Feature: explore homepage 
    As a user who wants to generate a website based on my resume
    I need to navigate in the website 

Scenario: check homepage  
    Given I am on the homepage 
    Then I should see "Please login to upload your resume!"

Scenario: go to the About tab in homepage  
    Given I am on the homepage 
    When I follow "About"
    Then I should see "WebZero builds your first website!"

Scenario: go to log in page 
    Given I am on the homepage
    When I follow "Login"
    Then I should see "Log in"