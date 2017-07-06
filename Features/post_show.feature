Feature: Displaying individual posts
  On individual post page, users see the post content with all HTML parsed properly

  Scenario: A non-static post is viewed
    Given a post exists with link "my-post"
    And post with link "my-post" belongs to "non-static" category
    And post with link "my-post" has this data:
      | title   | image        |
      | My post | featured.jpg |
    And post body includes a formatting tag
    And post body includes a hyperlink
    And post body includes an image
    And post body includes code
    And "nobody" is logged in
    When "view post" page is loaded with link "my-post"
    Then title "My post" is displayed
    And featured image "featured.jpg" is displayed on top
    And formatting tag is parsed properly
    And hyperlink is parsed properly
    And image is parsed properly
    And code is parsed properly
    And breadcrumbs display categories:
      | name       |
      | Home       |
      | non-static |

  Scenario: A static post is viewed
    Given a post exists with link "static-post"
    And post with link "my-post" belongs to "static" category
    And "nobody" is logged in
    When "view post" page is loaded with link "static-post"
    Then breadcrumbs display categories:
      | name       |
      | Home       |

  Scenario: Non-existent post cannot be viewed
    Given a post does not exist with link "fake-post"
    And "nobody" is logged in
    When "view post" page is loaded with link "fake-post"
    Then user is redirected to "home page" page
