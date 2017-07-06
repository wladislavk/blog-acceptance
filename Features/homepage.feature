Feature: Home page
  Home page displays shortened versions of latest posts and has links to all pages of the site

  Scenario: View home page
    Given "nobody" is logged in
    And website has following blog posts:
      | link | date       | category   |
      | foo  | 2017-01-30 | category 1 |
      | bar  | 2017-01-31 | category 2 |
      | baz  | 2017-01-28 | static     |
    When "home page" is loaded
    Then these blog posts are seen in descending date order:
      | link | date       | category   |
      | bar  | 2017-01-31 | category 2 |
      | foo  | 2017-01-30 | category 1 |
    And static posts are not included
    And there are links to pagination:
      | number | active |
      | 1      | 0      |
      | 2      | 1      |
    And for posts that have main picture it is seen just below the heading
    And all other content is shown before the more tag appears
    And HTML and hyperlinks are properly parsed
    And the more tag is converted into see more link that points to show post page
    When pagination link "2" is pressed
    Then blog posts from "11" to "15" are seen
    And there are links to pagination:
      | number | active |
      | 1      | 1      |
      | 2      | 0      |
