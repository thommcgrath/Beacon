# The Engram Object

Every item that Beacon knows about can be queried. Engrams can be added to mods using the API.

The endpoint is https://thezaz.com/beacon/api/engram.php

### Engram Class Strings

In Ark, the term "engram" means pretty much anything in the game that can be picked up. They have a class string that always ends in _C. This class string can be determined from the blueprint path rather easily. Just take the final part after the "." and append _C. For example, the blueprint for the Assault Rifle is

```
/Game/PrimalEarth/CoreBlueprints/Weapons/PrimalItem_WeaponRifle.PrimalItem_WeaponRifle
```

so the class string is `PrimalItem_WeaponRifle_C`.

Class strings are not case sensitive and must be unique across all mods and built-in content.

### Engram Structure

```json
{
  "class": "Prefix_MyEngram_C",
  "label": "My Engram",
  "environments": [
    "Island",
    "Scorched"
  ],
  "can_blueprint": true,
  "spawn": "cheat gfi myengram 1 0 false",
  "resource_url": "https://thezaz.com/beaon/api/engram.php/Prefix_MyEngram_C",
  "mod_id": 123456,
  "mod_name": "Example Mod"
}
```

| Key | Explanation |
| -- | -- |
| class | The unique class string for the engram |
| label | Human-readable/in-game name of the engram |
| environments | Array of strings of the supported environments. Current allowed values are `Island` and `Scorched` |
| can_blueprint | If this engram represents a resource, like wood or stone, that cannot be blueprinted, this value should be false. Craftable items, such as weapons and armor, should set this to true. |
| spawn | The admin code to summon the item |
| resource_url | API URL of this engram |
| mod_id | If this engram belongs to a mod, the id will be listed here. This value may be null |
| mod_name | If this engram belongs to a mod, the name will be listed here. This value may be null |

## GET

To list all engrams, perform a GET request directly to the endpoint:

```http
GET /beacon/api/engram.php HTTP/1.1
Host: thezaz.com

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
Host: thezaz.com

HTTP/1.1 200 OK
Content-Type: application/json
[
  { engram structure },
  { engram structure }
]
```

Perform a GET query against the `resource_url` value to get the structure for only that engram:

```http
GET /beacon/api/engram.php/Prefix_MyEngram_C HTTP/1.1
Host: thezaz.com

HTTP/1.1 200 OK
Content-Type: application/json

{ engram structure }
```

Or specify multiple engrams by using a comma-separated list:

```http
GET /beacon/api/engram.php/Prefix_MyEngram_C,Prefix_OtherEngram_C HTTP/1.1
Host: thezaz.com

HTTP/1.1 200 OK
Content-Type: application/json
[
  { engram structure },
  { engram structure }
]
```

## POST

Used for adding or updating engrams. Requires authentication. Allows partial structures. Required keys are `class`, `label`, `mod_id`, `availability` and `can_blueprint`. Other keys are allowed, but will be ignored. My post an array of structures or a single structure.

A 200 status will be returned on success.

```http
POST /beacon/api/engram.php HTTP/1.1
Host: thezaz.com
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjM0M0IzODYyRTY5M0RFNDRDNThCODA2NEVFMkVBOUZFMzA1QTY3QTk0MkMxRUNCQUQzMkQ0QzFFRDMwRjhCNTg3Mzg1NDM5QTZENzlFMkQwOEZGOEI3REJBQTA3MDI3MjM1RjEzQTE1NzA2ODUwMzEyMTA0MDRDM0RDM0M4QTY2NjJGQ0UwRkZCRjBENDM2QTMyMzU3Mjc5QzNBODBCQTQwOERGQTc4NzM3RTIwMTU0MjQ3MDMwNDI2QTIyNDI1RTY3MEU4RjZGQTA4MzFFRjM5RjY0NjczQTM2Nzg3RDgyNjc2OENEMkRBMDI0OTcxNUNFNDIxQjE1QkNGMjBFMEQ1QjI4M0E3MTZDRjIxNkY5MTM1QzEzMUUwRjM0QkQwNEQ5QkFFMTA5MDIzQzgzQkE2ODBERTQyMzA2MEFFMzc2RjQ0OEIxOUMyQkFDRTM4MDI0MEZBQzRBMzEzRTRDRDg3MTA2NjFGMUQyQUY4MTBDNjA2Q0IxMDBEQjhCRTk3REFFNDU3NERDMjNDNzYwQzFCREUwNDg1OEUzMUVEOUEwNzlDRjU4RkZFRjI2QjA4NkI3OEZEQjkzMzVDNzBBODM0RkUzQTk1RUUwNUQyNkUxNjY0MEFBODU5RDFBRkNDMTNBNDM3RDFBQ0Y0MDgxOERGQTZDQzM2RjdCMDVFNzFE
Content-Type: application/json

{"class":"Prefix_MyEngram_C","label":"My Engram","environments":["Island","Scorched"],"can_blueprint": true,"mod_id": 123456}

HTTP/1.1 200 OK
```

