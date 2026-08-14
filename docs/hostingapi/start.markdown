---
title: Start a Server
has_children: false
parent: Beacon Open Hosting API
nav_order: 5
---
# {{page.title}}

Beacon will attempt to start a server using the `POST /servers/{serverId}/start` endpoint. The request body contains a message that the server may choose to log. The recommended response is a 204 No Content status.

## Example Exchange

### Request
```http
POST /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/start HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

{
  "logMessage": "Started by Beacon"
}
```

### Response
```http
HTTP/1.1 204 No Content

```
