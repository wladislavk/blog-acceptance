Feature: Main menu
  Main menu is displayed on top and displays all active links

  Scenario: Display menu
    Given main menu has following entries:
      | name | link |
    And "nobody" is logged in
    When "home page" is loaded
    Then these entries are seen:
      | name | link |
    When "about" page is loaded
    Then these entries are seen:
      | name | link |

  Scenario: Edit menu
    Given main menu has following entries:
      | name | link |
    And "admin" is logged in
    When "home page" page is loaded
    Then "edit menu" link is seen in user menu
    When "edit menu" link is clicked
    Then edit menu list with these entries is seen:
      | name | link |
    When menu entry "foo" with link "/foo" is added after "foo0"
    Then a list with these entries is seen:
      | name | link |
    When menu entry "foo" is renamed to "bar"
    Then a list with these entries is seen:
      | name | link |
    When menu entry "foo" is placed after "foo1"
    Then a list with these entries is seen:
      | name | link |
    When menu entry "foo" is deleted
    Then a list with these entries is seen:
      | name | link |

  Scenario: Anon user cannot edit menu
    Given "nobody" is logged in
    When "home page" page is loaded
    Then "edit menu" link is not seen in user menu
    When "edit menu" page is loaded
    Then user is redirected to "access forbidden" page
    When "edit menu" page is loaded
    And menu entry "foo" with link "/foo" is added after "foo0"
    Then user is redirected to "access forbidden" page
