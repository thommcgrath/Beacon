# The Engram Object

Every item that Beacon knows about can be queried. Engrams can be added to mods using the API.

The endpoint is https://api.beaconapp.cc/v1/engram.php

### Engram Structure

```json
{
  "path": "/Game/Mods/ExampleMod/MyEngram.MyEngram"
  "class": "Prefix_MyEngram_C",
  "label": "My Engram",
  "environments": [
    "Island",
    "Scorched"
  ],
  "can_blueprint": true,
  "harvestable": false,
  "spawn": "cheat giveitem \"Blueprint'/Game/Mods/ExampleMod/MyEngram.MyEngram'\" 1 0 false",
  "uid": "cfd291d28fa367397fa0273f07f1c46e",
  "resource_url": "https://api.beaconapp.cc/v1/engram/cfd291d28fa367397fa0273f07f1c46e",
  "mod_id": 123456,
  "mod_name": "Example Mod"
}
```

| Key | Explanation |
| -- | -- |
| path | The blueprint path for the engram. |
| class | The class string. Warning: this value may not be unique. |
| label | Human-readable/in-game name of the engram |
| environments | Array of strings of the supported environments. Current allowed values are `Island`, `Scorched`, `Center`, `Ragnarok`, and `Aberration`. |
| can_blueprint | If this engram represents a resource, like wood or stone, that cannot be blueprinted, this value should be false. Craftable items, such as weapons and armor, should set this to true. |
| harvestable | If this engram represents a resource that would be affected by harvest rate multipliers, this value should be true. |
| spawn | The admin code to summon the item |
| uid | Unique ID of this engram. This is the MD5 of the lowercase version of the path. |
| resource_url | API URL of this engram |
| mod_id | If this engram belongs to a mod, the id will be listed here. This value may be null |
| mod_name | If this engram belongs to a mod, the name will be listed here. This value may be null |

## GET

To list all engrams, perform a GET request directly to the endpoint:

```http
GET /beacon/api/engram.php HTTP/1.1
Host: beaconapp.cc

HTTP/1.1 200 OK
Content-Type: application/json

[
  { engram structure },
  { engram structure }
]
```

This also supports a `mod_id` parameter to limit the engram list to only specific mods. The value of this parameter must be one or more comma-separated Steam mod ids.

```http
GET /beacon/api/engram.php?mod_id=123456,654321 HTTP/1.1
Host: beaconapp.cc

HTTP/1.1 200 OK
Content-Type: application/json
[
  { engram structure },
  { engram structure }
]
```

Perform a GET query against the `resource_url` value to get the structure for only that engram:

```http
GET /beacon/api/engram.php/cfd291d28fa367397fa0273f07f1c46e HTTP/1.1
Host: beaconapp.cc

HTTP/1.1 200 OK
Content-Type: application/json

{ engram structure }
```

Or specify multiple engrams by using a comma-separated list:

```http
GET /beacon/api/engram.php/cfd291d28fa367397fa0273f07f1c46e,45c5cbac22ecac1e95792b36f516be71 HTTP/1.1
Host: beaconapp.cc

HTTP/1.1 200 OK
Content-Type: application/json
[
  { engram structure },
  { engram structure }
]
```

It is also possible to use class strings for a nicer url. However, if there are multiple matches, an array of results will be returned:

```http
GET /beacon/api/engram.php/Prefix_MyEngram_C HTTP/1.1
Host: beaconapp.cc

HTTP/1.1 200 OK
Content-Type: application/json

{ engram structure }
```

## POST

Used for adding or updating engrams. Requires authentication. Allows partial structures. Required keys are `path`, `label`, `mod_id`, `availability` and `can_blueprint`. Other keys are allowed, but will be ignored. My post an array of structures or a single structure.

A 200 status will be returned on success.

```http
POST /beacon/api/engram.php HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjM0M0IzODYyRTY5M0RFNDRDNThCODA2NEVFMkVBOUZFMzA1QTY3QTk0MkMxRUNCQUQzMkQ0QzFFRDMwRjhCNTg3Mzg1NDM5QTZENzlFMkQwOEZGOEI3REJBQTA3MDI3MjM1RjEzQTE1NzA2ODUwMzEyMTA0MDRDM0RDM0M4QTY2NjJGQ0UwRkZCRjBENDM2QTMyMzU3Mjc5QzNBODBCQTQwOERGQTc4NzM3RTIwMTU0MjQ3MDMwNDI2QTIyNDI1RTY3MEU4RjZGQTA4MzFFRjM5RjY0NjczQTM2Nzg3RDgyNjc2OENEMkRBMDI0OTcxNUNFNDIxQjE1QkNGMjBFMEQ1QjI4M0E3MTZDRjIxNkY5MTM1QzEzMUUwRjM0QkQwNEQ5QkFFMTA5MDIzQzgzQkE2ODBERTQyMzA2MEFFMzc2RjQ0OEIxOUMyQkFDRTM4MDI0MEZBQzRBMzEzRTRDRDg3MTA2NjFGMUQyQUY4MTBDNjA2Q0IxMDBEQjhCRTk3REFFNDU3NERDMjNDNzYwQzFCREUwNDg1OEUzMUVEOUEwNzlDRjU4RkZFRjI2QjA4NkI3OEZEQjkzMzVDNzBBODM0RkUzQTk1RUUwNUQyNkUxNjY0MEFBODU5RDFBRkNDMTNBNDM3RDFBQ0Y0MDgxOERGQTZDQzM2RjdCMDVFNzFE
Content-Type: application/json

{"path":"/Game/Mods/ExampleMod/MyEngram.MyEngram","label":"My Engram","environments":["Island","Scorched"],"can_blueprint":true,"harvestable":false,"mod_id":123456}

HTTP/1.1 200 OK
```

