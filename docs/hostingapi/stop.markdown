---
title: Stop a Server
has_children: false
parent: Beacon Open Hosting API
nav_order: 6
---
# {{page.title}}

Beacon will attempt to stop a server using the `POST /servers/{serverId}/stop` endpoint. The request body contains a message that the server may choose to log. If the server advertises that it supports stop messages, a stop message will be collected and included with the request body. The recommended response is a 204 No Content status.

## Example Exchange

### Request
```http
POST /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/stop HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

{
  "logMessage": "Started by Beacon",
  "announceMessage": "See you starside!"
}
```

### Response
```http
HTTP/1.1 204 No Content

```
