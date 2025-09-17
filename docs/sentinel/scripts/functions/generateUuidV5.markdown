---
title: generateUuidV5
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.generateUuidV5(namespace, value);
parameters:
  - name: namespace
    type: String
    description: Another UUID to use as a namespace. This adds uniqueness so that the same value will not produce the same output if differing namespaces are used.
  - name: value
    type: String
    description: The input value used to generate the UUID.
return:
  - type: String
    description: A v5 UUID
examples:
  - title: Generate a v5 UUID
    code: "const uuid = beacon.generateUuidV5('b3153bc4-0985-49e8-bbe9-65e7131a4a44', 'Hello World');\nbeacon.debugPrint(uuid); // Outputs \"a2996d78-5778-5298-8357-5f7bbe75a56f\""
seealso:
  - generateUuidV4
  - generateUuidV7
restricted: true
---
# {{page.title}}

Generates a v5 UUID, which is a UUID based on SHA hashing. Sentinel uses v5 UUIDs for many of its identifiers to make them predictable.

{% include sentinelfunction.markdown %}
