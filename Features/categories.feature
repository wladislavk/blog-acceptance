Feature: Blog categories
  Every post needs to be assigned a category to be shown
  Posts with static category are shown via direct links only, while other categories have their own list page
  Admin can access category management page to create, edit and delete categories
  Admin can change post category on post edit page

  Scenario: Display category list page
    Given category "first" has following blog posts:
      | link | date | category |
    And category "first" is not static
    And "nobody" is logged in
    When "first category" page is loaded
    Then these blog posts are seen in descending date order:
      | link | date       | category   |
    And there are links to pagination:
      | number | active |
      | 1      | 0      |
      | 2      | 1      |
    And for posts that have main picture it is seen just below the heading
    And all other content is shown before the more tag appears
    And HTML and hyperlinks are properly parsed
    And the more tag is converted into see more link that points to show post page

  Scenario: Static categories do not have their page
    Given category "static category" has following blog posts:
      | link | date | category |
    And category "static category" is static
    When "static category" page is loaded
    Then "404" error is displayed
    When "link to post" is accessed directly
    Then the post is displayed

  Scenario: Edit categories
    Given there are following categories:
      | category | link |
      | first    | foo  |
      | second   | bar  |
    And "admin" is logged in
    When "home page" page is loaded
    Then "edit categories" link is seen in user menu
    When "edit categories" link is clicked
    Then edit categories list with these entries is seen:
      | category | link |
      | first    | foo  |
      | second   | bar  |
    When category "third" with link "baz" is added
    Then edit categories list with these entries is seen:
      | category | link |
      | first    | foo  |
      | second   | bar  |
      | third    | baz  |
    When category "existing" with link "foo" is added
    Then error message "non-unique link" is displayed
    And edit categories list with these entries is seen:
      | category | link |
      | first    | foo  |
      | second   | bar  |
      | third    | baz  |
    When category "first" is renamed to "fourth"
    Then edit categories list with these entries is seen:
      | category | link |
      | fourth   | foo  |
      | second   | bar  |
      | third    | baz  |
    When category "third" is deleted
    Then edit categories list with these entries is seen:
      | category | link |
      | fourth   | foo  |
      | second   | bar  |

  Scenario: Anon user cannot edit categories
    Given "nobody" is logged in
    When "home page" page is loaded
    Then "edit categories" link is not seen in user menu
    When "edit categories" page is loaded
    Then user is redirected to "access forbidden" page
    When "edit categories" page is loaded
    And category "third" with link "baz" is added
    Then user is redirected to "access forbidden" page

  Scenario: Change post category
    Given a post exists with link "my-post"
    And post with link "my-post" belongs to category "foo"
    And a category exists with link "bar"
    And "admin" is logged in
    When "edit post" page is loaded with link "my-post"
    Then "category" form element is seen with value "foo"
    When category of post "my-post" is changed to "bar"
    Then success message "post edited" is displayed
    And "category" form element is seen with value "bar"
    When "bar" page is loaded
    Then post with link "my-post" can be seen

  Scenario: Category cannot be changed to non-existent
    Given a post exists with link "my-post"
    And post with link "my-post" belongs to category "foo"
    And a category does not exist with link "nonexistent"
    And "admin" is logged in
    When "edit post" page is loaded with link "my-post"
    When category of post "my-post" is changed to "nonexistent"
    Then error message "category does not exist" is displayed

  Scenario: Anon user cannot change post category
    Given a post exists with link "my-post"
    And "nobody" is logged in
    When category of post "my-post" is changed to "bar"
    Then user is redirected to "access forbidden" page