## DELETE

Deleting an engram completely removes it from the database. It is possible to the engram to be registered to a different mod after deletion.

Normal usage of this method is to issue an authenticated `DELETE` request to the `resource_url` key of the engram structure. It is possible to delete multiple engrams by separating the class strings with commas.

```http
DELETE /beacon/api/engram.php/Prefix_MyEngram_C,Prefix_OtherEngram_C HTTP/1.1
Host: thezaz.com
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjRCMjRBODIyQzAxQUZFRjlBNDY0MDg5RDI2MDU0NzZEQTMyOEM5QkMxMzk2QUU3QkFFQ0RBREQ3QjNGNkUwN0I2MTBEMzM3MUQ1RDRCN0QxMkNGRjgwMjUyNDI5RUZEREU0MTQ3OUFGMDMwQUE1MzVCQzZEMEQ1QzQ5OTY4RDc2Mzk2OTRDQzE3N0Q0MTYxNTk4QTk3MTI0OTgyRUE0RkI4MzVGRTg0MTQ2MjZDRDNBQzc2MkExQUIyNTU2MzVEM0JCNkJGQUIyRjY4MTVEQ0VCQjQxNUEwMDdCRUVGMTJCOTRCRjhGQzAyN0JBNERGQTVFQTNEODAzN0Q2MDY0RjlCQjZGNjk5MjcyQ0VFNjFCNzlGN0UyQUIwOEQwNDk5N0NBRjcxQjE2NEFBRjhDMjI4MjgyRjYxNTVENzdBMDE3QTE2NDc0MjAxOEY4MDkwNTRDNzQ3RTRENjJDODk4NDU0MUJCMUIxOTcwNzIxMTg0NDRDNEEzRjFDQjg0MzhEMjYxNDUxN0E0QTFDMzkyMjA3N0EwQzBDMUQ3Nzk3MUNGODI2RjdCMEU1REE5NDBCMUE0NEIzNUFDRDVDOUFCMDAxM0IzMTIyMjIyNzA1QzIyMjM5NjdCRUZFNUVFODI0NzdGMTNBRDExM0UzQUMzMjFBMTUyRDkwOTM2OUZFMUEw

HTTP/1.1 200 OK
```

To delete lots of engrams at the same time, send the comma-separated list of classes as the body of the DELETE request with a text/plain Content-Type. This option is allowed even if deleting only a single engram.

```http
DELETE /beacon/api/engram.php HTTP/1.1
Host: thezaz.com
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OkNDQjg3OUNGN0UxRThERUU4QThBMjAzRjM2OUE0Nzk5QjU5Q0Q0MUNERUE1RTRCODJDQ0VBMzhBMENCOTM0QjcxNzE0ODZFNDgwODc1QTg1MjExMTExMDlFNDY5M0NCQTRCMTIwMTU5MkRFMDJGMzRBODBBOUE3ODc2QTkyOERCNDQ5RERCRDI5RkJENTM2ODdGQUE3RUQ1QkRCRkJBQUZFRUQzMkNFRTJBREQ0NEU1QzRBQTdERjIyNkY3RDk4QTEyQkMxNkYxNTQ1RjhEM0QyOUJCQkI2NEUwNkFFNTYxQjUyNTBCREIxNEE0N0E3RkY1OTA4RUM0OERCRDZBNjU2NDlFMjZFNTMxREIxRjdGMzY4RTIyRjdEQTIyNzYzOEMyNzRCNkFBNTNDM0UwMzkzNjRBRDc0NjUxNzYxMDhGNUJCMDU5QTZEQzlBMDc4Mzc4RkUxOTVENDEzNEU0NTQ4Rjg3NzEyNkMwN0EyNkQ1NTNGOTc3MzE0QzNENjQyMDUyQUJFMjhCNkREQTA0NjJFNkZEQ0EyOTc2MzM5NEI2Q0NBMTJCNTIzRTBGNkRDRTE0QzFGRkFBMDYxNjYyQzNCNjNERTQwMTA2OTk5NzgzMDUzNjI5ODIyMjk4MEZCM0VCRTc2REVBRUZGQTIzQjY1NDM2OUIwOTM0RUQ0RjlE
Content-Type: text/plain

Prefix_MyEngram_C,Prefix_OtherEngram_C

HTTP/1.1 200 0K
```