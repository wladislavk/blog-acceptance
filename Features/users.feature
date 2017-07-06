Feature: User module
  Allow users to register, log in, log out and restore password

  Scenario: Log in and log out
    Given "admin" user exists
    And "nobody" is logged in
    When "home" page is loaded
    Then a link to "login" page is seen
    When "login" page is loaded
    Then a login form is seen
    When "admin" user login is entered in the form with password that is "correct"
    Then user is redirected to "home page" page
    And there is a UI element with greeting for "admin" user
    And user menu is seen
    And "logout" link is seen in user menu
    When "login" page is loaded
    Then user is redirected to "home page" page
    When "logout" link is clicked
    Then user is redirected to "login" page
    When "admin" user login is entered in the form with password that is "incorrect"
    Then "login" form is seen
    And "incorrect login or password" error is displayed
    When "nonexistent" user login is entered in the form with password that is "incorrect"
    Then "incorrect login or password" error is displayed

  Scenario: Restore password
    Given "admin" user exists
    And "nobody" is logged in
    When "login" page is loaded
    Then "restore password" link is seen
    When "restore password" link is clicked
    Then "restore password email" form is seen
    When "admin" user name is entered in restore password email form
    Then email comes to "admin" user email
    And email contains "restore password" link
    When "restore password" page is loaded with code from link
    Then "restore password" form is seen
    When "new" password is entered in restore password form
    Then success message is shown
    When "login" page is loaded
    And "admin" user login is entered in the form with password that is "new"
    Then user is redirected to "home page" page
