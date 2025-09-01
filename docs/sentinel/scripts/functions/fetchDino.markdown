---
title: fetchDino
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchDino(dinoId);
parameters:
  - name: dinoId
    description: The Sentinel UUID of the desired dino.
return:
  - type: Object
    description: If the dino was found, returns an object conforming to the [Dino](../classes/dino.html) class. Returns null if not found, which is rare, but possible.
examples:
  - title: Fetch the dino that trigger one of the dino-oriented events
    code: "const dino = beacon.fetchDino(beacon.eventData.dinoId);"
seealso:
  - fetchDinos
---
# {{page.title}}

Retrieves a dino from Sentinel's database.

{% include sentinelfunction.markdown %}
