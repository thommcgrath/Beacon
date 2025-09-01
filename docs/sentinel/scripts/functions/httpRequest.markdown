---
title: httpRequest
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.hmac(requestMethod, url, [headers], [body]);
parameters:
  - name: requestMethod
    type: String
    description: The HTTP method, such as `GET`, `POST`, `HEAD`, `OPTIONS`, `PUT`, `DELETE`, and more. The function is not limited to these listed methods.
  - name: url
    type: String
    description: The URL to request. Sentinel scrips support only https URLs.
  - name: headers
    type: Object
    description: An object with header names for keys and the header value for values.
  - name: body
    type: String
    description: The data to send in the body of the request.
return:
  - type: Object
    description: An object containing the response details. `success` as boolean, `body` as string, `status` as number, and `headers` as object.
examples:
  - title: Make a POST request to an API
    code: "const headers = {\n    'Content-Type': 'application/json',\n    'Authorization': 'Bearer notARealToken',\n};\nconst body = JSON.stringify({\n    key: 'value',\n});\nconst url = 'https://api.example.com/v1/pretendToDoThing';\nconst response = beacon.httpRequest('POST', url, headers, body);\nif (response.success) {\n    beacon.debugPrint('It worked');\n} else {\n    beacon.debugPrint('It did not work');\n}"
restricted: true
---
# {{page.title}}

Make an HTTP request to an external service.

{% include sentinelfunction.markdown %}
