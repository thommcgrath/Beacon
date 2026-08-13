---
title: Get Launch Options
has_children: false
parent: Beacon Open Hosting API
nav_order: 8
---
# {{page.title}}

Beacon will request launch options from the `GET /servers/{serverId}/launchOptions` endpoint.

## Chain And Flag Options

The first parameter of an Ark launch command is commonly called the "chain" as it is made up of a chain of parameters separated by question marks. Additional options that start with hyphens are included later. Beacon includes these in the `chain` and `flags` arrays respectively. Members of these arrays **should not** include their prefix or separator.

## Raw Launch Command

Your implementation may include a `raw` value in the response object, but Beacon will not use it. It reads the values from the `chain` and `flags` arrays instead.

## Example Exchange

### Request
```http
GET /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/launchOptions HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

```

### Response
```http
200 OK HTTP/1.1
Content-Type: application/json

{
  "raw": "\"TheIsland?listen?Port=7777?QueryPort=27015?MaxPlayers=20?RCONEnabled=True?RCONPort=27020?ServerPassword=?ServerAdminPassword=flexible?AllowHitMarkers=True?MaxTamedDinos=5000?OverrideOfficialDifficulty=4.5?OxygenSwimSpeedStatMultiplier=1?ServerCrosshair=True?SpectatorPassword=?TheMaxStructuresInRange=10500\" -server -log -NoGameAnalytics -NoBattlEye -servergamelog -servergamelogincludetribelogs -ServerRCONOutputTribeLogs -MULTIHOME=10.0.1.15",
  "chain": [
    "TheIsland",
    "listen",
    "Port=7777",
    "QueryPort=27015",
    "MaxPlayers=20"
    "RCONEnabled=True",
    "RCONPort=27020",
    "ServerPassword=",
    "ServerAdminPassword=flexible",
    "AllowHitMarkers=true",
    "MaxTamedDinos=5000",
    "OverrideOfficialDifficulty=4.5",
    "OxygenSwimSpeedStatMultiplier=1",
    "ServerCrosshair=True",
    "SpectatorPassword=",
    "TheMaxStructuresInRange=10500"
  ],
  "flags": [
    "server",
    "log",
    "NoGameAnalytics",
    "NoBattlEye",
    "servergamelog",
    "servergamelogincludetribelogs",
    "ServerRCONOutputTribeLogs",
    "MULTIHOME=10.0.1.15"
  ]
}
```
