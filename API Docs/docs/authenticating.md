# Authenticating

Authentication is done using public key cryptography. Each user has a private key that is required to sign requests. That signature serves as the password.

## Content To Sign

The content which needs to be signed is two or three lines separated by line feeds (ASCII 10).

The first line is always the uppercase HTTP method.

Second line is the full url, starting with https://usebeacon.app regardless of the request's `Host` header. For `GET` requests, the query string must be included on this line. The ? should not be included if there are no parameters.

For requests other than `GET`, there should be a third line with the request body. Even if there is no content in the request body, a third line should be included.

A few examples

```plain
GET
https://api.usebeacon.app/v1/mod.php
```
```plain
GET
https://api.usebeacon.app/v1/engram.php?mod_id=123456
```
```plain
POST
https://api.usebeacon.app/v1/engram.php
{"class":"Prefix_MyEngram_C","label":"My Engram","environments":["Island","Scorched"],"can_blueprint": true,"mod_id": 123456}
```
```plain
DELETE
https://api.usebeacon.app/v1/engram.php/Prefix_MyEngram_C,Prefix_OtherEngram_C

```

## Username and Password

Once the content to be signed has been built, sign the content using your private key. Hex encode the result. This is the password. The username is your user uuid.

## HTTP Authorization Header

The API uses HTTP basic authentication, which is very simple. The header contents should be `Basic Base64(username:password)`. See [https://en.wikipedia.org/wiki/Basic_access_authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) for more details about HTTP basic authentication.

## API Builder

Use the [API Builder](beacon://action/showapibuilder) in PHP mode for some real-world sample code.