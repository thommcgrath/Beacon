---
title: Download a File
has_children: false
parent: Beacon Open Hosting API
nav_order: 3
---
# {{page.title}}

Beacon uses the `GET /servers/{serverId}/files/{path}` endpoint to download files. The file's contents should be included as the body of the response. Return a 404 status code if the file does not exist.

{% include hostapipathing.markdown %}

{% include hostapidigest.markdown %}

## Example Exchange

### Request
```http
GET /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/files/Game.ini HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com
Want-Content-Digest: sha-512=10,sha-256=9,md5=0,sha=0,unixsum=0,unixcksum=0,adler=0,crc32c=0

```

### Response
```http
HTTP/1.1 200 OK
Content-Digest: sha-512=:uBJBUBqFLk4jFu4qW1WVA4FRubafx1gnZEHDCEmaNyt+JJwrAyJX5l1mKIcFQKXijnkteHJy8FJGy1xjaWteAQ==:
Content-Type: application/octet-stream

[/script/shootergame.shootergamemode]
bUseSingleplayerSettings=False
```
