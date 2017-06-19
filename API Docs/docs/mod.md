# The Mod Object

Beacon supports Ark mods. Users adding mods must confirm ownership of the mod by modifying the mod's Steam page.

Authentication is required for all methods.

The endpoint is https://api.beaconapp.cc/v1/mod.php

### Mod Ownership

It is possible for two users to register the same mod. Both will have the same url, so the results of each query depend greatly on the authenticated user.

Once one user confirms ownership of the mod, no other user may register it. The unconfirmed versions of the mod will be removed from all other user accounts.

### Mod Structure

```json
{
  "mod_id": "123456",
  "name": "Example Mod",
  "workshop_url": "https://steamcommunity.com/sharedfiles/filedetails/?id=123456",
  "confirmed": true,
  "confirmation_code": "d1a02086-a274-4536-849f-3d294dafcf45",
  "resource_url": "https://api.beaconapp.cc/v1/mod.php/123456",
  "confirm_url": "https://api.beaconapp.cc/v1/mod.php/123456?action=confirm",
  "engrams_url": "https://api.beaconapp.cc/v1/engram.php?mod_id=123456",
  "spawncodes_url": "https://beaconapp.cc/spawn/?mod_id=123456",
  "pull_api": null
}
```

| Key | Explanation |
| -- | -- |
| mod_id | Steam Mod ID |
| name | Name of the mod |
| workshop_url | URL to the mod page |
| confirmed | If the mod has completed its confirmation process, this value will be true. Unconfirmed mods may be removed. |
| confirmation_code | The code that will be searched for on the Steam page. No, posting the code as a comment to another author's mod will not work. |
| resource_url | API URL of this mod |
| confirm_url | To attempt confirmation of this mod, perform an authenticated `GET` to this url. |
| engrams_url | Query the list of engrams for this mod using this url. |
| spawncodes_url | URL that can be published for users to look up spawn commands for this mod. |
| pull_url | The url that Beacon will automatically pull engrams from. See [Engrams Pull API](pull_api.md). May be null. |

## GET

