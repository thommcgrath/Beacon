---
title: fetchOnlineCharacters
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchOnlineCharacters();
return:
  - type: Array
    description: An array of [Character](../classes/character.html) objects. It is possible for the array to be empty.
examples:
  - title: Fetch all active survivors on the server
    code: "const characters = beacon.fetchOnlineCharacters();"
seealso:
  - fetchCharacter
  - fetchCharacters
  - fetchOnlinePlayers
---
# {{page.title}}

Retrieves all currently active survivors for the server. This may include dead survivors if they have died and not respawned yet, but this function is guaranteed to return only one survivor per player that is currently playing on the server.

{% include sentinelfunction.markdown %}
