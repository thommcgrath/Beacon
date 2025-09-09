---
title: Webhook
parent: Features
grand_parent: Scripts
description: "Adds a webhook url and access key, useful for executing Sentinel code from outside Sentinel, such as by a website or Discord bot."
---
# {{ page.title }}

{{ page.description }}

## Identity

- **Name**: Each webhook should have a name that is unique to the server. However, Sentinel will not enforce uniqueness since multiple scripts could provide the same webhook names. If two webhooks share the same name, **both** will execute. For this reason, it's is recommended to prefix or suffix webhook names in a way that makes them more likely to be unique. There is no character limitation, however it is advised to avoid characters like ' and " to make it easier to call without the need to escape characters.
- **Parameters**: A webhook can define parameters used to receive values from the calling code. For example, a webhook kills a specified survivor would use a parameter to receive the survivor UUID. Parameter values are available within the webhook code using the `beacon.params` structure.

## Making a Webhook Request

The script editor has example code in PHP and JavaScript after adding a Webhook feature to a script.

### Webhook URL

Every server has its own URL used for receiving webhook notifications. No setup is required. Make webhook requests to `https://api.usebeacon.app/v4/sentinel/services/:serviceId/webhook`, replacing `:serviceId` for the server UUID. The method for all webhook requests is `POST`.

### Request Body

The body of the request is a JSON object with keys `webhook` and `parameters`. `parameters` is an object with keys matching defined parameter names. Keys that do not match a parameter will be ignored.

```json
{
  "webhook": "Kill Survivor",
  "parameters": {
    "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
  }
}
```

### Authentication

Sentinel webhooks use time-based HMAC signatures.

Start by computing the current time value by rounding down the current UNIX epoch divided by 30. We'll call this value `time`. Produce a `stringToSign` value by combining the request method, `time`, and request body, separated by newlines (\n). Using the example request body above and UNIX epoch of 1757451566, the `stringToSign` would look like this:

```text
POST
58581718
{
  "webhook": "Kill Survivor",
  "parameters": {
    "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
  }
}
```

The request body may or may not be minified as long as it precisely matches the value used in `stringToSign`.

Compute an SHA-256 HMAC signature of `stringToSign` using the server's Sentinel access key. The access key can be found in the server's GameUserSettings.ini or the server's setup instructions in the Sentinel web interface. The final signature should be hex encoded. Use this value in the request `Authorization` header along with `HmacSHA256` as the authentication scheme.

### Full Request Example

Using the same values above, a server UUID of `6e98b5d3-cf03-43e5-996c-fba18c46868c`, and access key of `H2yxMWEHQ6B5nIXvawKsnuAbqi7CTcaxDSS-jsQ414I`, the complete HTTP request looks like:

```http
POST /v4/sentinel/services/6e98b5d3-cf03-43e5-996c-fba18c46868c/webhook HTTP/1.1
Authorization: HmacSHA256 8190d7e58c51b36b45cd57d2f4c8113ae5aa0c70b3806567b30c77d0f636160c
Content-Type: application/json
Host: api.usebeacon.app
Content-Length: 113

{
  "webhook": "Kill Survivor",
  "parameters": {
    "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
  }
}
```
