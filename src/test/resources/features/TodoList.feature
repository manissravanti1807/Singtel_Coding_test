@manageTodoList
Feature: Manage To do List
  As a Lead of a team I wanted to manage my daily todo list

  Background: User navigates to todolist page and adds tasks to todo list
    Given I hit URL "https://todomvc.com/examples/vue/#/all"
    And I should see "TodoMVC" page
    When I enter a todo task
      | followup with dev team |
      | raise a bug            |
      | review test cases      |
      | retest bug             |
    Then I should see the entries of todolist in "All" filter
    And I should see "All" filter is displayed
    And I should see "Completed" filter is displayed
    And I should see "Active" filter is displayed
    And I shouldnot see "clear-completed" filter is displayed

  @working @complete @QA
  Scenario: Verify Active filter shows all the todo list tasks when nothing is set to completed
    Given I should see the entries of todolist in "All" filter
    When I click on "Active" filter
    Then I should see the entries of todolist in "Active" filter
    And I verify the task list in "All" filter and "Active" filter are equal
    When I click on cancel symbol for "followup with dev team" in the list
    Then I shouldnot see "followup with dev team" task in "Completed" list
    And I shouldnot see "followup with dev team" task in "Active" list
    And I shouldnot see "followup with dev team" task in "All" list

  @working @complete
  Scenario: Verify the completed filter functionality when tasks are set to completed
    Given I should see the entries of todolist in "All" filter
    And I count the displayed list items in "All" filter
    When I click on task on todo list
      | followup with dev team |
      | raise a bug            |
    And I click on "Completed" filter
    And I should see the entries of todolist in "Completed" filter
    And I shouldnot see "Completed" filter tasks in "Active" list
    When I click on cancel symbol for "followup with dev team" in the list
    Then I shouldnot see "followup with dev team" task in "Completed" list
    And I shouldnot see "followup with dev team" task in "Active" list
    And I shouldnot see "followup with dev team" task in "All" list
    And I should see "clear-completed" filter is displayed

  @worked
  Scenario: Validate the clear completed filter functionality
    Given I should see the entries of todolist in "All" filter
    And I count the displayed list items in "All" filter
    When I click on task on todo list
      | followup with dev team |
    And I click on "Completed" filter
    Then I should see "followup with dev team" task in "Completed" list
    And I click on "clear-completed" filter
    And I shouldnot see "followup with dev team" task in "Active" list
    And I shouldnot see "followup with dev team" task in "All" list
    And I shouldnot see "followup with dev team" task in "Completed" list
    And I shouldnot see "clear-completed" filter is displayed


  Scenario: Validate the All filter functionality
    Given I should see the entries of todolist in "All" filter
    And I count the displayed list items in "All" filter
    When I click on task on todo list
      | followup with dev team |
    Then I see the listSummary count is reduced by number of completed tasks in "All" filter
    And I click on "Completed" filter
    Then I should see "followup with dev team" task in "Completed" list
    And I click on "All" filter
    And I should see "followup with dev team" task in "All" list

  Scenario Outline: Validate list summary count for All and Active filter tasks

    Given I should see the entries of todolist in "<filter>" filter
    And I count the displayed list items in "<filter>" filter
    And I verify the list summary count in "All" filter is equal to list summary count in "Active" filter
    When I click on cancel symbol for "followup with dev team" in the list
    Then I verify the list summary count is updated in "<filter>" filter
    And I enter a todo task
      | attend meeting |
    And I verify the list summary count is updated in "<filter>" filter
    Examples:
      | filter |
      | All    |
      | Active |


  Scenario: Validate task completed toggle functionality

    Given I should see the entries of todolist in "All" filter
    And I count the displayed list items in "All" filter
    When I click on mark all as completed drop mark
    Then I should see the task list is marked to completed
    And I should see the entries of todolist in "Completed" filter
    And I shouldnot see the entries of todolist in "Active" filter
    When I click on mark all as completed drop mark
    Then I should see the entries of todolist in "Active" filter
    And I shouldnot see the entries of todolist in "Completed" filter


  Scenario: Validate edit task functionality
    Given I should see the entries of todolist in "All" filter
    When I edit the task "raise a bug" to "raise the bug"
    Then I should be able to see "raise the bug" task in the filter












