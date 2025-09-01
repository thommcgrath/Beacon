---
title: fetchPlayerIdentifier
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.fetchPlayerIdentifier(playerId, provider);
parameters:
  - name: playerId
    description: The Sentinel UUID of the desired player.
  - name: provider
    description: Currently the only supported provider is `EOS`, but expect a `Discord` provider in the future.
return:
  - type: String
    description: If the player was found and has an account for the request provider, returns an the account ID as a `String`. Returns `undefined` otherwise.
examples:
  - title: Fetch the Epic Online Services ID of the player that just joined the server
    code: "const playerEOSId = beacon.fetchPlayerIdentifier(beacon.eventData.playerId, 'EOS');"
seealso:
  - fetchPlayer
---
# {{page.title}}

Retrieves an account for a player.

> [Anonymous players](../../anonymousPlayers/) will have their identifiers hashed. These hashed identifiers will always start with `anon*`.

{% include sentinelfunction.markdown %}
