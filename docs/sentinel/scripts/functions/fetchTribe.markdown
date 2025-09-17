---
title: fetchTribe
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchTribe(tribeId);
parameters:
  - name: tribeId
    description: The Sentinel UUID of the desired tribe.
return:
  - type: Object
    description: If the tribe was found, returns an object conforming to the [Tribe](../classes/tribe.html) class. Returns null if not found, which is rare, but possible.
examples:
  - title: Fetch a the tribe for a survivor
    code: "let tribe;\nif (beacon.eventData.tribeId) {\n  tribe = beacon.fetchTribe(beacon.eventData.tribeId);\n} else {\n  const character = beacon.fetchCharacter(beacon.eventData.characterId);\n  tribe = beacon.fetchTribe(character.tribeId);\n}"
seealso:
  - fetchTribeDinos
  - fetchTribeMembers
---
# {{page.title}}

Retrieves a tribe from Sentinel's database.

{% include sentinelfunction.markdown %}
