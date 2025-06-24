---
title: Scripts
parent: Sentinel
---
# {{page.title}}
{: .no_toc }

## Table of Contents
{: .no_toc }
- Table of Contents
{:toc}

## Introduction
{: .no_toc }

Scripting is Sentinel's most powerful feature. From performing simple moderation tasks, to creating custom game modes, scripts can perform some incredible tasks bound by little more than your imagination.

Sentinel scripts come in two varieties: [Actions](#the-actions-language) and [JavaScript](#javascript).

## Context

Think of the script context as the event to react to. It's a little more than that, but most contexts are game events.

Each context has a different set of values the script can access, so once a script has been created, its context cannot be changed.

| Context | Notes |
| - | - |
| Admin Command | Executes when an admin executes an admin command using the in-game console. Requires an active RCON connection. |
| Broadcast | Executes when a broadcast command has been sent by Sentinel, but not by in-game admin commands. |
| Chat Message | Executes for each chat message **after** translation and message scoring have completed. |
| Clock Tampering Detected | Executes when Sentinel has detected that the game's clock is behind its last known time. |
| Cluster ID Changed | Executes when Sentinel allows connection of a server with a different Cluster ID than the last connection. |
| Custom Message | Executes for a custom log message added to Sentinel's logs. |
| Dino Claimed | A tamed unclaimed dino has been claimed. |
| Dino Died | A tamed dino has died. |
| Dino Downloaded | A tamed dino has been downloaded from an Obelisk or other transfer terminal. |
| Dino Frozen | A tamed dino was placed into a cryopod. This usually executes for modded cryopods as well as official. |
| Dino Matured | A tamed dino has grown to an adult. |
| Dino Renamed | A tamed dino has been renamed. |
| Dino Restored | A dead dino has been revived using Sentinel's revive feature. |
| Dino Sterilized | A tamed dino has been neutered or spayed. |
| Dino Tamed | A wild dino has been tamed. |
| Dino Tribe Changed | A tamed dino now belongs to another tribe. |
| Dino Unclaimed | A tamed dino has been unclaimed. |
| Dino Unfrozen | A tamed dino has been released from their cryopod. |
| Dino Unsterilized | A tamed dino is no longer sterilized, usually due to modding or Sentinel's dino edit function. |
| Dino Uploaded | A tamed dino has been uploaded to an Obelisk or other transfer terminal. |
| Item Given | A player has been given an item using Sentinel's web interface or scripting. |
| Manual Dino Script | Appears in the "Run Script" toolbar item when viewing a dino. Can also be executed with a webhook. |
| Manual Server Script | Appears in the "Run Script" toolbar item when viewing a server. Can also be executed with a webhook or scriptcommand cheat. |
| Manual Survivor Script | Appears in the "Run Script" toolbar item when viewing a survivor. Can also be executed with a webhook. |
| Manual Tribe Script | Appears in the "Run Script" toolbar item when viewing a tribe. Can also be executed with a webhook. |
| No Cluster ID Warning | Executes when a server connects with an empty Cluster ID. |
| Player Joined | A player has joined the server. |
| Player Left | A player has joined the server. |
| Problem Detected | A connection problem was noticed that is not covered by other events. |
| Rollback Detected | The server has connected on day 1 after previously connecting with a later day. |
| Scheduled Event | Runs on a timer. Automatically inserts a schedule parameter. |
| Server Connected | A server has connected to Sentinel. |
| Server Disconnected | A server has disconnected from Sentinel. |
| Structure Destroyed | A structure has been destroyed. Does not execute for structures that were picked up. |
| Survivor Cuffed | A survivor has been placed in handcuffs. |
| Survivor Died | A survivor has died. |
| Survivor Renamed | A survivor name has changed. |
| Survivor Spawned | A survivor has spawned after a death, for the first time on the server, or for the first time after transferring. Does not fire for reconnects or fast travel. |
| Survivor Tribe Changed | A survivor has moved to another tribe. |
| Survivor Uncuffed | A survivor has been released from handcuffs. |
| Tribe Created | A new tribe has been created. |
| Tribe Destroyed | A tribe has been destroyed. |
| Tribe Renamed | A tribe has been renamed |
{:.classdefinition}

## Parameters

Parameters are a means to introduce additional flexibility in your scripts. If you've done any kind of programming in the past, think of a Sentinel script as a function, and parameters work exactly like function parameters.

If you have not done programming before, parameters are values that you can pass into the script when you run it. For example, if you were building a script to rename a survivor, you would choose the "Manual Survivor Script" context and could then create a parameter for the new survivor name. When used from the "Run Script" menu, a field for that parameter will appear so you can enter the new name.

Every parameter has three basic properties: name, type, and default value.

The name is exactly what it sounds like. Parameter names may only contain alphanumeric characters (A-Z & 0-9), are case sensitive (meaning A does not equal a), and may not start with a number.

The property type is either String (words, emoji, and other text), a Number, or a Boolean (true/false, yes/no, on/off).

The default value is what the value the parameter should use if no other value is provided. It is perfectly acceptable to include other parameters or context fields in the default value.

In the case of the player renaming script example, you might create a parameter called "newName" whose type is String and default value is `{{generateRandomUsername}}`. We'll get to that weird value in the very next section…

## The "Actions" Language

Sentinel's "Actions" language - is an "if-this-then-that" style interface for setting up basic scripts in a guided manner.

### Conditions

Conditions allow you to only run the script in certain situations, such as if a player were killed by a specific kind of dino.

When adding a condition, the first thing to worry about is the "Field" column. Every context will have a different selection of fields to pick from, so browse the menu carefully. In addition to context fields, parameters will also appear in the field menu.

Depending on the chosen field, the "Operator" column will show different options. Strings will have operators such as "equals", "contains", and "begins with", while numbers will have operators such as "equals", "is greater than" and "is less than or equal to".

The "Value" column is where you'll specify what the field will be compared against. The value field has a menu to its right where you can choose from the same list of fields. For numbers and booleans, you can only choose a single value. But for strings, there is a lot more flexibility.

Choosing a field from the value's menu will insert a placeholder that looks like `{{placeholder}}`. Beacon will insert the field value into its place when the script is executed. These placeholders are usable in parameter default values as well as the actions section.

Adding a second condition will reveal a "Match All" and "Match Any" button pair. "Match All" will require that all conditions are met, while "Match Any" will only require that any of the conditions are met.

### Actions

The **Actions**{:.ui-keyword} section is where you'll specify exactly which actions the script should take when the conditions are met. After pressing the **Add Action**{:.ui-keyword} button, you will then choose from a menu of possible actions. You can add as many as you like.

| Action | Notes |
| - | - |
| Ban Player | Accepts a Sentinel Player ID or EOS ID, which will automatically fill in with the `{{playerId}}` placeholder, a reason, a length in days, and the Sentinel Server ID or Group ID to ban the player from. |
| Clear Bucket Value | Accepts a Sentinel Bucket ID and key to clear a value from. Optionally also accepts a Sentinel Player ID to remove the value from a player instead of the bucket's global value. |
| Give Custom Item | Accepts a Sentinel Survivor ID, item path, and quantity. Optionally also allows specific stat values such as item rating, armor amount, and durability. The Sentinel mod will generate an item that perfectly matches the given stats, within the limitations of the game of course. This does not respect any stat clamps set on the server. |
| Give Item | Similar to Give Custom Item, this action accepts a Sentinel Survivor ID, item path, quality, and quantity. This action behaves much like the the "GiveItem" cheat code, except that Sentinel will allow greater values than the stack size. |
| Kick Player | Removes the player specified by Sentinel Player ID. |
| Rename Survivor | Changes the name of the survivor specified by the Sentinel Survivor ID to the name provided. |
| Run Admin Commands | Sends an admin command to the server utilizing Sentinel's smart command routing. |
| Send Chat Message | Sends a global chat message to the server using a custom sender name. |
| Send Discord Message | Sends a message to a [Discord webhook](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks). Discord webhooks are heavily rate limited, so use this sparingly for best reliability. |
| Set Bucket Value | Saves a value to a specific bucket under the specified key. Optionally accepts a Sentinel Player ID to save the value to. |
{:.classdefinition}

## JavaScript

When the Actions interface isn't enough, you can utilize the full power of modern JavaScript. Sentinel's JavaScript implementation uses WebKit's JavaScriptCore 6.0, which supports just about every feature you could want.

There are some things that JavaScriptCore cannot do. Since it runs without a browser, the `window` object does not exist. While that means obvious things like `window.location` are not available, there are some notable omissions that are less obvious. Some simple functions like `atob` and `btoa` belong to the `window` object, as does `fetch` and `XmlHttpRequest`. This means Sentinel cannot make web requests.

Or can it?

### The Beacon Object

To compensate for the lack of a `window` object, the `beacon` object has functions to replace this missing functionality. `beacon.httpRequest` can be used to make web requests, `beacon.encodeBase64` encodes ASCII data to Base64, and `beacon.decodeBase64` decodes Base64 to ASCII. The **Quick Reference**{:.ui-keyword} section below the JavaScript **Code**{:.ui-keyword} section has a full list of available functions.

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

### Event Data

To know what killed a survivor, for example, you need to use the `beacon.eventData` object. But every event has different properties, so the best way to know what is inside the `beacon.eventData` object is to view a real event.

Start by finding an event in the Sentinel web interface. Right click the event and choose **Show Raw Log Data**{:.ui-keyword}. The `metadata` object of the raw log data is a perfect replica of the `beacon.eventData` object.

### Restrictions

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

## Versioning

Each time a script is saved, a new revision is saved. This allows you to update a script that has been manually reviewed and approved, without having to worry about downtime. The older approved version of the script will continue to work while the newer version is being reviewed.

## Attaching Scripts to Servers and Groups

Once a script has been created, nothing actually happens with it until the script is attached to a server or group.

Attaching a script to a group works exactly the same as attaching to a server. The key difference is that group scripts will affect all servers in the group. You _can_ attach the same script to a server and a group that server belongs to… but you shouldn't.

Once a script has been saved, head to a server or group page, and choose the **Scripts**{:.ui-keyword} tab. Then press the **Attach Script**{:.ui-keyword} button. You will be shown a list of all scripts you have access to. These could be scripts you have created yourself, or they may belong to a group you belong to. Choose a script with the circular button to the left of the script name.

If the script does not have any parameters defined, you will see a **Attach**{:.ui-keyword} button. If the script does accept parameters, the button will say **Next**{:.ui-keyword} instead. Clicking the **Next**{:.ui-keyword} button will present you with the script's parameters, where you can fill in values that will be used when the script is executed by the server or group.

> **Limitation**: A script may only be attached to a server or group once. This means adding a script multiple times with different parameter values is currently not possible. This limitation may or may not change in the future.