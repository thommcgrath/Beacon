---
title: Start a Backup
has_children: false
parent: Beacon Open Hosting API
backup: 7
---
# {{page.title}}

Beacon will trigger a server backup using the `POST /servers/{serverId}/backup` endpoint. Use the `level` key to determine what to back up. If the server's backup system allows for naming of backups, the `backupName` key will include the backup time in both UTC and the user's local time zone. The recommended response is a 204 No Content status.

## Backup Levels

| Key | Notes |
| -- | -- |
| full | Back up save data, config files, and anything else that can be backed up. |
| configOnly | Back up only the config files and related data, such as launch options. |
| saveOnly | Back up only the save data. |

## Example Exchange

### Request
```http
POST /servers/bebb2aae-99bb-41be-b928-5374d6dabc61/backup HTTP/1.1
Authorization: KEY secretToken
Host: api.example.com

{
  "backupName": "Beacon 2026-08-11 18:42:12 GMT (2:42 PM America/New_York)",
  "level": "configOnly"
}
```

### Response
```http
204 No Content HTTP/1.1

```
