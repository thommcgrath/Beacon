---
title: Dino Revived
parent: Events
grand_parent: Scripts
description: "A dino was revived using Sentinel's \"Revive\" feature."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the the dino that was revived.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that received the revived dino.
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player that owns the survivor.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "61081761-d7eb-59bc-9f74-c6c13f183133",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
