---
title: "User"
parent: "Classes"
grand_parent: "Version 4"
has_children: false
apiVersion: 4
classPath: "users"
identifierProperty: "userId"
supportedInstanceMethods:
  - GET
  - PATCH
properties:
  - key: userId
    type: String
  - key: username
    type: String
  - key: usernameFull
    type: String
  - key: isAnonymous
    type: Boolean
    notes: "Anonymous users are accounts with Beacon that do not have a username, email, and password."
  - key: publicKey
    type: String
    notes: "The user's PEM-encoded RSA public key."
---
# {{page.title}}

{% capture sample_object %}
{
  "userId": "b0c9859f-46a9-47da-bdd6-fdac94459887",
  "username": "Repentant Dimetrodon",
  "usernameFull": "Repentant Dimetrodon#b0c9859f",
  "isAnonymous": false,
  "publicKey": "-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAvOV4d/HAfC7siTLjLX9U\n6f+t9L6Pfq4u/jaFo3Jk1yqPduA+3QLkDFxtQbhy+GubkjQp7uIFUks3ExaO1YYV\nsTQs1g7GlQz+ThcguYmbMT4eCAMPLp8GH8JL2RyituvA3+KoilsRJDkOYvUX3hbr\nHcvFGIunWV54uO+5U8qAdYxEFeZADkg2vVnOz/iI+lR6/rjqkHaXIfF+JYeMXuAa\nnqwVe6zaDW5QqDNE1Okg3NTBdtyHr78952tNf1h/w873sLbNKpv0jrxBhxU9ygK6\nKHDxaHAJU8noy6Ht7wgd5gocgni5JCPTzJjUwSn5g5OiFytkspCYRq01Of7CY5kO\nslQix+AhlFIVDqMjgMeX4pUO8Tpdxs20/ZrVDLf1BjGhxvBa3JWsjYK9xKlIurz2\n++XVE/N/c8pGDi4x4/mBhR351WCe+VXa6BkX4csHsC+ywYY8r4Fg+uta1knL4EQj\n2vYwg6wA1boKUsxZuxbMLXi9i6FdNB4MeX77wwC5w+nUvJCORpGAObY6XH0QCxOR\nCg58AK5Abrj/+ZTUbxiR8nX8cufHAW++Uk5avXy3qZEDbotB4J6XNwkvuNqI+V4w\nsBiFDXQEHOa9CeIay9cMrb7caHIn7cFjgCm/dKi50lhsgf/7BZifcAvaB+qHyz/s\n8apb+6AWesuRWLkjxigRW5sCAwEAAQ==\n-----END PUBLIC KEY-----\n"
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}

## Alias
The path `/v4/user` serves as an alias for `/v4/users/{userId}` to access the authorized user.

## Listing User Projects
`GET /v4/users/{userId}/projects` will list projects a user has access to. This is different from `GET /v4/projects?userId={userId}` which will list projects that the user owns.