---
title: fetchPlayerIdentifiers
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchPlayerIdentifiers(playerId);
parameters:
  - name: playerId
    description: The Sentinel UUID of the desired player.
return:
  - type: Object
    description: If the player was found, returns an object of all known accounts, with the account provider as the keys and the account identifier as values. Returns `undefined` if the player was not found.
examples:
  - title: Privately provide a player all their identifiers via chat
    code: "const character = beacon.fetchCharacter(beacon.eventData.characterId);\nconst identifiers = beacon.fetchPlayerIdentifiers(beacon.eventData.playerId);\nconst providers = Object.keys(identifiers);\nproviders.forEach((provider) => {\n  beacon.sendChat(`${provider}: ${identifiers[provider]}`, {characterId: character.characterId});\n});"
seealso:
  - fetchPlayerIdentifier
---
# {{page.title}}

Retrieves an all accounts for a player.

> [Anonymous players](../../anonymousPlayers/) will have their identifiers hashed. These hashed identifiers will always start with `anon*`.

{% include sentinelfunction.markdown %}
