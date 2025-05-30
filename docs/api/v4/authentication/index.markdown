---
title: Authentication
parent: Version 4
has_children: false
nav_order: 1
---
# {{page.title}}

Version 4 of the Beacon API uses OAuth 2.1 for authentication. If you are using an OAuth library, ensure that it supports OAuth 2.1.

If you are already familiar with OAuth, here are the key details:

| Parameter | Value |
| - | - |
| Authorization URL | https://api.usebeacon.app/v4/login |
| Token URL | https://api.usebeacon.app/v4/login |

## Starting A Login Request

To request a login, generate two random values: A `state` and a `code_verifier.` Store these values temporarily in the user's browser. A session cookie or session storage is best for this purpose. After the login is complete, the state will be relayed back, which you should verify before continuing. This protects against cross-site request forgery. The code verifier will defend against man-in-the-middle attacks, which may occur if the user's router or other security parameters have been tampered with. See the "Challenge" section below for more details.

Make a GET request to `https://api.usebeacon.app/v4/login`, which will redirect the user to the login interface. The following query parameters must be included in this request:

| Parameter | Value |
| - | - |
| client_id | Your application UUID. |
| scope | This is a space-separated list of the requested scopes. Your application must be registered for each requested scope, though not all registered scopes must be requested. The most common value is `common users:read`. |
| redirect_uri | One of the callback URLs registered for your application. |
| state | A random state value generated by a cryptographically secure psuedorandom number generator. |
| response_type | Always `code`. |
| code_challenge | See below. |
| code_challenge_method | Always `S256`. |
| device_id | Optional. If your application has a unique device identifier, pass it in this parameter. If the user has two-step authentication enabled and chooses to trust the device, the verification request will be skipped on subsequent logins. |
| no_redirect | Optional. If `true`, the login url will be returned in a JSON object with a `login_url` key and an HTTP 200 status. Otherwise, the normal 302 redirect behavior will be used instead. |

### Challenge

A `code_verifier` must first be generated to produce a challenge. The `code_verifier` must be between 43 and 128 characters long and can only contain alphanumeric characters or the special characters `-`, `.`, `_`, or `~`.

We can generate the `code_challenge` with the `code_verifier`. This is a Base64URL encoded SHA-256 hash, not regular Base64. In pseudo-code, it might look like this:

```plain
code_challenge = BASE64URL(SHA256(code_verifier))
```

Some languages automatically hex-encode their hashes. Make sure you are encoding the raw hash and not the hex-encoded hash.

### Scopes

The Beacon API supports the following scopes:

| Scope | Purpose |
| - | - |
| common | This scope is **always** included. Provides access to the most common features, such as game information. |
| users:read | Allows reading information about the authenticated user and other users. |
| users:update | Allows editing of the user. This is not necessary for working with user project or cloud files. |
| users.private_key:read | Allows fetching the user's private key, which is necessary for reading encrypted portions of projects and all cloud files. |
| sentinel:read | Allows reading the user's Sentinel data. |
| sentinel:write | Allows full editing of the user's Sentinel data, including adding or removing servers, groups, bans, scripts. |

### Sample Code

#### Raw HTTP

```http
GET /v4/login?state=0fc732a9-05d8-403c-bdce-231c90f7b924&client_id=413d18e9-790c-4477-bcbe-ae31cf1227f0&scope=common%20users%3Aread&redirect_uri=https%3A%2F%2Fjiinuko.edu%2Fehreg%2Foauth&response_type=code&code_challenge=2b6-gW15O10gZcp97PaXVmmu_4IrMXVBXNWtP8q8crs&code_challenge_method=S256 HTTP/1.1
Host: api.usebeacon.app

```

#### JavaScript