## DELETE

Deleting an engram completely removes it from the database. It is possible to the engram to be registered to a different mod after deletion.

Normal usage of this method is to issue an authenticated `DELETE` request to the `resource_url` key of the engram structure. It is possible to delete multiple engrams by separating the class strings with commas.

```http
DELETE /beacon/api/engram.php/cfd291d28fa367397fa0273f07f1c46e,45c5cbac22ecac1e95792b36f516be71 HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjRCMjRBODIyQzAxQUZFRjlBNDY0MDg5RDI2MDU0NzZEQTMyOEM5QkMxMzk2QUU3QkFFQ0RBREQ3QjNGNkUwN0I2MTBEMzM3MUQ1RDRCN0QxMkNGRjgwMjUyNDI5RUZEREU0MTQ3OUFGMDMwQUE1MzVCQzZEMEQ1QzQ5OTY4RDc2Mzk2OTRDQzE3N0Q0MTYxNTk4QTk3MTI0OTgyRUE0RkI4MzVGRTg0MTQ2MjZDRDNBQzc2MkExQUIyNTU2MzVEM0JCNkJGQUIyRjY4MTVEQ0VCQjQxNUEwMDdCRUVGMTJCOTRCRjhGQzAyN0JBNERGQTVFQTNEODAzN0Q2MDY0RjlCQjZGNjk5MjcyQ0VFNjFCNzlGN0UyQUIwOEQwNDk5N0NBRjcxQjE2NEFBRjhDMjI4MjgyRjYxNTVENzdBMDE3QTE2NDc0MjAxOEY4MDkwNTRDNzQ3RTRENjJDODk4NDU0MUJCMUIxOTcwNzIxMTg0NDRDNEEzRjFDQjg0MzhEMjYxNDUxN0E0QTFDMzkyMjA3N0EwQzBDMUQ3Nzk3MUNGODI2RjdCMEU1REE5NDBCMUE0NEIzNUFDRDVDOUFCMDAxM0IzMTIyMjIyNzA1QzIyMjM5NjdCRUZFNUVFODI0NzdGMTNBRDExM0UzQUMzMjFBMTUyRDkwOTM2OUZFMUEw

HTTP/1.1 200 OK
```

To delete lots of engrams at the same time, send the comma-separated list of classes as the body of the DELETE request with a text/plain Content-Type. This option is allowed even if deleting only a single engram.

```http
DELETE /beacon/api/engram.php HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OkNDQjg3OUNGN0UxRThERUU4QThBMjAzRjM2OUE0Nzk5QjU5Q0Q0MUNERUE1RTRCODJDQ0VBMzhBMENCOTM0QjcxNzE0ODZFNDgwODc1QTg1MjExMTExMDlFNDY5M0NCQTRCMTIwMTU5MkRFMDJGMzRBODBBOUE3ODc2QTkyOERCNDQ5RERCRDI5RkJENTM2ODdGQUE3RUQ1QkRCRkJBQUZFRUQzMkNFRTJBREQ0NEU1QzRBQTdERjIyNkY3RDk4QTEyQkMxNkYxNTQ1RjhEM0QyOUJCQkI2NEUwNkFFNTYxQjUyNTBCREIxNEE0N0E3RkY1OTA4RUM0OERCRDZBNjU2NDlFMjZFNTMxREIxRjdGMzY4RTIyRjdEQTIyNzYzOEMyNzRCNkFBNTNDM0UwMzkzNjRBRDc0NjUxNzYxMDhGNUJCMDU5QTZEQzlBMDc4Mzc4RkUxOTVENDEzNEU0NTQ4Rjg3NzEyNkMwN0EyNkQ1NTNGOTc3MzE0QzNENjQyMDUyQUJFMjhCNkREQTA0NjJFNkZEQ0EyOTc2MzM5NEI2Q0NBMTJCNTIzRTBGNkRDRTE0QzFGRkFBMDYxNjYyQzNCNjNERTQwMTA2OTk5NzgzMDUzNjI5ODIyMjk4MEZCM0VCRTc2REVBRUZGQTIzQjY1NDM2OUIwOTM0RUQ0RjlE
Content-Type: text/plain

cfd291d28fa367397fa0273f07f1c46e,45c5cbac22ecac1e95792b36f516be71

HTTP/1.1 200 0K
```