---
title: fetchGroups
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchGroups();
return:
  - type: Array
    description: An array of [Group](../classes/group.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all groups the server belongs to
    code: "const groups = beacon.fetchGroups();"
---
# {{page.title}}

Retrieves all groups the server belongs to.

{% include sentinelfunction.markdown %}
