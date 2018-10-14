Feature: Table printer

  as a tester
  I want to be able to create gherkin tables from existing data frames

  @skip
  Scenario: simple index
    Given a gherkin table as input
      | str       | float     | str                 |
      | index_col | float_col | str_col             |
      | egg       | 3.0       | silly walks         |
      | spam      | 4.1       | spanish inquisition |
      | bacon     | 5.2       | dead parrot         |
    When converted to a data frame using 1 row as column names and 1 column as index
    And printed using data_frame_to_table
    Then it prints a valid string copy pasteable into gherkin files
      """
      | object    | float64   | object              |
      | index_col | float_col | str_col             |
      | egg       | 3.0       | silly walks         |
      | spam      | 4.1       | spanish inquisition |
      | bacon     | 5.2       | dead parrot         |
      """

  Scenario: table
    Given a table
      | index_col | float_col | str_col             |
      | egg       | 3.0       | silly walks         |
      | spam      | 4.1       | spanish inquisition |
      | bacon     | 5.2       | dead parrot         |
    And another table
      | index_col:str | float_col:float | str_col:str         |
      | egg           | 3.0             | silly walks         |
      | spam          | 4.1             | spanish inquisition |
      | bacon         | 5.2             | dead parrot         |
    Then it equals
      | index_col:str | float_col:float | str_col:str         |
      | eggy          | 3.0             | silly walks         |
      | spam          | 4.1             | spanish inquisition |
      | bacon         | 5.2             | dead parrot         |
