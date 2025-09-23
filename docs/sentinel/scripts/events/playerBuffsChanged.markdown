---
title: Survivor Buffs Changed
parent: Events
grand_parent: Scripts
description: "A survivor's buffs have changed."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player whose survivor was affected.
  - key: playerName
    type: String
    notes: The name of the player whose survivor was affected.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that was affected.
  - key: characterName
    type: String
    notes: The name of the survivor that was affected.
  - key: specimenId
    type: String
    notes: The implant number of the survivor that was affected.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe of the affected survivor.
  - key: tribeName
    type: String
    notes: The name of the tribe of the affected survivor.
  - key: tribeNumber
    type: String
    notes: The numeric ID of the tribe of the affected survivor.
  - key: buffsAdded
    type: Array
    notes: An array of objects representing the buffs that were added to the survivor. Expect keys `path`, `isHidden`, and `name`.
  - key: buffsRemoved
    type: Array
    notes: An array of objects representing the buffs that were removed from the survivor.
---
# {{ page.title }}

{{ page.description }}

The event data will contain an array of the buffs added or removed. The game considers all effects buffs, even if they are negative effects. Usually, only 1 buff will exist in the event data, but it's possible for multiple buffs to be added or removed at the same time.

Not all buffs have useful names, and some buffs do not appear to the player at all. The `isHidden` property will be true for buffs the player cannot see. The buff name may be localized.

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "playerName": "Repentant Dimetrodon",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "characterName": "Useless Pulminoscorpius",
  "specimenId": 421854961,
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "tribeName": "Reusable Breakfast Cereals",
  "tribeNumber": 780901340,
  "buffsAdded": {
    "path": "/Game/PrimalEarth/CoreBlueprints/Buffs/Buff_DiloPoison.Buff_DiloPoison_C",
    "isHidden": false,
    "name": "Dilo Venom"
  },
  "buffsRemoved": [
  ]
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
