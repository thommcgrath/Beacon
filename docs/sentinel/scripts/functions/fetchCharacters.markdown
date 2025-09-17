---
title: fetchCharacters
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchCharacters();
  - beacon.fetchCharacters(playerId);
parameters:
  - name: playerId
    description: The Sentinel UUID of the desired player.
return:
  - type: Array
    description: An array of [Character](../classes/character.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all survivors on the server
    code: "const characters = beacon.fetchCharacters();"
  - title: Fetch survivors for a player that joined the server
    code: "const characters = beacon.fetchCharacters(beacon.eventData.playerId);"
seealso:
  - fetchCharacter
  - fetchOnlineCharacters
---
# {{page.title}}

Retrieves all survivors for the server. The optional `playerId` parameter allows the results to be filtered to a specific player. Remember that a player can have more than one survivor, though only one can be alive at a time.

{% include sentinelfunction.markdown %}
