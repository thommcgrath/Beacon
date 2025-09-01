---
title: decodeHex
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.decodeHex(hex);
parameters:
  - name: hex
    description: The hex-encoded content to decode.
return:
  - type: String
    description: The decoded binary data.
examples:
  - title: Decode a hello world message
    code: "const decoded = beacon.decodeHex('48656C6C6F20576F726C64');\nbeacon.debugPrint(decoded); // Outputs \"Hello World\""
seealso:
  - encodeHex
---
# {{page.title}}

Decodes hex content. 

{% include sentinelfunction.markdown %}
