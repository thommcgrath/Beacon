---
title: JavaScript
parent: Languages
grand_parent: Scripts
---
# {{page.title}}

When the Workflow language isn't enough, you can utilize the full power of modern JavaScript. Sentinel's JavaScript implementation uses WebKit's JavaScriptCore 6.0, which supports just about every feature you could want.

There are some things that JavaScriptCore cannot do. Since it runs without a browser, the `window` object does not exist. While that means obvious things like `window.location` are not available, there are some notable omissions that are less obvious. Some simple functions like `atob` and `btoa` belong to the `window` object, as does `fetch` and `XmlHttpRequest`. This means Sentinel cannot make web requests.

Or can it?

## The Beacon Object

To compensate for the lack of a `window` object, the `beacon` object has functions to replace this missing functionality. `beacon.httpRequest` can be used to make web requests, `beacon.encodeBase64` encodes ASCII data to Base64, and `beacon.decodeBase64` decodes Base64 to ASCII. See the [Functions](/sentinel/scripts/functions/) page for a full detailed list of functions in the `beacon` object.

The `beacon` object also contains everything else the script could need:

| Property | Notes |
| - | - |
| beacon.now | Returns the UNIX epoch of the script start time. |
| beacon.serviceId | The Sentinel Server ID that is running the script. All scripts run for a single server. Sentinel calls servers services on the backend, thus the naming difference. |
| beacon.serviceName | The full server name shown in the server browser. |
| beacon.serviceNickname | The nickname given to the server in the Sentinel web interface. Will be an empty string if a nickname is not set. |
| beacon.serviceChatName | The "chat name" given to the server in the Sentinel web interface. Will be an empty string if a chat name is not set. |
| beacon.params | An object containing all the parameters defined for the script. |
| beacon.gameEvent | A string representing the current script context. |
| beacon.eventData | An object containing all the specific event data. See [Event Data](#event-data) below. |
{:.classdefinition}

## Event Data

To know what killed a survivor, for example, you need to use the `beacon.eventData` object. But every event has different properties, so refer to the [Events](/sentinel/scripts/events/) page to know which properties to expect and how to use them.

You can also view the event data of real events. Start by finding an event in the Sentinel web interface. Right click the event and choose **Show Raw Log Data**{:.ui-keyword}. The `metadata` object of the raw log data is a perfect replica of the `beacon.eventData` object.

## Restrictions

Sentinel JavaScripts have two primary limitations to prevent abuse, since we're giving you an incredible amount of power.

1. Execution time is limited to 5 seconds. The Sentinel infrastructure is performing the actual work, not your server, so you need to play fair with that time.
2. Certain functions, such as `beacon.httpRequest` require manual review and approval before the script will actually execute. We need to be sure you're not trying to use Sentinel as a DDoS source, for example.

Simple usage of a restricted function will require approval as soon as the script is saved. For example, the following script will trigger a manual review as soon as it is saved:
```javascript
const response = beacon.httpRequest('GET', 'https://google.com');
```

**Don't try to be clever and obscure your intention**. The following code will **pass** the initial detection, but the script will be terminated and sent for review as soon as the function is actually called:

```javascript
const response = beacon['httpRequest']('GET', 'https://google.com');
```
