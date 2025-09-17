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

### Parameters

Parameters introduce additional flexibility to your scripts. When you attach a script to a server or group, you can fill in parameter values to adjust the script's behavior.

Consider a script that needs to store data in a [Bucket](/sentinel/buckets/). Using a parameter, we can customize which bucket the data is stored in, so that each server has its own bucket without having to maintain multiple scripts.

Each parameter has three fundamental properties: name, type, and default value:

- The name is exactly what it sounds like. Parameter names must contain only alphanumeric characters (A–Z and 0–9), are case sensitive (meaning A does not equal a), and cannot start with a number.
- The property type can be one of three things: a String (words, emojis, and other text), a Number, or a Boolean (true/false, yes/no, on/off).
- The default value is the value that the parameter should use if no other value is provided. It is acceptable to include other parameters in the default value.

### Events and Features

[Events](/sentinel/scripts/events) are your reactions to in-game actions, such as player death, dino taming, tribe creation, and chat messages.

[Features](/sentinel/scripts/features) are additions to Sentinel and/or the game. Examples include slash commands, script commands, cheats, webhooks, and menu items.

Each event and feature has a **Language**{:.ui-keyword} menu for choosing between the [Workflow](/sentinel/scripts/languages/workflow.html) and [JavaScript](/sentinel/scripts/languages/javascript.html) languages.

### Common JavaScript

This section will appear if any event or feature uses JavaScript. Any code added to this editor will be placed at the beginning of all JavaScript events and features. This is most useful for creating a library of reusable functions. For instance, this section could offer quicker and easier access to bucket data.

```javascript
const bucketId = beacon.params.bucketId;
const gbv = (key, playerId) => {
  return beacon.getBucketValue(bucketId, key, playerId);
};
const sbv = (key, playerId, newValue) => {
  beacon.setBucketValue(bucketId, key, playerId, newValue);
};
```

Now in any event or feature you can use `gbv` and `sbv` instead of `beacon.getBucketValue` and `beacon.setBucketValue`.

## Versioning

Each time a script is saved, a new revision is saved. This allows you to update a script that has been manually reviewed and approved, without having to worry about downtime. The older approved version of the script will continue to work while the newer version is being reviewed.

## Attaching Scripts to Servers and Groups

Once a script has been created, nothing actually happens with it until the script is attached to a server or group.

Attaching a script to a group works exactly the same as attaching to a server. The key difference is that group scripts will affect all servers in the group. You _can_ attach the same script to a server and a group that server belongs to… but you shouldn't.

Once a script has been saved, head to a server or group page, and choose the **Scripts**{:.ui-keyword} tab. Then press the **Attach Script**{:.ui-keyword} button. You will be shown a list of all scripts you have access to. These could be scripts you have created yourself, or they may belong to a group you belong to. Choose a script with the circular button to the left of the script name.

If the script does not have any parameters defined, you will see a **Attach**{:.ui-keyword} button. If the script does accept parameters, the button will say **Next**{:.ui-keyword} instead. Clicking the **Next**{:.ui-keyword} button will present you with the script's parameters, where you can fill in values that will be used when the script is executed by the server or group.

A script may be attached to a server or group multiple times as long as parameter values are different. Attempting to attach the same script using the same parameter values will result in an error.
