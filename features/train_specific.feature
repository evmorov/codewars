Feature: Command 'train' with an argument

  Background:
    Given a mocked home directory

  @stub_train_specific_kata
  Scenario: Passing a slug to 'train' prints a correct message
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train anything-to-integer`
    Then the output should contain:
      """
      Starting the 'anything-to-integer' kata.
      './anything-to-integer/java/description.md' has been created.
      './anything-to-integer/java/test.java' has been created.
      './anything-to-integer/java/solution.java' has been created.
      """

  @stub_train_specific_kata
  Scenario: Passing a slug to 'train' prints a correct message when there are several languages in the config
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java,ruby
      """
    When I run `codewars train anything-to-integer`
    Then the output should match:
      """
      Starting the 'anything-to-integer' kata.
      './anything-to-integer/\w+/description.md' has been created.
      './anything-to-integer/\w+/test.\w+' has been created.
      './anything-to-integer/\w+/solution.\w+' has been created.
      """

  @stub_train_specific_kata
  Scenario: Train with a slug creates necessary files
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train anything-to-integer`
    Then a directory "anything-to-integer" should exist
    And a file "anything-to-integer/java/description.md" should exist
    And a file "anything-to-integer/java/solution.java" should exist
    And a file "anything-to-integer/java/test.java" should exist

  @stub_train_specific_kata
  Scenario: Train with a slug creates right description.md
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train anything-to-integer`
    Then a file named "anything-to-integer/java/description.md" should contain exactly:
      """
      # Description of the kata

      Name: Anything to integer

      URL: http://www.codewars.com/kata/anything-to-integer

      Author: Jake Hoffner

      Rank: -6

      Slug: anything-to-integer

      Project ID: 523f66fba0de5d94410001cb

      Solution ID: 53bc968d35fd2feefd000013

      Tags: Fundamentals, Integers, Data Types, Numbers

      ## Task

      Your task is to program a function which converts

      ## Code

      ```java
      public String test(String str) {}
      ```

      ## Test

      ```java
      Test.expect(toInteger("4.55") === 4)
      ```
      """

  @stub_train_specific_kata
  Scenario: Train with a slug creates right 'code' file
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train anything-to-integer`
    Then a file named "anything-to-integer/java/solution.java" should contain exactly:
      """
      public String test(String str) {}
      """

  @stub_train_specific_kata
  Scenario: Train with a slug creates right 'test' file
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    When I run `codewars train anything-to-integer`
    Then a file named "anything-to-integer/java/test.java" should contain exactly:
      """
      Test.expect(toInteger("4.55") === 4)
      """

  @stub_train_specific_kata
  Scenario: Train with a slug warns if the file already exists
    Given the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """
    And an empty file "anything-to-integer/java/description.md"
    When I run `codewars train anything-to-integer`
    Then the output should contain:
      """
      Starting the 'anything-to-integer' kata.
      './anything-to-integer/java/description.md' already exists.
      """
