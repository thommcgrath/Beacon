---
title: fetchPlayer
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchPlayer(playerId);
parameters:
  - name: playerId
    description: The Sentinel UUID of the desired player.
return:
  - type: Object
    description: If the player was found, returns an object conforming to the [Player](../classes/player.html) class. Returns null if not found, which is rare, but possible.
examples:
  - title: Fetch the player that just joined the server
    code: "const player = beacon.fetchPlayer(beacon.eventData.playerId);"
seealso:
  - fetchCharacter
---
# {{page.title}}

Retrieves a player from Sentinel's database.

{% include sentinelfunction.markdown %}
