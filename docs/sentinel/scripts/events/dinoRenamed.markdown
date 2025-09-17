---
title: Dino Renamed
parent: Events
grand_parent: Scripts
description: "A dino has been renamed."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the dino that was renamed.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that renamed the dino.
  - key: oldDinoName
    type: String
    notes: The name of the dino before it was changed. May be empty.
  - key: newDinoName
    type: String
    notes: The new dino name. May be empty.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "oldDinoName": "Trash Fire",
  "newDinoName": "Gloriously Timothy"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
