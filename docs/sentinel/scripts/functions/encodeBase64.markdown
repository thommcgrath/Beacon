---
title: encodeBase64
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.encodeBase64(binary);
parameters:
  - name: binary
    description: The raw binary content to encode.
return:
  - type: String
    description: The encoded ASCII-safe data.
examples:
  - title: Encode a hello world message
    code: "const encoded = beacon.encodeBase64('Hello World');\nbeacon.debugPrint(encoded); // Outputs \"SGVsbG8gV29ybGQ=\""
seealso:
  - decodeBase64
  - encodeBase64Url
---
# {{page.title}}

Encodes Base64 content. Traditionally, JavaScript would use `btoa` to encode binary data to Base64, but the function does not exist in Sentinel JavaScripts because there is no `window` object.

{% include sentinelfunction.markdown %}
