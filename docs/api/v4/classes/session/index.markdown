---
title: "Session"
parent: "Classes"
grand_parent: "Version 4"
has_children: false
apiVersion: 4
classPath: "sessions"
identifierProperty: "accessToken"
supportedInstanceMethods:
  - GET
  - DELETE
properties:
  - key: accessToken
    type: String
  - key: refreshToken
    type: String
  - key: accessTokenExpiration
    type: Timestamp
  - key: refreshTokenExpiration
    type: Timestamp
  - key: userId
    type: UUID
  - key: application
    type: Object
    notes: "Object containing keys `id`, `name`, and `website` which describe the authorized application."
  - key: scopes
    type: Array
    notes: "List of scopes the user has authorized"
---
# {{page.title}}

{% capture sample_object %}
{
  "accessToken": "4Il6iHU68VuZc3e7VrqksTu0UIC_8haalgYelsOn-Og",
  "refreshToken": "ARbbvXzPHjXGNQgHH4uRgBCrMp2hAcT_YVAIvENOVWg",
  "accessTokenExpiration": 1748468482,
  "refreshTokenExpiration": 1751056882,
  "userId": "e51fe8d0-3db2-40ec-9323-bbaeedfb6f1a",
  "application": {
    "id": "413d18e9-790c-4477-bcbe-ae31cf1227f0",
    "name": "Dingbot",
    "website": "https://jiinuko.edu/ehreg"
  },
  "scopes": [
    "common",
    "users:read"
  ]
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}

## Alias
The path `/v4/session` serves as an alias for `/v4/sessions/{sessionId}` to access the current session instance. This means requests `GET /v4/session` and `DELETE /v4/session` are valid requests to avoid unnecessarily repeating the access token in both the path and headers.