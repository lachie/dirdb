Feature: file metadata
  In order to make us of a file
  As a developer
  I want to read its metadata

Scenario: reading special metadata
  Given a yaml file
  And the yaml metadata handler
  When I read the file with the yaml metadata handler
  Then I collect the yaml metadata