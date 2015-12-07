Feature: Command 'train' without an argument

  Background:
    Given a mocked home directory

  Scenario: Does not work if a key and default langauge are not set
    Given the config file does not exist
    When I run `codewars train`
    Then the output should contain exactly:
      """
      You should set an api-key to use this command
      You should set an default language to use this command
      """

  Scenario: Does not work if a key is not set
    Given the config file with:
      """
      language: ruby
      """
    When I run `codewars train`
    Then the output should contain exactly:
      """
      You should set an api-key to use this command
      """

  Scenario: Does not work if a default language is not set
    Given the config file with:
      """
      api_key: my_secret_key
      """
    When I run `codewars train`
    Then the output should contain exactly:
      """
      You should set an default language to use this command
      """

  @stub_train_next_kata_peek_unauthorized
  Scenario: Does not work if the key is wrong
    Given the config file with:
      """
      api_key: wrong_key
      language: java
      """
    When I run `codewars train`
    Then the output should contain exactly:
      """
      Wrong api key
      """

  @stub_train_next_kata_peek
  Scenario: Train command shows some information about the next kata
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train`
    Then the output should contain:
      """
      Description: Your task is to program a function which converts
      """

  @stub_train_next_kata_peek
  Scenario: Train command shows information how to start the kata
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train`
    Then the output should contain:
      """
      Type to start this kata: codewars train anything-to-integer
      """

  @stub_train_next_kata_peek
  Scenario: Train command uses the first language when there are several languages in the config file
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java,ruby
      """
    When I run `codewars train`
    Then the output should contain:
      """
      Description: Your task is to program a function which converts
      """
