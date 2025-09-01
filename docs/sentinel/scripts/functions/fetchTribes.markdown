---
title: fetchTribes
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchTribes();
return:
  - type: Array
    description: An array of [Tribe](../classes/tribe.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all tribes on the server
    code: "const tribes = beacon.fetchTribes();"
seealso:
  - fetchTribe
---
# {{page.title}}

Retrieves all tribes for the server.

{% include sentinelfunction.markdown %}
