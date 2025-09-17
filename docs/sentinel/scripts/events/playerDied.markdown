---
title: Survivor Died
parent: Events
grand_parent: Scripts
description: "A survivor has died. Includes information about what kill them."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player whose survivor died.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that died.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
  - key: attacker
    type: Object
    notes: An object conforming to the [Attacker](../classes/attacker.html) class.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "attacker": {
    "kind": "self"
  }
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
