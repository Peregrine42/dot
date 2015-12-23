Feature: basic operation

Scenario: getting all the nodes with a set of tags
  Given there are nodes
  And there are tags
  And there are links between those nodes and tags
  When I request a set of tags from the api
  Then I recieve the nodes as a list, grouped by tag