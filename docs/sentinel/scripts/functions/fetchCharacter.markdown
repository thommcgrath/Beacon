---
title: fetchCharacter
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchCharacter(characterId);
parameters:
  - name: characterId
    description: The Sentinel UUID of the desired character / survivor.
return:
  - type: Object
    description: If the survivor was found, returns an object conforming to the [Character](../classes/character.html) class. Returns null if not found, which is rare, but possible.
examples:
  - title: Fetch a survivor that just died
    code: "const character = beacon.fetchCharacter(beacon.eventData.characterId);"
seealso:
  - fetchCharacters
  - fetchOnlineCharacters
---
# {{page.title}}

Retrieves a survivor from Sentinel's database.

{% include sentinelfunction.markdown %}
