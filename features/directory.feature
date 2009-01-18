Feature: Scanning a directory
  In order to better use a directory of files
  As a developer
  I want to scan the directory

Scenario: Scanning a directory
  Given a directory of files
  And a dirdb of the directory
  When I access a file's information
  Then I get the file information

Scenario: Scanning new or changed files
  GivenScenario Scanning a directory
  Given I create a new file
  When I access a new file's information
  Then I get the new file information
