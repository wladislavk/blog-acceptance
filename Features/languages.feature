Feature: Enable support for at least two languages
  All pages and menus should be translatable and a language switch should be present on all pages

  Scenario: Switch language
    Given "nobody" is logged in
    When "about" page is loaded
    Then this text is shown "about in English"
    And a language switch is shown with these values:
      | language | active |
      | EN       | 1      |
      | RU       | 0      |
    When "RU" link is pressed in language switch
    Then this text is shown "about in Russian"
    And a language switch is shown with these values:
      | language | active |
      | EN       | 0      |
      | RU       | 1      |
    When "EN" link is pressed in language switch
    Then this text is shown "about in English"
    And a language switch is shown with these values:
      | language | active |
      | EN       | 1      |
      | RU       | 0      |

  Scenario: Switch language in non-translated page
    Given "nobody" is logged in
    And "non-translated" page exists
    When "non-translated" page is loaded
    Then this text is shown "non-translated in English"
    When "RU" link is pressed in language switch
    Then this text is shown "non-translated in English"

  Scenario: Translate page
    Given "admin" is logged in
    And "non-translated" page exists
    When "non-translated" page is loaded
    And current language is "RU"
    Then this text is shown "non-translated in English"
    When page contents are changed to "текст по-русски"
    Then this text is shown "текст по-русски"
