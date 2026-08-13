---
title: Upload a File
has_children: false
parent: Beacon Open Hosting API
nav_order: 4
---
# {{page.title}}

Beacon uploads files using the `PUT /servers/{serverId}/files/{path}` endpoint. The file's contents will be the body of the request. Although the server can reply with the updated content and a 200 status, Beacon will ignore the content of the response. For this reason, the recommended response is a 204 status.

### Security Notice

To prevent abuse, consider whitelisting file names. Although Beacon does not allow the uploading of arbitrary files, a malicious user could access your API directly to upload files. This could be problematic, especially if they choose to overwrite existing files.

{% include hostapipathing.markdown %}

{% include hostapidigest.markdown %}

## Example Exchange

### Request
```http
PUT /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/files/Game.ini HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com
Content-Type: application/octet-stream
Want-Content-Digest: sha-512=10,sha-256=9,md5=0,sha=0,unixsum=0,unixcksum=0,adler=0,crc32c=0
Content-Digest: sha-512=:uBJBUBqFLk4jFu4qW1WVA4FRubafx1gnZEHDCEmaNyt+JJwrAyJX5l1mKIcFQKXijnkteHJy8FJGy1xjaWteAQ==:,sha-256:VNmcFTIvjmomrm2jQLlx1rRqGmgmWloR3b8/fHCzy58=:

[/script/shootergame.shootergamemode]
bUseSingleplayerSettings=False
```

### Response
```http
HTTP/1.1 204 No Content

```
