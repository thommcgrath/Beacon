---
title: hash
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.hash(algorithm, input);
parameters:
  - name: algorithm
    type: String
    description: One of `md5`, `sha1`, `sha256`, `sha-256`, `sha2-256`, `sha512`, `sha-512`, `sha2-512`, `sha3-256`, or `sha3-512`. Some of these values are duplicates intended to be easier to remember.
  - name: input
    type: String
    description: The input value for the hashing algorithm.
return:
  - type: String
    description: The hashed input, hex encoded.
examples:
  - title: Generate a SHA256 hash of Hello World
    code: "const hash = beacon.hash('sha256', 'Hello World');\nbeacon.debugPrint(hash); // Outputs \"a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e\""
seealso:
  - hmac
restricted: true
---
# {{page.title}}

Generates a hash using from a variety of algorithms.

{% include sentinelfunction.markdown %}
