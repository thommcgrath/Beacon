---
title: fetchTribeDinos
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchTribeDinos(tribeId);
parameters:
  - name: tribeId
    description: The Sentinel UUID of the desired tribe.
return:
  - type: Array
    description: An array of [Dino](../classes/dino.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all dinos on the for a tribe
    code: "const dinos = beacon.fetchTribeDinos('b72a9dd3-1a64-52a2-8f9c-f90409c871f0');"
seealso:
  - fetchTribe
  - fetchTribeMembers
---
# {{page.title}}

Retrieves all tamed dinos belonging to the tribe.

{% include sentinelfunction.markdown %}
