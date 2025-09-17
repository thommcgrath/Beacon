---
title: fetchDinos
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchDinos();
return:
  - type: Array
    description: An array of [Dino](../classes/dino.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all dinos on the server
    code: "const dinos = beacon.fetchDinos();"
seealso:
  - fetchDino
---
# {{page.title}}

Retrieves all tamed dinos for the server. This can potentially return a very large array.

{% include sentinelfunction.markdown %}
