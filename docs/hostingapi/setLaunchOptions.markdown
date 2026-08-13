---
title: Set Launch Options
has_children: false
parent: Beacon Open Hosting API
nav_order: 9
---
# {{page.title}}

Beacon sends launch options to the server using the `PUT /servers/{serverId}/launchOptions` endpoint. The body will contain the options as arrays of strings that can be concatenated together or looped through. No resonse body is necessary, so a 204 No Content response code is recommended.

## Chain And Flag Options

The first parameter of an Ark launch command is commonly called the "chain" as it is made up of a chain of parameters separated by question marks. Additional options that start with hyphens are included later. Beacon includes these in the `chain` and `flags` arrays respectively. Members of these arrays do **not** include their prefix or separator.

## Raw Launch Command

Beacon will include a `raw` value as well, which will contain a mostly-correct launch command. However, since Beacon does not ever touch certain identity parameters, such as `QueryPort` and `Port`, those will not be included. Therefore it is recommended to build your launch command from the included `chain` and `flags` array.

## Example Exchange

### Request
```http
PUT /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/launchOptions HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

{
  "raw": "\"TheIsland?listen?MaxPlayers=20?RCONEnabled=True?RCONPort=27020?ServerPassword=?ServerAdminPassword=flexible?AllowHitMarkers=True?MaxTamedDinos=5000?OverrideOfficialDifficulty=4.5?OxygenSwimSpeedStatMultiplier=1?ServerCrosshair=True?SpectatorPassword=?TheMaxStructuresInRange=10500\" -server -log -NoGameAnalytics -NoBattlEye -servergamelog -servergamelogincludetribelogs -ServerRCONOutputTribeLogs -MULTIHOME=10.0.1.15",
  "chain": [
    "TheIsland",
    "listen",
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

### Response
```http
204 No Content HTTP/1.1

```
