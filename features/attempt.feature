Feature: Command 'attempt'

  Background:
    Given a mocked home directory
    And the config file with:
      """
      api_key: iT2dAoTLsv8tQe7KVLxe
      language: java
      """

  @stub_attempt_solution @stub_deferred_response
  Scenario: Attempt a valid solution
    Given a file "anything-to-integer/java/solution.java" with "solved_kata"
    And a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      Your solution has been uploaded. Waiting for a result of tests on the server.
      The solution has passed all tests on the server.
      Type to finalize the solution: codewars finalize
      """

  @stub_attempt_solution @stub_deferred_response_invalid
  Scenario: Attempt an invalid solution
    Given a file "anything-to-integer/java/solution.java" with "solved_kata"
    And a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      Your solution has been uploaded. Waiting for a result of tests on the server.
      The solution has not passed tests on the server. Response:
      -e: Value is not what was expected (Test::Error)
      """

  @stub_attempt_solution @stub_deferred_response_invalid
  Scenario: Filenames are case insesitive
    Given a file "anything-to-integer/java/SolutioN.Java" with "solved_kata"
    And a file "anything-to-integer/java/DescriptioN.MD" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain:
      """
      Your solution has been uploaded
      """

  Scenario: No description.md file when trying to attempt a solution
    Given a file "anything-to-integer/java/solution.java" with "solved_kata"
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      The file 'description.md' has not been found in the current directory.
      """

  Scenario: No solution file when trying to attempt a solution
    Given a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      The file 'solution.*' has not been found in the current directory.
      """

  Scenario: Project ID has not found when trying to attempt a solution
    Given a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And a file "anything-to-integer/java/solution.java" with "solved_kata"
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      'Project ID' has not been found in the 'description.md' file.
      """

  Scenario: Solution ID hasn't been found when trying to attempt a solution
    Given a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Other information
      """
    And a file "anything-to-integer/java/solution.java" with "solved_kata"
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      'Solution ID' has not been found in the 'description.md' file.
      """

  @stub_attempt_solution @stub_deferred_response_progress
  Scenario: Tests on the server are not responding when trying to attempt a solution
    Given a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And a file "anything-to-integer/java/solution.java" with "solved_kata"
    And I set the environment variable "CHECK_TIMEOUT" to "1"
    When I cd to "anything-to-integer/java/"
    And I run `codewars attempt`
    Then the output should contain exactly:
      """
      Your solution has been uploaded. Waiting for a result of tests on the server.
      Can't get a result of tests on the server. Try it again.
      """
