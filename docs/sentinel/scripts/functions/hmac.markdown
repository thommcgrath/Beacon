---
title: hmac
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.hmac(algorithm, key, input);
parameters:
  - name: algorithm
    type: String
    description: One of `md5`, `sha1`, `sha256`, `sha-256`, `sha2-256`, `sha512`, `sha-512`, `sha2-512`, `sha3-256`, or `sha3-512`. Some of these values are duplicates intended to be easier to remember.
  - name: key
    type: String
    description: The **raw** key to use. Do not use an encoding.
  - name: input
    type: String
    description: The input value for the hashing algorithm.
return:
  - type: String
    description: The message signature, hex encoded.
examples:
  - title: Generate a SHA256 hash of Hello World
    code: "const signature = beacon.hmac('sha256', 'Password', 'Hello World');\nbeacon.debugPrint(signature); // Outputs \"25c8922af6ecd2eff0e67b107aca31f604b0cdf0ccc67379b007e315b07106a7\""
seealso:
  - hash
restricted: true
---
# {{page.title}}

Generates a hash-based message authentication code.

{% include sentinelfunction.markdown %}
