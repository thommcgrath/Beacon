---
title: decodeBase64Url
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.decodeBase64Url(base64url);
parameters:
  - name: base64Url
    description: The Base64URL-encoded content to decode.
return:
  - type: String
    description: The decoded binary data.
examples:
  - title: Decode a hello world message
    code: "const decoded = beacon.decodeBase64Url('SGVsbG8gV29ybGQ');\nbeacon.debugPrint(decoded); // Outputs \"Hello World\""
seealso:
  - encodeBase64Url
  - decodeBase64
---
# {{page.title}}

Decodes Base64URL content. This is a version of Base64 that is safe for URLs without needing any additional encoding. See [base64.guru](https://base64.guru/standards/base64url){:target="_blank"} for more details.

{% include sentinelfunction.markdown %}
