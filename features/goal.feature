Feature: Goal
  As an airspace engineer
  I want to know how many

  Example Project to demonstrate that data science and cucumber fit.

  Scenario: First
    Given a falcon X rocket with an inertial measurement unit
    When it flew 10 times for each 10 hours
    Then the inertial measurement unit has a total of 100 operating hours

  Scenario: Second
    Given a gherkin table as input
      | a |
      | 1 |
    Then it equals
      | a |
      | 1 |

  Scenario: Third
    Given a gherkin table as input
      | a |
      | 1 |
    Then it not equals
      | a |
      | 2 |

  Scenario: Second
    Given a gherkin table as input
      | a : int |
      | 1       |
    Then it equals
      | a : str |
      | 1       |
