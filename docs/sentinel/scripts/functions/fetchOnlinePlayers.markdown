---
title: fetchOnlinePlayers
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchOnlinePlayers();
return:
  - type: Array
    description: An array of [Player](../classes/player.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all active players on the server
    code: "const players = beacon.fetchOnlinePlayers();"
seealso:
  - fetchPlayer
  - fetchOnlineCharacters
---
# {{page.title}}

Retrieves all players currently playing on the server.

{% include sentinelfunction.markdown %}
