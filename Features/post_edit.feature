Feature: Editing individual posts
  On show post page, admin user is shown a link to edit post page
  This page has a form for editing link, title, featured image and content
  Content field should properly parse HTML and convert line breaks to tags

  Scenario: Editing post
    Given a post exists with link "my-post"
    And post with link "my-post" has this data:
      | title   | image        |
      | My post | featured.jpg |
    And post body includes a formatting tag
    And post body includes more than one paragraph
    And "admin" is logged in
    When "view post" page is loaded with link "my-post"
    Then "edit post" link is seen
    When "edit post" link is clicked
    Then "edit post" form is loaded with link "my-post"
    And edit post form has preset data:
      | link    | title   | image        |
      | my-post | My post | featured.jpg |
    And formatting tag is parsed to HTML
    And paragraph tags are parsed to line breaks
    When edit form is filled with data:
      | link        | title       | image      |
      | edited-post | Edited post | edited.jpg |
    Then success message "post edited" is displayed
    And edit post form has preset data:
      | link        | title       | image      |
      | edited-post | Edited post | edited.jpg |
    When edit form is filled with data:
      | link          | title       | image      |
      | existing-post | Edited post | edited.jpg |
    Then error message "non-unique link" is displayed
    And edit post form has preset data:
      | link        | title       | image      |
      | edited-post | Edited post | edited.jpg |

  Scenario: Non-existent post cannot be edited
    Given a post does not exist with link "fake-post"
    And "admin" is logged in
    When "edit post" page is loaded with link "fake-post"
    Then user is redirected to "home page" page

  Scenario: Creating post
    Given "admin" is logged in
    When "home page" is loaded
    Then "create post" link is seen
    When "create post" page is loaded
    Then "edit post" form is loaded with link ""
    And edit post form has preset data:
      | link    | title   | image |
      |         |         |       |
    When edit form is filled with data:
      | link     | title    | image   |
      | new-post | New post | new.jpg |
    Then "edit post" form is loaded with link "new-post"
    And edit post form has preset data:
      | link     | title    | image   |
      | new-post | New post | new.jpg |
    When "view post" page is loaded with link "new-post"
    Then title "New post" is displayed
    And featured image "new.jpg" is displayed on top
    When "create post" page is loaded
    And edit form is filled with data:
      | link          | title    | image   |
      | existing-post | New post | new.jpg |
    Then error message "non-unique link" is displayed
    And edit post form has preset data:
      | link          | title    | image   |
      | existing-post | New post | new.jpg |

  Scenario: Deleting post
    Given a post exists with link "my-post"
    And "admin" is logged in
    When "delete post" page is loaded with link "fake-post"

  Scenario: Non-existent post cannot be deleted
    Given a post does not exist with link "fake-post"
    And "admin" is logged in
    When "edit post" page is loaded with link "my-post"
    Then "delete post" link is seen
    When "delete post" link is clicked
    Then user is redirected to "home page" page
    And success message "post deleted" is displayed

  Scenario: Anon user cannot create, edit or delete post
    Given a post exists with link "my-post"
    And "nobody" is logged in
    When "view post" page is loaded with link "my-post"
    Then "edit post" link is not seen
    When "edit post" page is loaded with link "my-post"
    Then user is redirected to "access forbidden" page
    When "home page" is loaded
    Then "create post" link is not seen
    When "create post" page is loaded
    Then user is redirected to "access forbidden" page
    When "delete post" page is loaded with link "my-post"
    Then user is redirected to "access forbidden" page
