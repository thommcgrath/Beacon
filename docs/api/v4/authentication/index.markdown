---
title: Authentication
parent: Version 4
has_children: false
nav_order: 1
sampleAccessToken: "kyXwY-jBHUONral73ctZi0dAtL8VN3aJGemhkDDH9y4"
sampleRefreshToken: "3MBaAT6f3Nvc9XeF62SDUjJ-nqKNkJRV8hTJpPwQ5kA"
sampleClientId: "413d18e9-790c-4477-bcbe-ae31cf1227f0"
sampleVerifierHash: "2b6-gW15O10gZcp97PaXVmmu_4IrMXVBXNWtP8q8crs"
sampleVerifier: "0RRGb4Mid9Fj1YXX17z_Rtkh0XQZX5KBvmr0wNoDqYU"
---
# {{page.title}}

{% capture sample_oauth_response %}
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "token_type": "Bearer",
  "access_token": "{{page.sampleAccessToken}}",
  "refresh_token": "{{page.sampleRefreshToken}}",
  "access_token_expiration": 1748835444,
  "refresh_token_expiration": 1751423844,
  "access_token_expires_in": 3600.120197057724,
  "refresh_token_expires_in": 2592000.1201970577,
  "scope": "common users:read",
  "now": 1748831843.879803
}
```

The API will respond with authorization information in a JSON object. The value in `access_token` is used with the rest of the API in the form of an `Authorization: Bearer <access_token>` header. If making API requests from within the browser, CORS policy will not include the `Authorization` header, so use the `X-Beacon-Token: <access_token>` header instead.

See [Token Expiration](#token-expiration) for handling of token expiration.{% endcapture %}

Version 4 of the Beacon API uses OAuth 2.1 for authentication. If you are using an OAuth library, ensure that it supports OAuth 2.1.

If you are already familiar with OAuth, here are the key details:

| Parameter | Value |
| - | - |
| Authorization URL | https://api.usebeacon.app/v4/login |
| Token URL | https://api.usebeacon.app/v4/login |
| Device URL | https://api.usebeacon.app/v4/device |

## Starting A Login Request From A Browser

To request a login, generate two random values: A `state` and a `code_verifier.` Store these values temporarily in the user's browser. A session cookie or session storage is best for this purpose. After the login is complete, the state will be relayed back, which you should verify before continuing. This protects against cross-site request forgery. The code verifier will defend against man-in-the-middle attacks, which may occur if the user's router or other security parameters have been tampered with. See the "Challenge" section below for more details.

Make a GET request to the **authorization url**{:.ui-keyword}, which will redirect the user to the login interface. The following query parameters must be included in this request:

| Parameter | Value |
| - | - |
| client_id | Your application UUID. |
| scope | This is a space-separated list of the requested scopes. Your application must be registered for each requested scope, though not all registered scopes must be requested. The most common value is `common users:read`. See [Scopes](#scopes) for the full list of supported scopes. |
| redirect_uri | One of the callback URLs registered for your application. |
| state | A random state value generated by a cryptographically secure psuedorandom number generator. |
| response_type | Always `code`. |
| code_challenge | See [Code Challenge](#code-challenge). |
| code_challenge_method | Always `S256`. |
| device_id | Optional. If your application has a unique device identifier, pass it in this parameter. If the user has two-step authentication enabled and chooses to trust the device, the verification request will be skipped on subsequent logins. |
| no_redirect | Optional. If `true`, the login url will be returned in a JSON object with a `login_url` key and an HTTP 200 status. Otherwise, the normal 302 redirect behavior will be used instead. |

### Sample Code

#### Raw HTTP

```http
GET /v4/login?state=0fc732a9-05d8-403c-bdce-231c90f7b924&client_id={{page.sampleClientId}}&scope=common%20users%3Aread&redirect_uri=https%3A%2F%2Fjiinuko.edu%2Fehreg%2Foauth&response_type=code&code_challenge={{page.sampleVerifierHash}}&code_challenge_method=S256 HTTP/1.1
Host: api.usebeacon.app

```

#### JavaScript

```javascript
const params = new URLSearchParams();
params.append('state', '0fc732a9-05d8-403c-bdce-231c90f7b924');
params.append('client_id', '{{page.sampleClientId}}');
params.append('scope', 'common users:read');
params.append('redirect_uri', 'https://jiinuko.edu/ehreg/oauth');
params.append('response_type', 'code');
params.append('code_challenge', '{{page.sampleVerifierHash}}');
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
            "client_id": "{{page.sampleClientId}}",
            "scope": "common users:read",
            "redirect_uri": "https://jiinuko.edu/ehreg/oauth",
            "response_type": "code",
            "code_challenge": "{{page.sampleVerifierHash}}",
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

