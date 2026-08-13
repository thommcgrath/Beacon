---
title: Beacon Open Hosting API
has_children: true
nav_order: 8
has_toc: false
---
# {{page.title}}

The Beacon Open Hosting API is a JSON-based REST API developers can implement to allow their users to control their servers with Beacon.

## Getting Started

When a user wishes to link your service with their Beacon account, they need two things from you: **an authentication token** and **discovery endpoint**.

### Authentication Tokens

Beacon will use **static** authentication tokens. How they are created is entirely up to the implementor. A random string at least 64 of printable characters is recommended. Some implementors will prefix these tokens make their purpose more recognizable. The user's Beacon account will store these tokens encrypted at rest. The implementor may choose to make them expire, but it is recommended to keep their lifespan very long if not infinite. The user will need to delete and replace expired tokens, which is an inconvenience. The user's computer will make **all** requests to the API, so whitelisting the token to Beacon's IP addresses will be counter productive.

The authentication will be sent to the implementing server in the `Authorization` header using the `KEY` scheme. For example: `Authorization: KEY secretToken`.

## The Discovery Object

The very first thing Beacon will do is send a request to the provided discovery endpoint. The returned payload informs Beacon where to find the rest of the API endpoints. This allows relocation the API as needed, such as for versioning or region control. This request is authenticated, so the implementor may choose to send different discovery responses to different users.

The object returned by the discovery endpoint should conform to the following spec:

| Key | Type | Required | Description |
| -- | -- | -- | -- |
| baseUrl | String | Yes | The **full** base url to call for each request. Beacon will strip a trailing `/` from this value if it exists. |
| capabilities | Array | No | A list of features this API supports. If not included, all features are implicitly supported. See [Capabilities](#capabilities) below. |

### Capabilities

| Key | Notes |
| -- | -- |
| status | The host supports checking the status of the server.
| restarts | The host supports starting and stopping the server. Ignored if `status` is not included. |
| stopMessages | The host can send a customized stop message to the server when stopping. Ignored if `status` is not included. |
| fullBackups | The host can manually trigger a full backup of both the save data and config files. |
| configBackups | The host can manually trigger a backup of only config files. |
| saveBackups | The host can manually trigger a backup of only save data. |
| launchOptions | The host can both read and update server launch options, if the game supports them. |

## Example  Exchange

This exchange assumes the **discovery endpoint** given to the user is `https://api.example.com/discovery`.

### Request
```http
GET /discovery HTTP/1.1
Authorization: KEY secretToken
HOST: api.example.com

```

### Response
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "baseUrl": "https://api.example.com/v1",
  "capabilities": [
    "status",
    "restarts",
    "stopMessages",
    "fullBackups",
    "configBackups",
    "saveBackups",
    "launchOptions"
  ]
}
```

## Endpoint Map

These are the other endpoints the Beacon Open Hosting API will look for. The `baseUrl` value returned by the discovery endpoint will be prepended to each of the below paths. For example, if `baseUrl` equals `https://api.example.com/v1`, a request to list servers would be made to `https://api.example.com/v1/servers`.

| Purpose | Endpoint |
| -- | -- |
| [List Servers](listServers) | `GET /servers` |
| [Get Server Details](status) |  `GET /servers/{serverId}` |
| [List Files](listFiles) | `GET /servers/{serverId}/files` |
| [Download a File](getFile) | `GET /servers/{serverId}/files/{filePath}` |
| [Upload a File](putFile) | `PUT /servers/{serverId}/files/{filePath}` |
| [Start a Server](start) | `POST /servers/{serverId}/start` |
| [Stop a Server](stop) | `POST /servers/{serverId}/stop` |
| [Get Launch Options](getLaunchOptions) | `GET /servers/{serverId}/launchOptions` |
| [Set Launch Options](setLaunchOptions) | `PUT /servers/{serverId}/launchOptions` |
| [Start a Backup](backup) | `POST /servers/{serverId}/backup` |
