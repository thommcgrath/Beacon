---
title: getBucketValue
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.getBucketValue(bucketId, key);
  - beacon.getBucketValue(bucketId, key, playerId);
parameters:
  - name: bucketId
    type: String
    description: The UUID of the bucket to retrieve a value from.
  - name: key
    type: String
    description: They key of the value to fetch.
  - name: playerId
    type: String
    description: Include this parameter to fetch the value for this player. Otherwise fetches the non-player value for the key.
return:
  - type: String
    description: Returns the value, or `null` if there is no value.
examples:
  - title: Fetch the number of kills a player has
    code: "const killCount = parseInt(beacon.getBucketValue('d7c0eee0-17bd-495d-88f6-16a815c36587', 'killCount', 'fc4c921c-ba83-4d1b-8470-a08fedf8246f') ?? 0);"
    notes: Because `getBucketValue` returns a string, we need to use `parseInt` to convert the string to a number. If the player has no value yet, the function will return null, so the null-coalescing operator (`??`) allows falling back to 0 instead.
seealso:
  - setBucketValue
---
# {{page.title}}

Retrieves a value stored in a [Bucket](/sentinel/buckets/).

Since the value returned is either a string or null, care should be taken when dealing with numbers and booleans.

{% include sentinelfunction.markdown %}
