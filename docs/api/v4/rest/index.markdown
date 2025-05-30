---
title: REST Guide
parent: Version 4
has_children: false
nav_order: 2
---
# {{page.title}}

The Beacon API is a REST API. With minimal exceptions, every request to the API is to perform one of the CRUD (Create, Read, Update, Delete) actions on an object. Just like most programming languages, each object is represented by a class.

Except where otherwise noted, working with this API is done by making a predictable request to a class endpoint. For example, if you wanted to learn how to list projects for a user, start by understanding the "Listing Objects" section of this guide, then read about the [Project](/api/v4/classes/project) class.

## Classes vs Instances

In object-oriented programming, a class is a set of rules to describe a thing, and an instance (and interchangeably, object) is a specific thing. So a class of "Person" might have properties like "hair color" and "height", but these properties have no values. The class is just a framework to describe a person. An instance of the Person class describes a specific person, such as having "hair color = red" and "height = 106cm". The Beacon API uses the concept of classes and instances extensively.

Every class has a path in its documentation known as its **class path**{:.ui-keyword}. The **class path**{:.ui-keyword} is used for bulk actions, such as listing instances or saving new instances.

Every class also has an identifier property. For example, `Project` has `projectId`, `Session` has `sessionId`, and `User` has `userId`. Appending the value of the identifier property to the class path will produce the **instance path**{:.ui-keyword}.

For example, `Project`'s **class path**{:.ui-keyword} is `/v4/projects`, so the **instance path**{:.ui-keyword} for a project with `projectId = 33b7e39c-77d4-494e-afb8-53aa7d8a5494` is `/v4/projects/33b7e39c-77d4-494e-afb8-53aa7d8a5494`.

## Listing Objects

Listing objects is always done with a `GET` request to the **class path**{:.ui-keyword}. The request may contain query parameters for filtering, ordering, and paginating results. Results are always paginated.

### Sorting

| Parameter | Usage |
| - | - |
| sortDirection | One of `ascending` or `descending`. Defaults to `ascending`. |
| sortedColumn | One of the properties of the class. Not all properties are sortable, so refer to the class docs for valid values. |

### Filtering

Each class manages its own filterable properties. These properties define their own matching characteristics. For example, listing projects with `GET /v4/projects?title=ragnarok` will match projects that case-insensitively contain "ragnarok" in the title. Other properties might perform an exact match. Refer to the class documentation for the class's specific filtering behaviors.

There is currently no method for changing the match mode, unless otherwise documented, though this may change in the future with a non-breaking update.

### Pagination

| Parameter | Usage |
| - | - |
| pageSize | Number of results to return per page. Maximum page size is 250, which is also the default. |
| page | 1-based page number. Predictably, defaults to 1 if not supplied. |

Results will always be returned in the following JSON schema:

```json
{
  "totalResults": 1,
  "pageSize": 250,
  "pages": 1,
  "page": 1,
  "results": []
}
```

## Fetching Instances

Fetch individual objects by making a `GET` request to the **instance path**{:.ui-keyword}.

## Creating or Updating Instances

Make a `POST` to the **class path**{:.ui-keyword} to create new instances or to perform bulk updates. This endpoint will always respond with a JSON object with keys `created` and `updated`, each as arrays. These arrays will return the objects that were created or updated, respectively. Regardless of the number of instances created or updated, the response status will be 200 if successful.

The API decides which action to take based on the class's identifier property. If the value of the identifier property already exists, an update will be performed. Only properties included in the request will be updated.

It is acceptable to include an array of objects in this `POST` request to perform bulk actions. The response structure does not change for bulk or single actions.

Let's look at some concrete examples. We will discuss a fictional `Thing` class with path `/v4/things` and identifier property of `thingId`. It has two other properties, `foo` and `baz`.

### Create a New Thing

```
POST /v4/things
```
```json
{
  "foo": "momoweb",
  "baz": "fevilsor"
}
```

In this example, since there is no `thingId` property, the API will create a new `Thing` instance and generate a new id automatically. Most classes will generate ids if not provided. The API would respond with:

```json
{
  "created": [
    {
      "thingId": "5696908e-dc8c-4ad1-afd0-7a4cb3b80e5e",
      "foo": "momoweb",
      "baz": "fevilsor"
    }
  ],
  "updated": [
  ]
}
```

### Updating the Thing

A very similar request can be made to update a thing.

```
POST /v4/things
```
```json
{
  "thingId": "5696908e-dc8c-4ad1-afd0-7a4cb3b80e5e",
  "foo": "groopster"
}
```

