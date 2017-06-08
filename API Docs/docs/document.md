# The Document Object

Entire configurations can be stored in Beacon's cloud storage. All documents are available to all users, no document may be private.

Documents are special to the API. Listing documents returns an array of document metadata, while requesting a specific document returns the document content. This is different from the other API methods which list and lookup the same structures.

The endpoint is https://thezaz.com/beacon/api/document.php

### Document Metadata Structure

```json
{
  "document_id": "4e354678-a1b4-470f-8362-9e3446b5be3e",
  "user_id": "f08d5f69-214b-4e1c-910b-9ea57406f8c5",
  "name": "My Sample Document",
  "description": "This just a sample document, you probably shouldn't deploy it to your server.",
  "revision": 1,
  "download_count": 1,
  "last_updated": "2017-06-01 12:00:00+0000",
  "resource_url": "https://thezaz.com/beacon/api/document.php/4e354678-a1b4-470f-8362-9e3446b5be3e"
}
```

| Key | Explanation |
| -- | -- |
| document_id | Document UUID. This id is stored in the document content itself, so should never change. |
| user_id | The UUID of the user who published the document. |
| name | Document name. |
| description | Explanation about the document. |
| revision | Every time the document is updated, the revision value is incremented. Useful for comparing document versions. |
| download_count | Number of times the document has been downloaded. |
| last_updated | The last time the document was updated. Format is SQL with time zone. |
| resource_url | The url where the document contents can be downloaded. |

### Document Content

Beacon documents are currently JSON, so they are currely easily parseable. However, document format may change at any time and is not a supported part of the API. Document content is intended to be parseable by the Beacon app only. Parse document at your own risk.

## HEAD

A HEAD request to the endpoint + document uuid can be used to determine wether or not a document has been previously published. A 200 response means the document has been published, 404 response mean it has not been published, and a 405 response means there was a problem with the request. Querying the existence of multiple documents in a single request is not supported.

## GET

### Listing Documents

When listing documents, a number of parameters are available. Requests may use any combination of these parameters:

| Parameter | Explanation |
| -- | -- |
| user_id | Return only documents authored by this user UUID. |
| sort | Return results sorted by this value. Currently supported keys are `last_updated` and `download_count`. Default is `last_updated`. |
| direction | May be either `desc` for descending or `asc` for ascending. Default is `desc`. |
| count | Return only this many results. |
| offset | Skip this many results. Most useful with `count`. For example, count=10 and offset=10 returns results 11-20. |

### Multiple Documents

Use a comma-separated list of document uuids to request the metadata for two or more specific documents.

```http
GET /beacon/api/document.php/4e354678-a1b4-470f-8362-9e3446b5be3e,9aa9daf9-a3b4-4f3d-8e3c-3aa165603ae6 HTTP/1.1
Host: thezaz.com

HTTP/1.1 200 OK
Content-Type: application/json

[
  { document metadata structure }
  { document metadata structure }
]
```

### Single Document

Requesting a single document returns the full document content and increments the download count.

```http
GET /beacon/api/document.php/4e354678-a1b4-470f-8362-9e3446b5be3e HTTP/1.1
Host: thezaz.com

HTTP/1.1 200 OK
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="My Sample Document.beacon"

Document Content
```

To request the metadata for the document, append the `?simple` suffix.

```http
GET /beacon/api/document.php/4e354678-a1b4-470f-8362-9e3446b5be3e?simple HTTP/1.1
Host: thezaz.com

HTTP/1.1 200 OK
Content-Type: application/json

{ document metadata structure }
```

## POST

To save or update a document, make an authenticated POST to the endpoint whose body is either a single document or array of documents.

```http
POST /beacon/api/document.php HTTP/1.1
Host: thezaz.com
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjgzNUY1MDk0MDYyREVFQjc2NDU2Rjc1MUE5MUY2NzRERkNCQkM5OEQ0RUZFMUMxQjUxNjk0M0Y2MjcxNjFGQkY0QzBEMjc2ODE0Nzk5NzdCOEM0QTRGNUVGMUJFQzg3NjZFQUU3MjcyNzg3RDlENTFEQTIxRjczOTMxRjU4QTdFNDUxNDcxQjJCNTE5OENDRkYzMUZFOUQ2NDUwMUY5MjgwMjkzMkI2MEYyOUIwRkE0QUQwODU1MzQ5RTE1RDc4ODRFMzIxN0RCRUY3MEJGNjg4QjBDRDEwQUMyNDNGNzAyOEM1RjAxOEJGQTJBQkEwQzVBQ0M4NzUzRjVBMjAzMzQ2MkMzQTYwQ0IyRjlBNkIxM0VBQ0M2RDI2NENCNDkxOTFFQzVGQTM1QkZBQzZCNDQ4MDQwMzE2NUE4RDRCOThFRTM3RjA3Mzk3MjM4MTc1REYyOTA3Mzk4RjZENjNGRDA3Rjc4QzZGRTA0NTVFODAxMUM0REE5QTY2Mjk0QUEzMzIzQzIxRjY0QTU1MzMyQTQ0RTg0MTIxQ0JGNTdBRkQ3QzlDOTExMkU0NTMyQjFFMTUyMTRGQUI0M0Y1MDlCNTcwNzMyRjhDMEYwQUIzQTIyNkQ4QzBEODJFQzZDOUM5MThDNjQ0MTc5MERERTJBRUVGQjBDMDlCN0U4RUNDMjg1
Content-Type: application/json

{"Description":"This just a sample document, you probably shouldn't deploy it to your server.","Identifier":"4e354678-a1b4-470f-8362-9e3446b5be3e","LootSources":[],"Title":"My Sample Document","Version":2}

HTTP/1.1 200 OK
```

