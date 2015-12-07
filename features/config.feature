Feature: You can use a config file to store configurations

  Background:
    Given a mocked home directory

  Scenario: Set an api-key to the config file
    Given the config file does not exist
    When I run `codewars config key my_secret_key`
    Then the output should contain exactly "You've successefully added the api-key to the configuration file"
    And the config file should contain exactly:
      """
      api_key: my_secret_key
      """

  Scenario: Set an api-key to the config file when there are another configurations
    Given the config file with:
      """
      language: ruby
      """
    When I run `codewars config key my_secret_key`
    Then the output should contain exactly "You've successefully added the api-key to the configuration file"
    And the config file should contain exactly:
      """
      language: ruby
      api_key: my_secret_key
      """

  Scenario: Change the api-key to the config file
    Given the config file with:
      """
      api_key: my_secret_key
      """
    When I run `codewars config key new_key`
    Then the output should contain exactly "You've successefully added the api-key to the configuration file"
    And the config file should contain exactly:
      """
      api_key: new_key
      """

  Scenario: Change the api-key to the config file when there are another configurations
    Given the config file with:
      """
      api_key: my_secret_key
      language: ruby
      """
    When I run `codewars config key new_key`
    Then the output should contain exactly "You've successefully added the api-key to the configuration file"
    And the config file should contain exactly:
      """
      api_key: new_key
      language: ruby
      """

  Scenario: Set a default language to the config file
    Given the config file does not exist
    When I run `codewars config language ruby`
    Then the output should contain exactly "You've successefully added the default language to the configuration file"
    And the config file should contain exactly:
      """
      language: ruby
      """

  Scenario: Set a default language to the config file when there are another configurations
    Given the config file with:
      """
      api_key: my_secret_key
      """
    When I run `codewars config language ruby`
    Then the output should contain exactly "You've successefully added the default language to the configuration file"
    And the config file should contain exactly:
      """
      api_key: my_secret_key
      language: ruby
      """

  Scenario: Change the default language to the config file
    Given the config file with:
      """
      language: javascript
      """
    When I run `codewars config language ruby`
    Then the output should contain exactly "You've successefully added the default language to the configuration file"
    And the config file should contain exactly:
      """
      language: ruby
      """

  Scenario: Change the default language to the config file when there are another configurations
    Given the config file with:
      """
      language: javascript
      api_key: my_secret_key
      """
    When I run `codewars config language ruby`
    Then the output should contain exactly "You've successefully added the default language to the configuration file"
    And the config file should contain exactly:
      """
      language: ruby
      api_key: my_secret_key
      """

  Scenario: Set several languages to the config file
    Given the config file with:
      """
      api_key: my_secret_key
      """
    When I run `codewars config language ruby,coffeescript`
    Then the output should contain exactly "You've successefully added the default language to the configuration file"
    And the config file should contain exactly:
      """
      api_key: my_secret_key
      language: ruby,coffeescript
      """
