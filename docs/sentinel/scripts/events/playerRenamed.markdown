---
title: Survivor Renamed
parent: Events
grand_parent: Scripts
description: "A survivor has been renamed."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player whose survivor was renamed.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that was renamed.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
  - key: oldName
    type: String
    notes: The survivor's old name.
  - key: newName
    type: String
    notes: The survivor's new name.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "oldName": "Bicurious Llama",
  "newName": "Carbonated Paint"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
