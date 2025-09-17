---
title: Dino Uploaded
parent: Events
grand_parent: Scripts
description: "A dino was uploaded to a transmitted, obelisk, loot drop, or similar."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the dino that was uploaded.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the dino belongs to.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
