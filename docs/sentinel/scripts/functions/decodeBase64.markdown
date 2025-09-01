---
title: decodeBase64
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.decodeBase64(base64);
parameters:
  - name: base64
    description: The Base64-encoded content to decode.
return:
  - type: String
    description: The decoded binary data.
examples:
  - title: Decode a hello world message
    code: "const decoded = beacon.decodeBase64('SGVsbG8gV29ybGQ=');\nbeacon.debugPrint(decoded); // Outputs \"Hello World\""
seealso:
  - encodeBase64
  - decodeBase64Url
---
# {{page.title}}

Decodes Base64 content. Traditionally, JavaScript would use `atob` to decode Base64, but the function does not exist in Sentinel JavaScripts because there is no `window` object.

{% include sentinelfunction.markdown %}