Since a `Thing` with the same `thingId` already exists, it will be updated. Since only the `foo` property was included, the `baz` property will not be changed. The response would look like:

```json
{
  "created": [
  ],
  "updated": [
    {
      "thingId": "5696908e-dc8c-4ad1-afd0-7a4cb3b80e5e",
      "foo": "momoweb",
      "baz": "groopster"
    }
  ]
}
```

### Multiple Changes in One Request

By using a JSON array in the request, multiple actions can occur at the same time.

```
POST /v4/things
```
```json
[
  {
    "foo": "refleep",
    "baz": "raez"
  },
  {
    "thingId": "5696908e-dc8c-4ad1-afd0-7a4cb3b80e5e",
    "baz": "mamenthstarz"
  },
  {
    "thingId": "02069061-71f1-4880-b00f-7eb668288764",
    "foo": "atrovel",
    "baz": "solibewither"
  }
]
```

The first object in the array has no `thingId` property, so it will be created as a new object. The second object we know was already created in our first example, so an update will be performed. The third object is new, but specifies its own `thingId`, so it will be created. The response would be:

```json
{
  "created": [
    {
      "thingId": "dd60b88b-4147-4136-865e-9363917f0fc5",
      "foo": "refleep",
      "baz": "raez"
    },
    {
    "thingId": "02069061-71f1-4880-b00f-7eb668288764",
      "foo": "atrovel",
      "baz": "solibewither"
    }
  ],
  "updated": [
    {
      "thingId": "5696908e-dc8c-4ad1-afd0-7a4cb3b80e5e",
      "foo": "momoweb",
      "baz": "mamenthstarz"
    }
  ]
}
```

### Instance Actions

It is also possible to make `PUT` and `PATCH` requests to an **instance path**{:.ui-keyword}. `PUT` requests will fully replace the instance with the new version, while `PATCH` requests perform an update. `PUT` can also be used to create new instances, but `PATCH` instances must exist.

The response for `PUT` and `PATCH` requests is always the instance itself. A `PUT` will respond with 201 if the instance is new, or 200 if an instance was replaced.

## Deleting Instances

Perform a `DELETE` request to an **instance path**{:.ui-keyword} to delete an instance.

To delete multiple instances, make a `DELETE` request to the **class path**{:.ui-keyword} with an array of objects, each containing the identifier property. Other properties are allowed, but will be ignored. Continuing the examples with the fictional `Thing` class from before, deleting all 3 objects could be done with:

```
DELETE /v4/things
```
```json
[
  {
    "thingId": "dd60b88b-4147-4136-865e-9363917f0fc5"
  },
  {
    "thingId": "02069061-71f1-4880-b00f-7eb668288764"
  },
  {
    "thingId": "5696908e-dc8c-4ad1-afd0-7a4cb3b80e5e"
  }
]
```

If **all** instances can be deleted, the API will respond with a 204 "No Content" status. If any instances cannot be deleted, the operation will be aborted and an error status will be returned.

## Common HTTP Statuses

Being a REST API, the Beacon API tries to use common HTTP response statuses.

### Success Statuses

| Status | Meaning |
| - | - |
| 200 | Operation succesful. |
| 201 | Object created. |
| 204 | Operation successful, but there is no output. |

### Client Error Responses

These statuses mean the request cannot be completed due to some fault of your request.

| Status | Meaning |
| - | - |
| 400 | Generic client error. Your application has done something wrong, but there is no more specific status code to use. |
| 401 | Authentication is missing. |
| 403 | Authentication has been provided, but is either incorrect or is not sufficient for the requested action. |
| 404 | Not found. However, the API will lie to in some cases. If you request an instance that you do not have permission to access, the API will often respond with a 404 to avoid confirming the instance's existence. |
| 405 | Cannot perform the request method for the path. |
| 412 | A condition has not been met. For example, attempting to start a Sentinel dino locate request to a server that is not connected. |
| 429 | Rate limit has been exceeded. |

### Server Error Responses

These statuses mean the request cannot be completed due to some fault of the server. Your request is valid and correct, but something is wrong at the API server.

| Status | Meaning |
| - | - |
| 500 | Generic server error. A more specific status code does not exist. |
| 502 | The connection between Cloudflare and the Beacon servers is down. |
| 503 | Typically indicates some kind of error at Cloudflare. |
| 504 | The connection between Cloudflare and the Beacon servers is working, but poorly. |