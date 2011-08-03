Feature: Browsing the site
  
  Scenario: Someone enters to the website
    Given I am on the homepage
    Then I should see "Basecamp Status"

  @javascript
  Scenario: Should filter by name
    Given I am on the homepage
    Then I should see "first item"
    And I select "Orlando Del Aguila" from "names"
    Then "first item" should not be visible