## DELETE

Removing documents will delete all statistics as well. To delete a document, make an authenticated DELETE to the document address. Multiple documents may be deleted by separating document uuids with commas. If more documents need to be deleted than will fit into a URL, the comma-separated uuid list may be placed in the request body with a content type of text/plain.

```http
DELETE /beacon/api/document.php/4e354678-a1b4-470f-8362-9e3446b5be3e HTTP/1.1
Host: thezaz.com
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OjNCMEJBREM5QTM1RTFFMDI5QzJGMzRBQTBDMDJBOUM1NzA2REE2MEY0QTc5Njg1RjkwQjdEODZCOTA5RjYzRkUyMzBEQjIyMTY4RTRGRTFCNUE5RUZCMzQ1QTNENUE0QkM0QkY0RjVGODI1MzI3MDE1RTkwRTVCMDNBMDhFOTRENkY3RkE4NjY2OEFDRTlFNkY4M0NFQTY1ODkyMEIwOTRFMjc1OTNGNzA5QjkwNEVEMEFERDQzNTEzQkU5Rjk1MTY0OThGRTU1NzcxNTQ5MzE5MEE2RDFCMzEwRUM5MTkzMEVEMDdCQTZCMzMzMEYyRUUzMDg1RjlGOUVCRjdFNUNCNTQxNzdGNjNBOEEyNTU0MUNDOUZGMDUzNEVEQkRGNzhBREVGOTJBN0E1Q0RBREU2MDM5Qzg1NkJGRjRDQzBBNUM4MDMxN0ZGRENBNDE1QzcxRjEwRUM2NjdBRUFCMTJGQjVFQjg2Njc2RUFDMEEzMDFFREMxRUEyQzkwQkVBNzdCREM3QTY4MzI1ODVCQkFCQkI2NTVBMTZEQzJFNDFFNTk5MUZDQTQxRTBFNzUxNDNFRDUyMTY2QUVEOTJGQTc0RjVCMUQ4MkU4MTAzRDFBNzlDRjUxQjMxOEUyMUQ1REYxREE0MDNDRjU3QjM4RUU2NTU5QTBBQTYwMTQwNzNE

HTTP/1.1 200 OK
```
Or
```http
DELETE /beacon/api/document.php HTTP/1.1
Host: thezaz.com
Authorization: Basic QTcwRjNENjAtQTI4MS00QzQ1LTgwQTAtQUQ2OUI3MzhENTY4OkFERDIzQjc0OEEzNjE0REJGMUI4NTZCRTg0MUI0RDdBQUI3N0I1RTMwNkFBNjU3RjRFOTI3Mzk5NDI4QkE2QzQ2MzQ0Mjc2RTIxRDk3MDQyQUFENEU2QTVFRjgxMjNDN0Y1MkY3NkU5Njk5MjIyMjMxN0VFNkFDOEIxOUIzMTA4QUUyREVDOEZFRDM4NDZFRTdERUJCNjg1RkI2MzI2N0NFNDNENkE2MDVCQjkwNzI0RjczQjVBMzA4MDdBNkY5MTkwODU3MTNERUZBRkUwQzMxNkEyQzQzQzAwOTMxRDc4MDE2NjM2RDRCNDc2NjE5QUZEMUNFMTQ0MjE4OTU4RTdDMUZCMjE2MTc5NTkwRDFDREM2NjE0OThCQzAzNzRCMDlFRTQ5OTU1NEFGRDZCNzg5QTczNURFRkQ2MEFBRUNFNEFDMjJCMDRBNzdGMTVBNzc0NEZCNDFDMTFDMDE4RTNFQzEzM0YyMTc5Q0QzNTI2NTA2QjMzNDM3QjlGN0Y2OTZFQkI2Qzg4MzNGNTQ2QjI3RUVGOTk1OEU2RTVCNTJCMDY0ODA1RUZCOEZCQzQ1Q0ExRTU3QkRFMkZBNzdGNzRCQTgzMURGMTJFRUYwQTA0MEYxNkY5NTc4QjE5NjNFQTNFMjAwMDlDNjk1MDFCRUUxOEI3QTYzNzBGNjk2RkEz
Content-Type: text/plain

4e354678-a1b4-470f-8362-9e3446b5be3e

HTTP/1.1 200 OK
```