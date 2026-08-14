---
title: Start a Backup
has_children: false
parent: Beacon Open Hosting API
backup: 7
---
# {{page.title}}

Beacon will trigger a server backup using the `POST /servers/{serverId}/backup` endpoint. Use the `level` key to determine what to back up. If the server's backup system allows for naming of backups, the `backupName` key will include the backup time in both UTC and the user's local time zone.

If the backup has finished by the time the response is generated, return a 200 or 204 status. If the backup has not yet finished, return a 202 status.

## Backup Levels

| Key | Notes |
| -- | -- |
| full | Back up save data, config files, and anything else that can be backed up. |
| configOnly | Back up only the config files and related data, such as launch options. |
| saveOnly | Back up only the save data. |

## Asynchronous Backups

Since creating a backup of save data can be a slow process, implementers may choose to run the backup in the background. In this case, return a 204 Accepted status along with a JSON object containing the `backupId` and `status` keys. The `backupId` can be any unique identifier chosen by the implementer, but a UUID is recommended. The status should be either `pending`, `completed`, or `failed`.

Beacon will poll `GET /backups/{backupId}` to wait for the job to finish before continuing the deployment process. The response structure should match the initial response. Return a 200 status code for this endpoint.

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

### Synchronous Response
```http
HTTP/1.1 204 No Content

```

### Asynchronous Response
```http
HTTP/1.1 202 Accepted
Content-Type: application/json

{
  "backupId": "88f5e5b0-7b76-4216-a39e-60db1d15796b",
  "status": "pending"
}
```

### Completed Response
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "backupId": "88f5e5b0-7b76-4216-a39e-60db1d15796b",
  "status": "completed"
}
```
