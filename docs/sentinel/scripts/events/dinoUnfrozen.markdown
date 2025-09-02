---
title: Dino Unfrozen
parent: Events
grand_parent: Scripts
description: "A dino has been released from a cryopod. This event is expected to execute for modded cryopods as well."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the dino that was released.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that released the dino.
  - key: hasCryoSickness
    type: Boolean
    notes: True if the dino had cryosickness when released.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that released the dino.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "hasCryoSickness": false,
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
