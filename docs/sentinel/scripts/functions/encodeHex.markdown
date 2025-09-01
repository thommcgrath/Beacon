---
title: encodeHex
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.encodeHex(binary);
parameters:
  - name: binary
    description: The raw binary content to encode.
return:
  - type: String
    description: The encoded ASCII-safe data.
examples:
  - title: Encode a hello world message
    code: "const encoded = beacon.encodeHex('Hello World');\nbeacon.debugPrint(encoded); // Outputs \"48656C6C6F20576F726C64\""
seealso:
  - decodeHex
---
# {{page.title}}

Encodes hex content. 

{% include sentinelfunction.markdown %}
