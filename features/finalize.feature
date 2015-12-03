Feature: Finalize command

Background:
  Given a mocked home directory
  And the config file with:
    """
    api_key: iT2dAoTLsv8tQe7KVLxe
    language: java
    """

  @stub_finalize_solution
  Scenario: Finalize command finalizes the solution
    Given a file "anything-to-integer/java/solution.java" with "solved_kata"
    And a file "anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Slug: anything-to-integer
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    When I cd to "anything-to-integer/java/"
    And I run `codewars finalize`
    Then the output should contain exactly:
      """
      Your solution has been finalized.
      Other solutions can be found here: http://www.codewars.com/kata/anything-to-integer/solutions/
      """