```javascript
const params = new URLSearchParams();
params.append('state', '0fc732a9-05d8-403c-bdce-231c90f7b924');
params.append('client_id', '413d18e9-790c-4477-bcbe-ae31cf1227f0');
params.append('scope', 'common users:read');
params.append('redirect_uri', 'https://jiinuko.edu/ehreg/oauth');
params.append('response_type', 'code');
params.append('code_challenge', '2b6-gW15O10gZcp97PaXVmmu_4IrMXVBXNWtP8q8crs');
params.append('code_challenge_method', 'S256');

fetch(`https://api.usebeacon.app/v4/login?${params.toString()}`, {
      "method": "GET",
      "headers": {}
})
.then((res) => res.text())
.then(console.log.bind(console))
.catch(console.error.bind(console));
```

#### Python

```python
try:
    response = requests.get(
        url="https://api.usebeacon.app/v4/login",
        params={
            "state": "0fc732a9-05d8-403c-bdce-231c90f7b924",
            "client_id": "413d18e9-790c-4477-bcbe-ae31cf1227f0",
            "scope": "common users:read",
            "redirect_uri": "https://jiinuko.edu/ehreg/oauth",
            "response_type": "code",
            "code_challenge": "2b6-gW15O10gZcp97PaXVmmu_4IrMXVBXNWtP8q8crs",
            "code_challenge_method": "S256",
        },
    )
    print('Response HTTP Status Code: {status_code}'.format(
        status_code=response.status_code))
    print('Response HTTP Response Body: {content}'.format(
        content=response.content))
except requests.exceptions.RequestException:
    print('HTTP Request failed')
```

### Sample Response

```http
HTTP/1.1 302 Found
Location: https://usebeacon.app/account/login

```

## Completing A Login Request

Once the user has completed their login, the user will be redirected back to your `redirect_uri` with some additional query parameters.

| Parameter | Purpose |
| - | - |
| state | The state value sent when starting the login request. If this does not match the value stored in the user's browser, do not continue. |
| code | Used to request an access token from the Beacon API. |

Use these parameters to build a JSON object and POST it to `https://api.usebeacon.app/v4/login`.

| Key | Value |
| - | - |
| client_id | Your application UUID. |
| client_secret | If your application is a confidential client, include its secret. Otherwise, omit this key. |
| code | The `code` described above. |
| grant_type | Always `authorization_code`. |
| redirect_uri | The same `redirect_uri` used when starting the login request. |
| code_verifier | The **raw** (no hashing, no encoding) `code_verifier` sent when starting the login request. |
| device_id | Like the initial request, include the device id if one exists. |

The API will respond with authorization information in a JSON object. The value in `accessToken` is used with the rest of the API in the form of an `Authorization: Bearer <accessToken>` header. If making API requests from within the browser, CORS policy will not include the `Authorization` header, so use the `X-Beacon-Token: <accessToken>` header instead.

### Sample Code

#### Raw HTTP

```http
POST /v4/login HTTP/1.1
Content-Type: application/json
Host: api.usebeacon.app

{
  "client_id": "413d18e9-790c-4477-bcbe-ae31cf1227f0",
  "code": "oBOrJr-MHnAQfiNTYzxgT4CIPcS4_1ygVplTBcAhZS0",
  "grant_type": "authorization_code",
  "redirect_uri": "https://jiinuko.edu/ehreg/oauth",
  "code_verifier": "0RRGb4Mid9Fj1YXX17z_Rtkh0XQZX5KBvmr0wNoDqYU"
}
```

#### JavaScript

```javascript
fetch("https://api.usebeacon.app/v4/login", {
      "method": "POST",
      "headers": {
            "Content-Type": "application/json"
      },
      "body": JSON.stringify({
        client_id: '413d18e9-790c-4477-bcbe-ae31cf1227f0',
        code: 'oBOrJr-MHnAQfiNTYzxgT4CIPcS4_1ygVplTBcAhZS0',
        grant_type: 'authorization_code',
        redirect_uri: 'https://jiinuko.edu/ehreg/oauth',
        code_verifier: '0RRGb4Mid9Fj1YXX17z_Rtkh0XQZX5KBvmr0wNoDqYU'
      })
})
.then((res) => res.text())
.then(console.log.bind(console))
.catch(console.error.bind(console));
```

