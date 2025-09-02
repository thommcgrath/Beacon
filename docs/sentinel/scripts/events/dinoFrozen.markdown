---
title: Dino Frozen
parent: Events
grand_parent: Scripts
description: "A dino was placed into a cryopod. This event is expected to execute for modded cryopods as well."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the dino that was cryopodded.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that cryopodded the dino.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "61081761-d7eb-59bc-9f74-c6c13f183133",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
