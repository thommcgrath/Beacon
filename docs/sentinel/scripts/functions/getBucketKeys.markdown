---
title: getBucketKeys
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.getBucketKeys(bucketId);
  - beacon.getBucketKeys(bucketId, playerId);
parameters:
  - name: bucketId
    type: String
    description: The UUID of the bucket to retrieve keys from.
  - name: playerId
    type: String
    description: Include this parameter for fetch all keys for the give player. If omitted, returns all non-player keys in the bucket.
return:
  - type: Array
    description: An array of keys. This array may be empty.
examples:
  - title: Fetch all non-player keys from a bucket
    code: "const keys = beacon.getBucketKeys('d7c0eee0-17bd-495d-88f6-16a815c36587')"
  - title: Fetch all keys from a bucket for a specific player
    code: "const keys = beacon.getBucketKeys('d7c0eee0-17bd-495d-88f6-16a815c36587', 'fc4c921c-ba83-4d1b-8470-a08fedf8246f')"
seealso:
  - getBucketValue
---
# {{page.title}}

Returns all keys in a bucket.

{% include sentinelfunction.markdown %}