#### Python

```python
try:
    response = requests.post(
        url="https://api.usebeacon.app/v4/login",
        headers={
            "Content-Type": "application/json; charset=utf-8",
        },
        data=json.dumps({
            "client_id": "413d18e9-790c-4477-bcbe-ae31cf1227f0",
            "code": "oBOrJr-MHnAQfiNTYzxgT4CIPcS4_1ygVplTBcAhZS0",
            "redirect_uri": "https://jiinuko.edu/ehreg/oauth",
            "code_verifier": "0RRGb4Mid9Fj1YXX17z_Rtkh0XQZX5KBvmr0wNoDqYU",
            "grant_type": "authorization_code"
        })
    )
    print('Response HTTP Status Code: {status_code}'.format(
        status_code=response.status_code))
    print('Response HTTP Response Body: {content}'.format(
        content=response.content))
except requests.exceptions.RequestException:
    print('HTTP Request failed')
```

### Sample Response

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "accessToken": "4Il6iHU68VuZc3e7VrqksTu0UIC_8haalgYelsOn-Og",
  "refreshToken": "ARbbvXzPHjXGNQgHH4uRgBCrMp2hAcT_YVAIvENOVWg",
  "accessTokenExpiration": 1748468482,
  "refreshTokenExpiration": 1751056882,
  "userId": "e51fe8d0-3db2-40ec-9323-bbaeedfb6f1a",
  "application": {
    "id": "413d18e9-790c-4477-bcbe-ae31cf1227f0",
    "name": "Dingbot",
    "website": "https://jiinuko.edu/ehreg"
  },
  "scopes": [
    "common",
    "users:read"
  ]
}
```

## Token Expiration

The access token will expire quickly. At the time of this writing, the expiration is 1 hour. The `refreshToken` key can be used to request a new access token. Utilize the `accessTokenExpiration` and `refreshTokenExpiration` keys to know when a refresh is necessary. If the user is making a request, and the access token has expired, refresh it first.

Consider implementing a timed function to look for refresh tokens that are expiring in the near future and refresh them. This will prevent users from having to log in again after an absence. At the time of this writing, refresh tokens expire after 30 days.

Each refresh will replace both the access token and refresh token.

To refresh a token, POST a JSON object to `https://api.usebeacon.app/v4/login`. This object looks much like the access token request:

| Key | Value |
| - | - |
| client_id | Your application UUID. |
| client_secret | If your application is a confidential client, include its secret. Otherwise, omit this key. |
| grant_type | Always `refresh_token`. |
| refresh_token | The refresh token. |
| scope | Space-separated list of scopes. This must match the originally requested scopes. |

The response will match that of the access token response.

## Sign Out

To terminate an access token, make a DELETE request to `https://api.usebeacon.app/v4/sessions/{accessToken}`. The server will respond with a 204 status if successful.

### Sample Code

#### Raw HTTP

```http
DELETE /v4/sessions/4Il6iHU68VuZc3e7VrqksTu0UIC_8haalgYelsOn-Og HTTP/1.1
Host: api.usebeacon.app

```

#### JavaScript

```javascript
fetch("https://api.usebeacon.app/v4/sessions/4Il6iHU68VuZc3e7VrqksTu0UIC_8haalgYelsOn-Og", {
      "method": "DELETE",
      "headers": {}
})
.then((res) => res.text())
.then(console.log.bind(console))
.catch(console.error.bind(console));
```

#### Python

```python
try:
    response = requests.delete(
        url="https://api.usebeacon.app/v4/sessions/4Il6iHU68VuZc3e7VrqksTu0UIC_8haalgYelsOn-Og",
    )
    print('Response HTTP Status Code: {status_code}'.format(
        status_code=response.status_code))
    print('Response HTTP Response Body: {content}'.format(
        content=response.content))
except requests.exceptions.RequestException:
    print('HTTP Request failed')
```

### Sample Response

```http
HTTP/1.1 204 No Content

```