To lookup a list of all your mods, perform a GET request directly to the endpoint: {

```http
GET /beacon/api/mod.php HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjJEMUZBNzkxRkRBNDZERjE3NEMzQTQ0MzkzMzZDOTI3QkVBNDc4M0QyMzZGNTYwOEE2RDg5OTRCMjA3NkI4ODRCQTI4NzNDRTI1NkMzQjQ0NzMzNzE0MTA0MzEyRjU4MTI2QjBGN0E5NUY4NzgwODg1OUQyOTI4QzM4NTUwMDBFMjNCNjEwMzZCMjhCOTAyNTUwOTBEMkVFRkVCODlFNUQyMjNFQ0U0Q0U1N0NDMEY3RkREOUI4Q0VCMDdGQkE5NTE3RjNBRkYxRUE1RjE2ODMzNDAxNDk1MzU4MUI0REYxNzI5QjQ0MjU2NjI0QTkwNDkyNjJBRUJDMzM0QTI1NUZFNjVGRDk3MjM5NjY3MkYwNEM4MDRDMEU0NDZFMzBBMEU5MDUyNjdBQkFGN0ZGMTU3OUE0RDQ1MjBCMTlGMzM5NzI3MEYxQ0UyOTQ5Q0JGMUJCQkY4MTU1NDY0QjRCNzU5Q0I3MUM1QTBDODdCOEY4MDk1RTZCREMxMDM4RkZBOUEzM0FCQ0JEQzk3NERBQjJDQkZCRDcyQTVBQ0EyMDk4MkQ1Rjg3OTk2QjIxNERERkQ2ODA4OEE4QTQ1RUNENTkzMjkzODM1N0U0QjIzODA2QUM0NzBEMUY5MEI4NjZDOUYxNDNFMzZCMkNDRUNGOTkzNTJDNkM3RkYzNjc4MThD

HTTP/1.1 200 OK
Content-Type: application/json

[
  { mod structure },
  { mod structure }
]
```

To lookup the status of one of your mods, perform a GET request to the endpoint + the mod id:

```http
GET /beacon/api/mod.php/123456 HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjVGMjRDNzRDNzI5OTcxQjVEOTBDNDlBREFCOUQ5RUIwQjYzNzQxNEMwM0E0OTY2RENBNUIzMUFENEM4MThBMTc2Njg5NzlFQ0FERjZBNENENUM2N0NEMzU1RUI1RDAwRjg5RjhGMjM2NjkxNDM0QTg1RTQ1NjY4NDFGRTk4NDdBMTkyMzBBOTAwOTc4NjYzQjVFMDU1RDBGQzBGQjhCQUVCNjhBQjk3QTU0MDc4N0RGQUJBOUU2MEU3RUE3QkVBNUZFQzhCMDZBQUMyMTlBRDlFNjY2RjJDQjk2NzZGQjE5REU2NjE0OUU3Qjc4MDMxRkE4REYzNjc0NEI4NDQ5OEY5RjE3RDEwNjcyQkFFNEI3NDZCMzQyMUNEMUNBMUM5MDhDNEMzRkEwRjJGQjZGN0M1QzE3ODcwRjYyOTM5NjNENzkyNERERUVGQUIwNDk0NEE3QUQzMjBDNjNFMjExNkEyREQwNEI1QUE5QjY1NjFCREY1OEQyRkU1QzYzRDAxQ0RCNzFGMjg4MUU1OTNEMzNFREQ0N0NDMkVDOTM3NUM4Q0QxNzlBODM4QUVFQzY0MjgxMjE2ODU0OUZEREZFQUM4M0Q0RTg3QTNDQTMwNkU5RDIxNjNBREUzRDk1QTVCQ0ZBQjI3QTlERjI2OUIyQUIzMzY1N0IwODg1NUFDRUJC

HTTP/1.1 200 OK
Content-Type: application/json

{ mod structure }
```

Will return a mod structure. Multiple mod ids are allowed and will return as many matches as possible:

```http
GET /beacon/api/mod.php/123456,654321 HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjM1RDU1RkEyNEI3MzEzRkJCMzFFMEMwMDFGREJBOEZCQzNGRkZENzc1QjVEOTkzQ0U5OURENjg4OTNBMUYyOTNBNUNFQkU5NEZENDg1Q0QxQTE1MEMwODNFQjI3NkNBRUUzMzJFMjlFMkZBMzkzQjU4OTVCRDVBQTdCNUEyMDA3RUIwNEUxRDYzRjVFNzg0RDM4NTZBMDVBQkYzQjVDRjU4RUYwQUE5QTIzM0I4ODc0MUUyQzJGNDRCQjBDQjNCOTU1MjM0MTE1NTIwQ0I5OTQ1N0M3ODU0NzhFMDVEMTEyREUwM0QwRUIwMzhGODVCOUQ0RDkxOTJBNTZDNDVGNTY2NjBBOUM2REY5MUMxNEZCNjg4NThERkRGNTlDNzFBMUU2RkYxOEVCODUwNDQ5RDQwODM1NUU3N0Y3MUZGNEYxNjYwQjMzQzk4M0MzMEU5OEY2NTg5ODhFMzhFOUQ1OEMxQkExQjQ3Qzk3RjNDREFBRkZBNTBEQzNFNTc2M0IwQjI4MjBGNEUzODg3N0FBRDY2M0E1OTBFQTIwOThDRTE2Njc5MTE5RTk5OUREOEMyRDE1RDRFMzVFOTc1Qzg0QjAwQTExMjI1QzBBQ0U1MUU5QUNEMDEzMkMyODkzRjk3MzVDQTQzNzhDREQ2RUM5RTVGOEIzQzIzMkZCNTAwQjlF

HTTP/1.1 200 OK
Content-Type: application/json

[
  { mod structure },
  { mod structure }
]
```

If none of the request mods can be found, a 404 error will be returned. The results of this query are different for every user, as this method will only list the authenticated user's mods.

## POST

Register one or more mods with Beacon. Allows partial mod structures. The only required key per structure is `mod_id`, though other keys are allowed but will be ignored. May post an array of structures or a single structure.

The mod must exist on Ark's Steam Workshop. Mods from other games will be treated as not found. An error will be trigger if you have already registered the mod, or if the mod is registered and confirmed by another user.

```http
POST /beacon/api/mod.php HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjI5MDM2NUM5ODg1OEM1NDJFNUYzQ0NFQUM1Q0JCNThGNjg1ODI0MDhFQTk3NzZFMTA4M0YzQzU1OTk1QTFDNTQxNkQzQTlBMjY4Qjc0OTMzN0E1RTU4QkQ5OTJGNzc2MTk3Q0NDNkIxQTI0RTg2RjE2QzJFMDA0REY2MzI5QkVCRjlFREUwQjM5MDc0MDQxRDNFRjI5MjNDRjJGMEFENjU2RTI2RDg0N0RBM0IxODg5MkY1Q0FDNUYyOEZGNUMyMTZCMEFFQzkwNjQ5MzczM0FBMDhBQjg2M0I4MUU5RkQ5NTM1NkEzNTg0N0Q5RTI0RTE0Nzg1MTA4RDNGRTJGMkIwQUJBNDlEOTlDNUQ5RjU0M0JGRDE3NENGMjU1Q0M1MzI4RDJGMjQ2QjlDN0EyRDQ2QzgzRENCM0Q2NkNGOUI0RDQ5RThCMzgwQTc2QjFEQjdCRTBBNjQ5MDk5QjhBRDU4QUZCM0NDOUY1MjAwODlEOUUyREZDRTA4OUMzQzcyQjAwMjI0MUNDMzdBMjUwMzQzNjExNTg4NDJFMUY2NUE4N0VFRjBBQzA3NjMyMDIwRDE2NkY2NzEyNkZBNzc2RTU4MzczQUIxRjNCMTJERTdBNjBFMkMwNzZCQkQ0QTNDQTExOUE5NUFGQTdFQjIxMzMzRUEwRjU5ODhENTA2NDhC
Content-Type: application/json

{"mod_id":"123456"}

HTTP/1.1 200 OK
```

## DELETE

Deleting a mod will completely remove if from the database, along with all associated engrams.

Normal usage of this method is to issue a `DELETE` request to the `resource_url` key of the mod structure. It is possible to delete multiple mods by separating the mod ids with commas.

```http
DELETE /beacon/api/mod.php/123456 HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjU5NEQ3QUUyQTg3NzhCMTNDNENCODI4OEFDNUQ5RDIxRTgyNjgwRkM1OEZCNkJBRkUzNDBFQzU5Nzg1MTk5MDhERDg1OEFCQzhBNjExODVCRTVBQ0MzMUQzN0IwOTFBQkY5MkQ3NDUyNUQ1RDM0NUQ5QzczNDMwRDI3NThGNDUwRTRCNjcxMjc2QUJFNEI4NzU5RDFCRkY3RTVDMTJDMTNEQUUwOUE3MDQyRkM2MjM4M0NDQjEyMzczM0YyQzJDM0EyQ0E2RTMwNDdEQkMwRjdCNkQwN0Y4ODA0REZGRkZBNzZENUZDODAyNTFEQkE3MzQyNTA5NDRBMTA5REM4RjAwN0ZENjc5RUEwNzI2RTg3MzU3RjcwMDc5REFDMjBFNDRDRTQzM0I5NDlFMjJDRUVBNUYxNjUzNUUyNkZDNTMzRTFEQ0RFRUZBQzZGRDZENEY4MThBQ0I2RkFBNDc2NzVDOTY0OTlFNzYxNDhGRTRDMThGMjlDQ0U2OTc5OTk3QUVDNTQ2NDAwRUUyQzQ2RjRENTkyNEU4NjI4RTQ4M0RFOTNDNzM5OEVCOTdDMDQ2NERBMTg0MzY4MzYzQzIyRUYyNTUzODExRjMxNDI0QTBFRDZFM0EzMjBEQUMyNzc5QkQ3NjQwQTE4NDVGQjEzNjZEMkQ3MDczMTAyQjY3NDNE

HTTP/1.1 200 OK
```

In the rare case that more mods need to be deleted than will fit into a url, use the request body with a Content-Type of text/plain. The body should be a comma-separated list of mods to delete. This option is allowed even if deleting only a single mod.

```http
DELETE /beacon/api/mod.php HTTP/1.1
Host: beaconapp.cc
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjNBNTAzNjRFMjRGQ0JDRkEyQUUxRjg4NEZBQzFGQTYwQjY1Q0Q2QzZBREY5QjlCRDI0RERFMTUyQjA1OTk1Mzk3NEYyQkYzM0U4MDJGRDgzMDFBQzlBQzQ0OTJDRDQ5Q0Y2QzA2NzUwQ0QzREQ1RDBGNEUyMUI0MEQ0MjQ4QThGOTg0NjVFNkVCNEVGQzYxMEQxRjc2QzE1NUEzNDNEMkZEQTVBMDk2Rjk5MjgzMERFRTY4NUYyRjg2NUUxNTA5OEM0Q0JDREJBMDcxMkQyQUQ5MzkwQkE1QjVERjY1MkRDNEU4RTRCNzhDRDFFNjY0NzlCOEIyNDEyOTEwMjg2Q0FGMjc0Mjc1MEQ0RTk3MDNEQkZGMjU0MjdBNkM3Q0JGRTMyQkI2ODJGRjMxMDBFNzQ5RjBCMEQyOTYzQjE0RTcyMDQxRTRDMEMwNTlBNUM3RjJDREFCODY1NTRGRkQ4NUI4REYyMEEyMDBGRTcwRDEzNTYzQUUxRUVFN0U1MUFGRkQzOTFDNERBQzMwQTY3MTdEQ0E1MkEwMTNCMjlFNDJFQzEyOUJFQTFGMjc0ODc2Q0RGNUY5QkYxQzdBMTMyQkUyNTAwQjNENjM1NDUyNDVGQkU1NTNERTU4MTU0QUJFNTQ4RkU4MjczNzU5ODIyMTgzQUNDMjg4RDMwMTM1MTRB
Content-Type: text/plain

123456,654321

HTTP/1.1 200 OK
```
