---
title: fetchTribeMembers
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchTribeMembers(tribeId);
parameters:
  - name: tribeId
    description: The Sentinel UUID of the desired tribe.
return:
  - type: Array
    description: An array of [Character](../classes/character.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all survivors on the for a tribe
    code: "const characters = beacon.fetchTribeMembers('b72a9dd3-1a64-52a2-8f9c-f90409c871f0');"
seealso:
  - fetchTribe
  - fetchTribeMembers
---
# {{page.title}}

Retrieves all survivors belonging to the tribe. This will include inactive survivors and survivors who have died.

{% include sentinelfunction.markdown %}
