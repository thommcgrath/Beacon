---
title: Get Server Details
has_children: false
parent: Beacon Open Hosting API
nav_order: 1
---
# {{page.title}}

Beacon will send the request `GET /servers/{serverId}` when it needs to retrieve the server's status, such as to show the status in the Servers editor, discovering the server for the first time, and to monitor restart progress.

Respond with a Server object as described below.

## Server Object

| Key | Type | Required | Description |
| -- | -- | -- | -- |
| serverId | String | Yes | Any kind of unique identifier for the server. A UUID is recommended, but numbers or IP+Port combinations would be acceptable as well as well as they are guaranteed not to change. Beacon will treat this as a **case-insensitive** string. |
| name | String | Yes | Any kind of detailed name the user would recognize. This is usually the server's in-game name. |
| status | String | Yes | The current state of the server. See the [Status Enum](#status-enum) below. |
| game | Object | Yes | An object describing the game and any game-specific values. See the [Game Object](#game-object) below. |
| platform | Number | No | Which player platforms the server allows to connect. Defaults to unknown. See the [Platform Enum](#platform-enum) below. |
| nickname | String | No | A shorter name to help the user more quickly recognize the server. For Ark clusters, this is often the map's name. |
| ipAddress | String | No | If both `ipAddress` and `port` are supplied, they will be shown to the user in the servers list. |
| port | Number | No | Same behavior as `ipAddress`. |
| configPaths | Object | No | Used to tell Beacon where to find the game's important config files. See the [Config Paths Object](#config-paths-object) below. |

## Status Enum

| Key | Notes |
| -- | -- |
| running | The server is active and ready to accept players. `started` may be used as an alias. |
| starting | The server is not yet ready to accept players. |
| stopped | The server is not active. |
| stopping | The server is in the process of shutting down. |
| suspended | The server is not active and cannot be started, usually due to lack of payment or terms of service violations. |
| updating | The server is installing a software update. |

## Game Object

The game object **must** contain an `id` entry with one of the following values:

| Game | Value |
| -- | -- |
| Ark: Survival Evolved | Ark |
| Ark: Survival Ascended | ArkSA |
| Palworld | Palworld |

Depending on the game, additional values may be required.

### Ark Servers

Both Ark: Survival Evolved and Ark: Survival Ascended servers **must** contain a `map` entry containing the official map identifier. See [ark.wiki.gg](https://ark.wiki.gg/wiki/Server_configuration#Maps) for the list of map identifiers.

## Platform Enum

| Platform | Value |
| -- | -- |
| Unknown | 0 |
| PC / Steam / Epic | 1 |
| Xbox / Windows Store | 2 |
| PlayStation | 3 |
| Switch | 4 |
| Universal | 999 |

## Config Paths Object

By default, Beacon will ask for a game's config file by name using the [Download a File](getFile) request. Should this behavior need to be overridden, the `configPaths` key can be used to customize the behavior.

For example, by default Beacon will attempt to download an Ark server's Game.ini file using the request `GET /servers/{serverId}/files/Game.ini`. If a `configPaths` object exists with a `Game.ini` entry whose value is `ShooterGame/Saved/Config/WindowsServer/Game.ini`, Beacon will attempt to download the file using `GET /servers/{serverId}/files/ShooterGame/Saved/Config/WindowsServer/Game.ini`.

See [Download a File](getFile#request-path-rules) documentation for path restrictions.

## Example Exchange

### Request

```http
GET /servers/bebb2aae-99bb-41be-b928-5374d6dabc61 HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

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
```
