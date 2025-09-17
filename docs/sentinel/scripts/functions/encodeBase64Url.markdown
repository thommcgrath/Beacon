---
title: encodeBase64Url
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.encodeBase64Url(binary);
parameters:
  - name: binary
    description: The raw binary content to encode.
return:
  - type: String
    description: The encoded ASCII-safe data.
examples:
  - title: Encode a hello world message
    code: "const encoded = beacon.encodeBase64Url('Hello World');\nbeacon.debugPrint(encoded); // Outputs \"SGVsbG8gV29ybGQ\""
seealso:
  - decodeBase64Url
  - encodeBase64
---
# {{page.title}}

Encodes Base64URL content. This is a version of Base64 that is safe for URLs without needing any additional encoding. See [base64.guru](https://base64.guru/standards/base64url){:target="_blank"} for more details.

{% include sentinelfunction.markdown %}
