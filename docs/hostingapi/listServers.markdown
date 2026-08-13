---
title: List Servers
has_children: false
parent: Beacon Open Hosting API
nav_order: 0
---
# {{page.title}}

Beacon will send a `GET /servers` when it needs to retrieve a list servers the user has access to. The implementor should respond with an object containing a `servers` array, each member being an object. It is recommended to output the same object as the [Get Server Details](status) request for consistency, but this is not strictly required. For this reason, see the object structure described on that page for more detail.

## Example Exchange

### Request

```http
GET /servers HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "servers": [
    {
      "serverId": "bebb2aae-99bb-41be-b928-5374d6dabc61",
      "name": "Sample Cluster's Island Server",
      "status": "running",
      "game": {
        "id": "ArkSA",
        "map": "TheIsland_WP",
      },
      "platform": 999,
      "nickname": "Island",
      "ipAddress": 127.0.0.1,
      "port": 7777,
      "configPaths": {
        "Game.ini": "ShooterGame/Saved/Config/WindowsServer/Game.ini",
        "GameUserSettings.ini": "ShooterGame/Saved/Config/WindowsServer/GameUserSettings.ini"
      }
    }
  ]
}
```
