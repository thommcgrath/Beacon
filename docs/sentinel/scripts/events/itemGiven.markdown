---
title: Item Given
parent: Events
grand_parent: Scripts
description: "A survivor was given an item using Sentinel's web interface or a Sentinel script."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player whose survivor the item was given to.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor the item was given to.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
  - key: itemPath
    type: String
    notes: The full blueprint path of the item that was given.
  - key: quality
    type: Number
    notes: The quality value from the giveItem parameters, if it was included.
  - key: asBlueprint
    type: Boolean
    notes: The asBlueprint value from the giveItem parameters, if it was included.
  - key: minRandomQuality
    type: Number
    notes: The minRandomQuality value from the giveItem parameters, if it was included.
  - key: respectStatClamps
    type: Boolean
    notes: The respectStatClamps value from the giveItem parameters, if it was included.
  - key: itemRating
    type: Number
    notes: The itemRating value from the giveItem parameters, if it was included.
  - key: stats
    type: Array
    notes: The stats value from the giveItem parameters, if it was included.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "itemPath": "/Game/PrimalEarth/CoreBlueprints/Items/Armor/Saddles/PrimalItemArmor_PteroSaddle.PrimalItemArmor_PteroSaddle",
  "asBlueprint": true,
  "itemRating": 0.0,
  "quality": 0.0,
  "stats": [
    {
      "index": 1,
      "value": 255,
    },
    {
      "index": 2,
      "value": 255,
    }
  ]
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
