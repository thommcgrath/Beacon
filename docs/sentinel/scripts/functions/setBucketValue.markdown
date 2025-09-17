---
title: setBucketValue
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.setBucketValue(bucketId, key, value);
  - beacon.setBucketValue(bucketId, key, value, playerId);
parameters:
  - name: bucketId
    type: String
    description: The UUID of the bucket to save a value to.
  - name: key
    type: String
    description: They key of the value to save.
  - name: value
    type: String
    description: The value to save.
  - name: playerId
    type: String
    description: Include this parameter to save the value for this player. Otherwise saves the value to the non-player scope.
examples:
  - title: Increment player kill count when a player dies to another player
    code: "const victimId = beacon.eventData.characterId;\nconst attacker = beacon.eventData.attacker;\nconst bucketId = 'd7c0eee0-17bd-495d-88f6-16a815c36587';\nif (attacker.kind === 'player') {\n  const attackerId = attacker.characterId;\n  const attackerCharacter = beacon.fetchCharacter(attackerId);\n  const attackerPlayerId = attackerCharacter.playerId;\n  const killCount = parseInt(beacon.getBucketValue(bucketId, 'killCount', attackerPlayerId) ?? 0);\n  beacon.setBucketValue(bucketId, 'killCount', attackerPlayerId, killCount + 1);\n}"
    notes: Because `getBucketValue` returns a string, we need to use `parseInt` to convert the string to a number. If the player has no value yet, the function will return null, so the null-coalescing operator (`??`) allows falling back to 0 instead.
seealso:
  - setBucketValue
---
# {{page.title}}

Saves a value to a [Bucket](/sentinel/buckets/).

All values are stored as strings.

{% include sentinelfunction.markdown %}
