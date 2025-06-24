---
title: Buckets
parent: Sentinel
---
# {{page.title}}

Buckets are a way for scripts to store data. They are currently most useful with the JavaScript language, but the Actions language is expected to better support buckets in the future.

A bucket is a key/value store. You can think of it like a two column spreadsheet with columns key and value. You use the key column to get or set a the cell in the value column. The keys and values can be anything you like.

Now take that concept, and imagine you also have the same two column spreadsheet for each player.

If you were coding a game of hide and seek, you might store the ID of the player who is "it" in the "common" or "not player specific" data, while storing the number of times each player has been "it" in the player specific data.

## Get a Bucket Value

```javascript
beacon.getBucketValue(bucketId, key);
beacon.getBucketValue(bucketId, key, playerId);
```

### Parameters

- `bucketId`: The Sentinel UUID of the bucket.
- `key`: A string key to fetch.
- `playerId`: Optional. If provided with a Sentinel Player ID, will fetch the value for the player. Otherwise, fetches from the common data.

### Return

Returns a string if the value was found, or `null` if the value does not exist.

## Set a Bucket Value

```javascript
beacon.setBucketValue(bucketId, key, value);
beacon.setBucketValue(bucketId, key, playerId, value);
```

### Parameters

- `bucketId`: The Sentinel UUID of the bucket.
- `key`: A string key to set.
- `playerId`: Optional. If provided with a Sentinel Player ID, will set the value for the player. Otherwise, sets the value in the common data.
- `value`: A string to store in the bucket.

### Return

This function does not return a value.

## Clear a Bucket Value

```javascript
beacon.clearBucketValue(bucketId, key);
beacon.clearBucketValue(bucketId, key, playerId);
```

### Parameters

- `bucketId`: The Sentinel UUID of the bucket.
- `key`: A string key to set.
- `playerId`: Optional. If provided with a Sentinel Player ID, will clear the value for the player. Otherwise, clears the value from the common data.

### Return

This function does not return a value. If the value does not exist, nothing will happen.

## Building a Scorekeeper Script

Create a new bucket called "Scoreboard" using the **Create Bucket**{:.ui-keyword} button on the Buckets page.

Once the bucket is created, you will be taken to a **Guide**{:.ui-keyword} tab with the bucket UUID and some sample JavaScript. For this example, we'll pretend the UUID is `f9b7cb4c-7297-4171-85ea-76a3cd10ba1b`.

Then go to [Scripts](/sentinel/scripts/) and create a new script. Set the context to "Survivor Died" and the language to "JavaScript". You will not need any parameters for this script.

The first thing the code will do is make sure the player died to a wild troodon. The best way to do this is with the dino tag, so that troodon variants are also considered. If this condition is not met, we use `return` to end the script early.

{:.tip .titled}
> Tip
>
> You can look up the "Name Tag" for a dino using the Beacon website. Using [https://usebeacon.app/Games/ArkSA/Mods/2399830/Troodon_Character_BP_C](https://usebeacon.app/Games/ArkSA/Mods/2399830/Troodon_Character_BP_C) we know the correct name tag is simply Troodon.

```javascript
if (beacon.eventData.attacker.kind !== 'wildDino' || beacon.eventData.attacker.nameTag !== 'Troodon') {
  return;
}
```

Next, we're going to store the bucket UUID and bucket key a constants so they are easier to reference in the future.

```javascript
const bucketId = 'f9b7cb4c-7297-4171-85ea-76a3cd10ba1b';
const bucketKey = `${beacon.eventData.attacker.nameTag} Deaths`;
```

Next, we'll pull two values from the bucket: the total number of player deaths, and the number of times this player has died. Since `beacon.getBucketValue` returns a string on success, we'll need to use `parseInt` to convert the returned value to a number. And since it returns `null` if the value doesn't already exist, we'll use `??` to return 0 instead.

```javascript
let totalDeathCount = parseInt(beacon.getBucketValue(bucketId, bucketKey) ?? '0');
let playerDeathCount = parseInt(beacon.getBucketValue(bucketId, bucketKey, beacon.eventData.playerId) ?? '0');
```

After fetching both values, we'll increment each. This could easily be done on the same lines as above, but this is a tutorial, so we're going to do things the long way for the sake of clarity. Even the lines below could be simpler.

```javascript
totalDeathCount = totalDeathCount + 1;
playerDeathCount = playerDeathCount + 1;
```

Now we need to store the new values in the bucket. JavaScript will automatically convert the numbers to strings for us, so these lines look much simpler than when fetching the values.

```javascript
beacon.setBucketValue(bucketId, bucketKey, totalDeathCount);
beacon.setBucketValue(bucketId, bucketKey, beacon.eventData.playerId, playerDeathCount);
```

And that's the bulk of the work done. But let's sent the score to chat too. We'll need to fetch the survivor to get their name. These are called characters to Ark, which is why function is called `beacon.fetchCharacter` instead of `beacon.fetchSurvivor`.

```javascript
const character = beacon.fetchCharacter(beacon.eventData.characterId);
beacon.sendChat(`${character.name} just died to a troodon! ${totalDeathCount} survivors have died to those glowing-eyed freaks, and ${character.name}'s personal score is ${playerDeathCount}.`, 'Announcer');
```

There are some improvements that _could_ be made here, such as not using the plural "survivors" if `totalDeathCount` is 1. But for the sake of this tutorial, this is good enough.

When attached to a server or group, this script will now taunt players when they die to Troodons. Thanks to the bucket, the score is remembered between restarts, and even across all servers in the group.

### Full Scorekeeper Script

```javascript
// Make sure this is a wild troodon
if (beacon.eventData.attacker.kind !== 'wildDino' || beacon.eventData.attacker.nameTag !== 'Troodon') {
  return;
}

// Define some constants
const bucketId = 'f9b7cb4c-7297-4171-85ea-76a3cd10ba1b';
const bucketKey = `${beacon.eventData.attacker.nameTag} Deaths`;

// Get the current counters from the bucket
let totalDeathCount = parseInt(beacon.getBucketValue(bucketId, bucketKey) ?? '0');
let playerDeathCount = parseInt(beacon.getBucketValue(bucketId, bucketKey, beacon.eventData.playerId) ?? '0');

// Increment the counters
totalDeathCount = totalDeathCount + 1;
playerDeathCount = playerDeathCount + 1;

// Store the new counters in the bucket
beacon.setBucketValue(bucketId, bucketKey, totalDeathCount);
beacon.setBucketValue(bucketId, bucketKey, beacon.eventData.playerId, playerDeathCount);

// Fetch the survivor info and send a message to chat
const character = beacon.fetchCharacter(beacon.eventData.characterId);
beacon.sendChat(`${character.name} just died to a troodon! ${totalDeathCount} survivors have died to those glowing-eyed freaks, and ${character.name}'s personal score is ${playerDeathCount}.`, 'Announcer');
```

Here's a downloadable version of the script you can upload to Sentinel. It uses a parameter for the bucket UUID for flexibility.

[Troodon Death Counter](troodon_death_counter.beaconscript)