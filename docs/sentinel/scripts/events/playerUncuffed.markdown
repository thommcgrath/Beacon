---
title: Survivor Uncuffed
parent: Events
grand_parent: Scripts
description: "A survivor has been released from handcuffs."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player whose survivor was uncuffed.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that was uncuffed.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
---
# {{ page.title }}

{{ page.description }}

Unfortunately it is not possible to know who uncuffed the player.

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
