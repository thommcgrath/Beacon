---
title: List Files
has_children: false
parent: Beacon Open Hosting API
nav_order: 2
---
# {{page.title}}

Listing files is done with the `GET /servers/{serverId}/files` endpoint. Additional path parts can be appended to the end of the url for navigation. The endpoint should return a list of immediate descendants of the requested path. The implementor decides the root.

For example, if we were to use the Ark: Survival Ascended dedicated server as the root, a request for `/servers/{serverId}/files` would return:

| Engine |
| ShooterGame |
| Manifest_DebugFiles_Win64.txt |
| Manifest_NonUFSFiles_Win64.txt |
| Manifest_UFSFiles_Win64.txt |
| steamclient.dll |
| steamclient64.dll |
| steamwebrtc.dll |
| steamwebrtc64.dll |
| tier0_s.dll |
| tier0_s64.dll |
| vstdlib_s.dll |
| vstdlib_s64.dll |

A request to `/servers/{serverId}/files/ShooterGame` would return:

| .sentry-native |
| Binaries |
| Content |
| Plugins |
| Saved |

A request to `/servers/{serverId}/files/ShooterGame/Saved/Config/WindowsServer/Game.ini` would return the `Game.ini` content. See [Download a File](getFile) for more details about downloading files.

## Response Structure

The API response should be an object containing a `files` key as an array of file objects:

```json
{
  "files": [
    {
      "name": "Engine",
      "directory": true
    },
    {
      "name": "ShooterGame",
      "directory": true
    },
    {
      "name": "Manifest_DebugFiles_Win64.txt",
      "directory": false
    },
    ...
  ]
}
```

## Example Exchange

### Request

```http
GET /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/files/ShooterGame/Saved HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

```

### Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "files": [
    {
      "name: "Cache",
      "directory": true
    },
    {
      "name": "Config",
      "directory": true
    },
    {
      "name": "Crashes",
      "directory": true
    },
    {
      "name": "Logs",
      "directory": true
    },
    {
      "name": "SavedArks",
      "directory": true
    }
  ]
}
```

{% include hostapipathing.markdown %}
