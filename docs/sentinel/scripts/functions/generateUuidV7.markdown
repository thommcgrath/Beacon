---
title: generateUuidV7
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.generateUuidV7();
return:
  - type: String
    description: A v7 UUID
examples:
  - title: Generate a v7 UUID
    code: beacon.generateUuidV7();
seealso:
  - generateUuidV4
  - generateUuidV5
restricted: true
---
# {{page.title}}

Generates a v7 UUID, which is a UUID with a time-based prefix and random suffix. Sentinel uses v7 UUIDs for its message UUIDs, as they are random yet sortable.

{% include sentinelfunction.markdown %}
