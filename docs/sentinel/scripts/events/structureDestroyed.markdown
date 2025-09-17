---
title: Structure Destroyed
parent: Events
grand_parent: Scripts
description: "A structure has been destroyed. Includes information about what destroyed it."
properties:
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe whose structure was destroyed.
  - key: structureName
    type: String
    notes: The name of the structure, such as Heavy Turret.
  - key: attacker
    type: Object
    notes: An object conforming to the [Attacker](../classes/attacker.html) class.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "tribeId": "e188c013-12b7-5877-8af5-0c284fe8250e",
  "structureName": "Bookshelf",
  "attacker": {
    "kind": "player",
    "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
    "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
    "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
  }
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