## Completing A Browser Login Request

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
  "client_id": "{{page.sampleClientId}}",
  "code": "oBOrJr-MHnAQfiNTYzxgT4CIPcS4_1ygVplTBcAhZS0",
  "grant_type": "authorization_code",
  "redirect_uri": "https://jiinuko.edu/ehreg/oauth",
  "code_verifier": "{{page.sampleVerifier}}"
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
        client_id: '{{page.sampleClientId}}',
        code: 'oBOrJr-MHnAQfiNTYzxgT4CIPcS4_1ygVplTBcAhZS0',
        grant_type: 'authorization_code',
        redirect_uri: 'https://jiinuko.edu/ehreg/oauth',
        code_verifier: '{{page.sampleVerifier}}'
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
            "Content-Type": "application/json",
        },
        data=json.dumps({
            "client_id": "{{page.sampleClientId}}",
            "code": "oBOrJr-MHnAQfiNTYzxgT4CIPcS4_1ygVplTBcAhZS0",
            "redirect_uri": "https://jiinuko.edu/ehreg/oauth",
            "code_verifier": "{{page.sampleVerifier}}",
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

{{sample_oauth_response}}

## Starting A Device Login Request

In some cases, you may need to start a login request when a browser is unavailable or impractical. Examples of when you might use a device login include a console, TV, or Discord bot. You may have experienced this before when an app on a smart TV shows a code and a URL. You would then visit the URL, enter the code, and complete the login process. The Beacon API supports this technique as well.

To obtain a code and URL, make a `POST` request to the **device url**{:.ui-keyword} above. The body of the request should be url-encoded form data with the following parameters.

| Parameter | Notes |
| - | - |
| client_id | Your application UUID. |
| client_secret | If your application is a confident client, the secret must be included. |
| scope | This is a space-separated list of the requested scopes. Your application must be registered for each requested scope, though not all registered scopes must be requested. The most common value is `common users:read`. See [Scopes](#scopes) for the full list of supported scopes. |
| code_challenge | See [Code Challenge](#code-challenge). |
| code_challenge_method | Always `S256`. |

### Sample Code

#### Raw HTTP

```http
POST /v4/device HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: api.usebeacon.app

client_id={{page.sampleClientId}}&scope=common%20users%3Aread&code_challenge={{page.sampleVerifierHash}}&code_challenge_method=S256
```

#### JavaScript

```javascript
const params = new URLSearchParams();
params.append('client_id', '{{page.sampleClientId}}');
params.append('scope', 'common users:read');
params.append('code_challenge', '{{page.sampleVerifierHash}}');
params.append('code_challenge_method', 'S256');

fetch("https://api.usebeacon.app/v4/device", {
	"method": "POST",
	"headers": {
		"Content-Type": "application/x-www-form-urlencoded"
	},
	"body": params.toString()
})
.then((res) => res.text())
.then(console.log.bind(console))
.catch(console.error.bind(console));
```

#### Python

```python
try:
    response = requests.post(
        url="https://api.usebeacon.app/v4/device",
        headers={
            "Content-Type": "application/x-www-form-urlencoded",
        },
        data={
            "client_id": "{{page.sampleClientId}}",
            "scope": "common users:read",
			"code_challenge": "{{page.sampleVerifierHash}}",
			"code_challenge_method": "S256"
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
HTTP/1.1 201 Created
Content-Type: application/json

{
  "device_code": "4a196833-595c-53ea-b72f-59463f92c3cf",
  "user_code": "C73J-3NTJ",
  "verification_uri": "https://usebeacon.app/device",
  "verification_uri_complete": "https://usebeacon.app/device?code=C73J-3NTJ",
  "interval": 5,
  "expires_in": 599.99588
}
```

| Key | Notes |
| - | - |
| device_code | A UUID for this login request. |
| user_code | This is the code to show the user to enter during the login process. |
| verification_uri | This is the address the user should visit to enter the `user_code`. |
| verification_uri_complete | This address is has the `user_code` completed, making it useful for showing as a QR code. |
| interval | Check the **token url**{:.ui-keyword} no more than once every `interval` seconds. |
| expires_in | Number of seconds until the login request expires. |

## Completing A Device Login Request

After creating the device login request, poll the **token url**{:.ui-keyword} every `interval` seconds until the request is completed, has expired, or has been rejected. This request is a `POST` request with a body that is either a url-encoded query string or a JSON object.

| Key | Notes |
| - | - |
| client_id | Your application UUID. |
| client_secret | If your application is a confident client, the secret must be included. |
| device_code | The UUID found in the `device_code` key when the device login request was created. |
| grant_type | Always `device_code` or `urn:ietf:params:oauth:grant-type:device_code`. They are functionally identical, but the more verbose value is more commonly used. |
| code_verifier | The **raw** (no hashing, no encoding) `code_verifier` sent when starting the login request. |

### Sample Code

#### Raw HTTP

```http
POST /v4/login HTTP/1.1
Content-Type: application/json
Host: api.usebeacon.app

{
  "client_id": "{{page.sampleClientId}}",
  "device_code": "4a196833-595c-53ea-b72f-59463f92c3cf",
  "grant_type": "device_code",
  "code_verifier": "{{page.sampleVerifier}}"
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
		"client_id": "{{page.sampleClientId}}",
		"device_code": "4a196833-595c-53ea-b72f-59463f92c3cf",
		"grant_type": "device_code",
		"code_verifier": "{{page.sampleVerifier}}"
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
            "Content-Type": "application/json",
        },
        data=json.dumps({
            "client_id": "{{page.sampleClientId}}",
            "device_code": "4a196833-595c-53ea-b72f-59463f92c3cf",
            "grant_type": "device_code",
            "code_verifier": "{{page.sampleVerifier}}"
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

{{sample_oauth_response}}

## Token Expiration

The access token will expire quickly. At the time of this writing, the expiration is 1 hour. The `refresh_token` key can be used to request a new access token. Utilize the `access_token_expiration` and `refresh_token_expiration` keys to know when a refresh is necessary. If the user is making a request, and the access token has expired, refresh it first.

Consider implementing a timed function to look for refresh tokens that are expiring in the near future and refresh them. This will prevent users from having to log in again after an absence. At the time of this writing, refresh tokens expire after 30 days.

Each refresh will replace both the access token and refresh token.

To refresh a token, `POST` a JSON object to the **token url**{:.ui-keyword}. This object looks much like the access token request:

| Key | Value |
| - | - |
| client_id | Your application UUID. |
| client_secret | If your application is a confidential client, include its secret. Otherwise, omit this key. |
| grant_type | Always `refresh_token`. |
| refresh_token | The refresh token. |
| scope | Space-separated list of scopes. This must match the originally requested scopes. |

The response will match that of the access token response.

## Sign Out

To terminate an access token, make a `DELETE` request to `https://api.usebeacon.app/v4/session`. The server will respond with a 204 status if successful.

### Sample Code

#### Raw HTTP

```http
DELETE /v4/session HTTP/1.1
Host: api.usebeacon.app
Authorization: Bearer {{page.sampleAccessToken}}

```

#### JavaScript

```javascript
fetch("https://api.usebeacon.app/v4/session", {
  "method": "DELETE",
  "headers": {
    "Authorization": "Bearer {{page.sampleAccessToken}}"
  }
})
.then((res) => res.text())
.then(console.log.bind(console))
.catch(console.error.bind(console));
```

#### Python

```python
try:
    response = requests.delete(
        url="https://api.usebeacon.app/v4/session",
		headers={
			"Authorization": "Bearer {{page.sampleAccessToken}}",
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
HTTP/1.1 204 No Content

```

## Scopes

The Beacon API supports the following scopes:

| Scope | Purpose |
| - | - |
| common | This scope is **always** included. Provides access to the most common features, such as game information. |
| users:read | Allows reading information about the authenticated user and other users. |
| users:update | Allows editing of the user. This is not necessary for working with user project or cloud files. |
| users.private_key:read | Allows fetching the user's private key, which is necessary for reading encrypted portions of projects and all cloud files. |
| sentinel:read | Allows reading the user's Sentinel data. |
| sentinel:write | Allows full editing of the user's Sentinel data, including adding or removing servers, groups, bans, scripts. |

## Code Challenge

A `code_verifier` must first be generated to produce a challenge. The `code_verifier` must be between 43 and 128 characters long and can only contain alphanumeric characters or the special characters `-`, `.`, `_`, or `~`.

We can generate the `code_challenge` with the `code_verifier`. This is a Base64URL encoded SHA-256 hash, not regular Base64. In pseudo-code, it might look like this:

```plain
code_challenge = BASE64URL(SHA256(code_verifier))
```

Some languages automatically hex-encode their hashes. Make sure you are encoding the raw hash and not the hex-encoded hash.